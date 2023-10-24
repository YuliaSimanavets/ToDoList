//
//  EntryViewController.swift
//  ToDoList
//
//  Created by Yuliya on 19/10/2023.
//

import UIKit

class CreateTaskViewController: UIViewController,
                                UITextFieldDelegate {
    
    private let textField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 10
        textField.placeholder = "Enter your task ..."
        textField.font = UIFont.systemFont(ofSize: 18)
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.contentVerticalAlignment = .center
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    var update: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray5
        view.addSubview(textField)
        textField.delegate = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveTask))
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            textField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        saveTask()
        return true
    }
    
    @objc
    func saveTask() {
        guard let text = textField.text, !text.isEmpty else { return }
        guard let count = UserDefaults().value(forKey: "count") as? Int else { return }
        let newCount = count + 1
        UserDefaults().set(newCount, forKey: "count")
        UserDefaults().set(text, forKey: "task_\(newCount)")
        update?()
        navigationController?.popViewController(animated: true)
    }
}
