//
//  StorageManager.swift
//  ToDoListRealmApp
//
//  Created by Дария Григорьева on 07.12.2022.
//

import RealmSwift

class StorageManager {
    static let shared = StorageManager()
    let realm = try! Realm()
    
    private init() {}
    
    // MARK: - Task List
    func save(_ taskLists: [TaskList]) {
        write {
            realm.add(taskLists)
        }
    }
    
    func save(_ taskList: TaskList) {
        write {
            realm.add(taskList)
        }
    }
    
    func delete<T>(_ taskList: T) {
        write {
            if let objectToDelete = taskList as? TaskList {
                realm.delete(objectToDelete.tasks)
                realm.delete(objectToDelete)
            } else if let objectToDelete = taskList as? Task {
                realm.delete(objectToDelete)
            }
        }
    }
    
    func edit<T>(_ taskList: T, newValue: String, newNote: String? = nil) {
        write {
            if let objectToEdit = taskList as? TaskList {
                objectToEdit.name = newValue
            } else if let objectToEdit = taskList as? Task {
                objectToEdit.name = newValue
                objectToEdit.note = newNote ?? ""
            }
        }
    }
    
    func done<T>(_ taskList: T) {
        write {
            if let objectToDone = taskList as? TaskList {
                objectToDone.tasks.setValue(true, forKey: "isComplete")
            } else if let objectToDone = taskList as? Task {
                objectToDone.isComplete.toggle()
            }
        }
    }
    
    // MARK: - Tasks
    func save(_ task: Task, to taskList: TaskList) {
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
