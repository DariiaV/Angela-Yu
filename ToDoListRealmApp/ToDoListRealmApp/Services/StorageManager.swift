//
//  StorageManager.swift
//  ToDoListRealmApp
//
//  Created by Дария Григорьева on 07.12.2022.
//

import RealmSwift

class StorageManager {
    static var shared = StorageManager()
    let realm = try! Realm()
    
    private init() {}
    
    // MARK: - Work with Task List
    func save(taskLists: [TaskList]) {
        write {
            realm.add(taskLists)
        }
    }
    func save(taskList: TaskList) {
        write {
            realm.add(taskList)
        }
    }
    
    // MARK: - Work with task
    
    func save(task: Task, in taskList: TaskList) {
        write {
            taskList.tasks.append(task)
        }
    }
    
    private func write(completion: () -> Void) {
        do {
            try realm.write {
                completion()
            }
        } catch {
            print(error)
        }
    }

}
