//
//  TodoListViewControllerCoreData.swift
//  Todoey
//
//  Created by Дария Григорьева on 05.12.2022.
//

import UIKit

// core data
class TodoListViewControllerCoreData: UIViewController {
    
    private let tableView = UITableView()
    private let cellReuseIdentifier = "cell"
    private var itemArray = [Item]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupTableView()
        setupNavigationView()
        
    }
    
    private func setupNavigationView() {
        title = "Todo List"
        
        let rightItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(rightButtonItemTapped))
        rightItem.tintColor = .white
        navigationItem.rightBarButtonItem = rightItem
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    // MARK: - Add New Items
    
    @objc private func rightButtonItemTapped() {
        let alertVC = UIAlertController(title: "Add New Todo List Item", message: nil, preferredStyle: .alert)
        alertVC.addTextField { textField in
            textField.placeholder = "Create new item"
        }
        let action = UIAlertAction(title: "Add Item", style: .default) { _ in
            if let text = alertVC.textFields?.first?.text {
                let newItem = Item(title: text)
                self.itemArray.append(newItem)
                
               // self.storageManager.save(item: newItem)
                self.tableView.insertRows(at: [IndexPath(row: self.itemArray.count - 1, section: 0)], with: .automatic)
            }
        }
        alertVC.addAction(action)
        present(alertVC, animated: true)
    }
}

// MARK: - TableView Data Source Methods

extension TodoListViewControllerCoreData: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        itemArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row].title
        if itemArray[indexPath.row].done {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    
}

// MARK: - TableView Delegate Methods

extension TodoListViewControllerCoreData: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        itemArray[indexPath.row].done.toggle()
        //storageManager.setNewItems(items: itemArray)
        let cell = tableView.cellForRow(at: indexPath)
        
        if cell?.accessoryType == .checkmark {
            cell?.accessoryType = .none
        } else {
            cell?.accessoryType = .checkmark
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            itemArray.remove(at: indexPath.row)
          //  storageManager.deleteItem(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
