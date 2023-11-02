//
//  ToDoTableViewCell.swift
//  ToDoList
//
//  Created by Yuliya on 18/10/2023.
//

import Foundation
import UIKit

struct ToDoViewModel {
    let toDoTaskText: String
    let checked: Bool
}

class ToDoTableViewCell: UITableViewCell {

    static var identifier: String {
        return String(describing: ToDoTableViewCell.self)
    }

    private let taskLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let checkBox = Checkbox()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        backgroundColor = .white
        addSubview(taskLabel)
        addSubview(checkBox)

        checkBox.addTarget(self, action: #selector(checked), for: .touchUpInside)

        NSLayoutConstraint.activate([
            taskLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            taskLabel.trailingAnchor.constraint(equalTo: centerXAnchor),
            taskLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            taskLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            taskLabel.heightAnchor.constraint(equalToConstant: 20),

            checkBox.centerYAnchor.constraint(equalTo: taskLabel.centerYAnchor),
            checkBox.leadingAnchor.constraint(equalTo: centerXAnchor, constant: 10),
            checkBox.heightAnchor.constraint(equalToConstant: 50),
            checkBox.widthAnchor.constraint(equalToConstant: 50)
        ])
    }

    func set(_ data: ToDoViewModel) {
        taskLabel.text = data.toDoTaskText
        set(checked: data.checked)
        updateChecked()
    }

    private func updateChecked() {
        let attributedString = NSMutableAttributedString(string: taskLabel.text!)

        if checkBox.checked {
            attributedString.addAttribute(.strikethroughStyle, value: 2, range: NSMakeRange(0, attributedString.length-1))
        } else {
            attributedString.removeAttribute(.strikethroughStyle, range: NSMakeRange(0, attributedString.length-1))
        }
    }

    @objc
    func checked() {
        updateChecked()
    }
    
    func set(checked: Bool) {
        checkBox.checked = checked
        updateChecked()
    }
}
