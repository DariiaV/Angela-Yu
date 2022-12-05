//
//  StorageManager.swift
//  Todoey
//
//  Created by Дария Григорьева on 05.12.2022.
//

import Foundation

// MARK: - Manager UserDefaults
class StorageManager {
    static let shared = StorageManager()
    private let userDefaults = UserDefaults.standard
    private let key = "items"
    
    private init() {}
    
    func save(item: Item) {
        var items = fetchItems()
        items.append(item)
        
        setNewItems(items: items)
    }
    
    func setNewItems(items: [Item]) {
        guard let data = try? JSONEncoder().encode(items) else {
            return
        }
        
        userDefaults.set(data, forKey: key)
    }
    
    func fetchItems() -> [Item] {
        guard let data = userDefaults.object(forKey: key) as? Data else {
            return []
        }
        
        guard let items = try? JSONDecoder().decode([Item].self, from: data) else {
            return []
        }
        
        return items
    }
    
    func deleteItem(at index: Int) {
        var items = fetchItems()
        items.remove(at: index)
        
        guard let data = try? JSONEncoder().encode(items) else {
            return
        }
        
        userDefaults.set(data, forKey: key)
    }
}
