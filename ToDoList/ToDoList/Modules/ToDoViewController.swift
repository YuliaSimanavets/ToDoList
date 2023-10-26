//
//  ToDoViewController.swift
//  ToDoList
//
//  Created by Yuliya on 13/10/2023.
//

import UIKit

class ToDoViewController: UIViewController {
    
    private let addTaskButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let toDoTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
        
    private var tasksArray: [ToDoViewModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray5
        view.addSubview(toDoTableView)
        
        toDoTableView.delegate = self
        toDoTableView.dataSource = self
        toDoTableView.register(ToDoTableViewCell.self,
                               forCellReuseIdentifier: ToDoTableViewCell.identifier)
        
        navigationItem.title = "ToDo list"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: addTaskButton)
        addTaskButton.addTarget(self, action: #selector(didTapAddAction), for: .touchUpInside)
        
        if !UserDefaults().bool(forKey: "setup") {
            UserDefaults().set(true, forKey: "setup")
            UserDefaults().set(0, forKey: "count")
        }
        
        setupConstraints()
        updateTasks()
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
    func didTapAddAction() {
        let viewController = CreateTaskViewController()
        viewController.title = "New task"
        navigationController?.pushViewController(viewController, animated: true)
        viewController.update = {
            DispatchQueue.main.async {
                self.updateTasks()
            }
        }
    }
    
    private func updateTasks() {
        tasksArray.removeAll()
        guard let count = UserDefaults().value(forKey: "count") as? Int else { return }
        for x in 0..<count {
            if let task = UserDefaults().value(forKey: "task_\(x+1)") as? String {
                let myTask = ToDoViewModel(toDoTaskText: task)
                tasksArray.append(myTask)
            }
        }
        toDoTableView.reloadData()
    }
}

extension ToDoViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasksArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ToDoTableViewCell.identifier, for: indexPath) as? ToDoTableViewCell else {
            return UITableViewCell()
        }
        cell.textLabel?.text = tasksArray[indexPath.row].toDoTaskText
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            let deleteTask = tasksArray[indexPath.row]
            tasksArray.remove(at: indexPath.row)
            toDoTableView.deleteRows(at: [indexPath], with: .fade)

            if let count = UserDefaults().value(forKey: "count") as? Int {
                for i in 0..<count {
                    if let task = UserDefaults().value(forKey: "task_\(i+1)") as? String, task == deleteTask.toDoTaskText {
                        UserDefaults().removeObject(forKey: "task_\(i+1)")
                        UserDefaults().synchronize()
                        break
                    }
                }
                UserDefaults().set(count - 1, forKey: "count")
            }
        }
    }
}

extension ToDoViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        toDoTableView.deselectRow(at: indexPath, animated: true)
    }
}

