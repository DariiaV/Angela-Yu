//
//  TaskListViewController.swift
//  ToDoListRealmApp
//
//  Created by Дария Григорьева on 07.12.2022.
//

import UIKit

class TaskListViewController: UIViewController {
    
    // MARK: - Properties
    private let cellReuseIdentifier = "cell"
    private let array = ["First", "Second", "Third"]
    
    // MARK: - View
    private lazy var tableView = UITableView()
    private lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Date", "A-Z"])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(sortingList(_:)), for: .valueChanged)
        return segmentedControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupNavigationView()
        
    }

    private func setupNavigationView() {
        title = "Task List"
        let addButton = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addButtonPressed)
        )
        
        navigationItem.rightBarButtonItem = addButton
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    @objc private func addButtonPressed() {
//        showAlert()
    }
    
    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        tableView.tableHeaderView = segmentedControl
    }
    
    @objc private func sortingList(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            print("fisrt")
//            taskLists = self.taskLists.sorted(byKeyPath: "name")
        } else {
            print("second")
//            taskLists = self.taskLists.sorted(byKeyPath: "date")
        }
        tableView.reloadData()
    }
}

extension TaskListViewController: UITableViewDataSource {
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
        cell.textLabel?.text = array[indexPath.row]
        return cell
    }
    
}

extension TaskListViewController: UITableViewDelegate {
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let tasksVC = TasksViewController()
        tasksVC.taskListName = array[indexPath.row]
        navigationController?.pushViewController(tasksVC, animated: true)
        
    }
}
