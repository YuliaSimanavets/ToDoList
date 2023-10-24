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
//    let doneMark: Bool
}

class ToDoTableViewCell: UITableViewCell {
    
    static var identifier: String {
        return String(describing: ToDoTableViewCell.self)
    }
    
    private let cellView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let taskLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let doneMarkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "circle")
//        imageView.image = UIImage(systemName: "checkmark.circle.fill")
        imageView.tintColor = .systemGreen
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .clear
        addSubview(cellView)
        cellView.addSubview(taskLabel)
        cellView.addSubview(doneMarkImageView)
        
        NSLayoutConstraint.activate([
            cellView.topAnchor.constraint(equalTo: topAnchor),
            cellView.leadingAnchor.constraint(equalTo: leadingAnchor),
            cellView.trailingAnchor.constraint(equalTo: trailingAnchor),
            cellView.bottomAnchor.constraint(equalTo: bottomAnchor),
            cellView.heightAnchor.constraint(equalToConstant: 50),
            
            taskLabel.centerXAnchor.constraint(equalTo: cellView.centerXAnchor),
            taskLabel.centerYAnchor.constraint(equalTo: cellView.centerYAnchor),
            taskLabel.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 10),
            taskLabel.trailingAnchor.constraint(equalTo: doneMarkImageView.leadingAnchor, constant: -10),
            taskLabel.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 10),
            taskLabel.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -10),
            
            doneMarkImageView.centerYAnchor.constraint(equalTo: taskLabel.centerYAnchor),
            doneMarkImageView.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -10),
            doneMarkImageView.heightAnchor.constraint(equalToConstant: 35),
            doneMarkImageView.widthAnchor.constraint(equalToConstant: 35)
        ])
    }

    func set(_ data: ToDoViewModel) {
        taskLabel.text = data.toDoTaskText
//        if data.doneMark {
//            doneMarkImageView.image = UIImage(systemName: "checkmark.circle.fill")
//            doneMarkImageView.tintColor = .systemGreen
//        } else {
//            doneMarkImageView.image = UIImage(systemName: "circle")
//        }
    }
}
