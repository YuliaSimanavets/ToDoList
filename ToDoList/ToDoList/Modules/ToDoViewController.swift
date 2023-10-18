//
//  ToDoViewController.swift
//  ToDoList
//
//  Created by Yuliya on 13/10/2023.
//

import UIKit

class ToDoViewController: UIViewController {

    private let plusButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let toDoTableView: UITableView = {
        let tableView = UITableView()
        tableView.style = .grouped

        tableView.backgroundColor = .systemYellow
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray4
        view.addSubview(toDoTableView)
        setupConstraints()
        
        navigationItem.title = "ToDo list"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: plusButton)
        plusButton.addTarget(self, action: #selector(tapPlusAction), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            toDoTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            toDoTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            toDoTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            toDoTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc
    func tapPlusAction() {
        
    }
}

