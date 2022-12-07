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
        if sender.selectedSegmentIndex == 0 {
            print("fisrt")
            //            taskLists = self.taskLists.sorted(byKeyPath: "name")
        } else {
            print("second")
            //            taskLists = self.taskLists.sorted(byKeyPath: "date")
        }
        tableView.reloadData()
    }
    
    private func showAlert() {
        let alert = UIAlertController.createAlert(withTitle: "New Task", andMessage: "What do you want to do?")
        
        alert.action(with: nil) { newValue in
            self.save(taskList: newValue)
        }
        
        present(alert, animated: true)
    }
   
    
    private func save(taskList: String) {
        let taskList = TaskList(value: [taskList])
        StorageManager.shared.save(taskList: taskList)
        let rowIndex = IndexPath(row: taskLists.count - 1, section: 0)
        tableView.insertRows(at: [rowIndex], with: .automatic)
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
        taskLists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
        let taskList = taskLists[indexPath.row]
        cell.textLabel?.text = taskList.name
        
        cell.accessoryView = createLabelForCell(text: "\(taskList.tasks.count)")
        return cell
    }
    
    private func createLabelForCell(text: String) -> UILabel {
        let label = UILabel.init(frame: CGRect(x:0, y:0, width:100, height:20))
        label.text = text
        label.textAlignment = .right
        label.textColor = .gray
        return label
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
}
