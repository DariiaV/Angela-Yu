//
//  UITableViewCell+Ext.swift
//  ToDoListRealmApp
//
//  Created by Дария Григорьева on 08.12.2022.
//

import UIKit

extension UITableViewCell {
    
    func configure(with taskList: TaskList) {
        let currentTasks = taskList.tasks.filter("isComplete = false")
        let completedTasks = taskList.tasks.filter("isComplete = true")
        
        textLabel?.text = taskList.name
        let text: String?
        if !currentTasks.isEmpty {
            text = "\(currentTasks.count)"
            accessoryType = .none
        } else if !completedTasks.isEmpty {
            text = nil
            accessoryType = .checkmark
        } else {
            accessoryType = .none
            text = "0"
        }
        accessoryView = createLabelForCell(text: text)
    }
    
    private func createLabelForCell(text: String?) -> UILabel? {
        guard let text else {
            return nil
        }
        
        let label = UILabel.init(frame: CGRect(x:0, y:0, width:100, height:20))
        label.text = text
        label.textAlignment = .right
        label.textColor = .gray
        return label
    }
}
