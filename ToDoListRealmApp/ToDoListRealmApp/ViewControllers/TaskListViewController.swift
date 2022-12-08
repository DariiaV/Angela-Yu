//
//  TaskListViewController.swift
//  ToDoListRealmApp
//
//  Created by Дария Григорьева on 07.12.2022.
//

import RealmSwift

class TaskListViewController: UIViewController {
    
    
    // MARK: - Properties
    private let cellReuseIdentifier = "cell"
    private var taskLists = StorageManager.shared.realm.objects(TaskList.self)
    
    
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
        createTempData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        tableView.setEditing(editing, animated: true)
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
        showAlert()
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
        if sender.selectedSegmentIndex == 1 {
            taskLists = taskLists.sorted(byKeyPath: "name")
        } else {
            taskLists = taskLists.sorted(byKeyPath: "date")
        }
        
        self.tableView.reloadData()
        
        
    }
    
    private func showAlert(with taskList: TaskList? = nil, completion: (() -> Void)? = nil) {
        let title = taskList != nil ? "Edit List" : "New List"
        
        let alert = UIAlertController.createAlert(withTitle: title,
                                                  andMessage: "Please set title for new task list?")
        
        alert.action(with: taskList) { newValue in
            if let taskList = taskList, let completion = completion{
                StorageManager.shared.edit(taskList, newValue: newValue)
                completion()
            } else {
                self.save(taskList: newValue)
            }
        }
        
        present(alert, animated: true)
    }
    
    
    private func save(taskList: String) {
        let task = TaskList(value: [taskList])
        StorageManager.shared.save(task)
        if let index = taskLists.firstIndex(where: {$0.name == taskList}) {
            let rowIndex = IndexPath(row: index, section: 0)
            tableView.insertRows(at: [rowIndex], with: .automatic)
        }
    }
    
    private func createTempData() {
        DataManager.shared.createTempData {
            self.tableView.reloadData()
        }
    }
}

extension TaskListViewController: UITableViewDataSource {
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskLists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
        
        let taskList = taskLists[indexPath.row]
        cell.configure(with: taskList)
        return cell
    }
    
}

extension TaskListViewController: UITableViewDelegate {
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let taskList = taskLists[indexPath.row]
        let tasksVC = TasksViewController(taskList: taskList)
        
        navigationController?.pushViewController(tasksVC, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let taskList = taskLists[indexPath.row]
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, _ in
            StorageManager.shared.delete(taskList)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        let editAction = UIContextualAction(style: .normal, title: "Edit") { _, _, isDone in
            self.showAlert(with: taskList) {
                self.tableView.reloadRows(at: [indexPath], with: .automatic)
            }
            isDone(true)
        }
        let doneAction = UIContextualAction(style: .normal, title: "Done") { _, _, isDone in
            StorageManager.shared.done(taskList)
            tableView.reloadRows(at: [indexPath], with: .automatic)
            isDone(true)
        }
        editAction.backgroundColor = .orange
        doneAction.backgroundColor = .systemGreen
        
        return UISwipeActionsConfiguration(actions: [doneAction, editAction, deleteAction])
    }
}
