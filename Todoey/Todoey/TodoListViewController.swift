//
//  TodoListViewController.swift
//  Todoey
//
//  Created by Дария Григорьева on 01.12.2022.
//

import UIKit

class TodoListViewController: UIViewController {
    
    private let tableView = UITableView()
    private let cellReuseIdentifier = "cell"
    private var itemArray = [
        "Купить хлопья",
        "Купить гречу",
        "Купить рис",
        "Купить молоко",
        "Купить мандарины"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
       
        setupTableView()
        setupNavigationView()
        
    }
    private func setupNavigationView() {
        title = "Todo List"
        let rightItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(rightButtonItemTapped))
        rightItem.tintColor = .black
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

    @objc private func rightButtonItemTapped() {
        let alertVC = UIAlertController(title: "Add New Todo List Item", message: nil, preferredStyle: .alert)
        alertVC.addTextField { textField in
            textField.placeholder = "Create new item"
        }
        let action = UIAlertAction(title: "Add Item", style: .default) { _ in
            if let text = alertVC.textFields?.first?.text {
                self.itemArray.append(text)
                self.tableView.insertRows(at: [IndexPath(row: self.itemArray.count - 1, section: 0)], with: .automatic)
            }
        }
        alertVC.addAction(action)
        present(alertVC, animated: true)
    }
}

extension TodoListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        itemArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    
    
}

extension TodoListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let cell = tableView.cellForRow(at: indexPath)
        if cell?.accessoryType == .checkmark {
            cell?.accessoryType = .none
        } else {
            cell?.accessoryType = .checkmark
        }
    }
}
