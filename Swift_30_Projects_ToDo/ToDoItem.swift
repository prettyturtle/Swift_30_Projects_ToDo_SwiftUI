//
//  ToDoItem.swift
//  Swift_30_Projects_ToDo
//
//  Created by yc on 2023/05/01.
//

import Foundation

struct ToDoItem: Codable, Identifiable, Equatable {
    var id: String = UUID().uuidString
    var title: String
    var description: String
    var location: String
    var timeStamp: Date
    
    static func == (_ rhs: Self, _ lhs: Self) -> Bool {
        return rhs.id == lhs.id
    }
}

protocol ToDo {
    func create(_ item: ToDoItem)
    func read() -> [ToDoItem]
    func update(_ item: ToDoItem)
    func delete(_ item: ToDoItem)
}

struct ToDoManager: ToDo {
    
    static let shared = ToDoManager()
    
    private let userDefaultsManager = UserDefaultsManager<ToDoItem>()
    
    func create(_ item: ToDoItem) {
        userDefaultsManager.create(item)
    }
    
    func read() -> [ToDoItem] {
        return userDefaultsManager.read()
    }
    
    func update(_ item: ToDoItem) {
        userDefaultsManager.update(item)
    }
    
    func delete(_ item: ToDoItem) {
        userDefaultsManager.delete(item)
    }
}

struct UserDefaultsManager<T: Codable & Equatable> {
    
    private let key = "TODO_ITEMS"
    
    func read() -> [T] {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            return []
        }
        
        let decoder = JSONDecoder()
        
        do {
            let items = try decoder.decode([T].self, from: data)
            
            return items
        } catch {
            return []
        }
    }
    
    func create(_ item: T) {
        
        var items = read()
        
        items.append(item)
        
        saveAll(items)
    }
    
    func update(_ item: T) {
        var items = read()
        
        if let idx = items.firstIndex(where: { $0 == item }) {
            items[idx] = item
        }
        
        saveAll(items)
    }
    
    func delete(_ item: T) {
        var items = read()
        
        items = items.filter { $0 != item }
        
        saveAll(items)
    }
    
    private func saveAll(_ items: [T]) {
        let encoder = JSONEncoder()
        
        do {
            let data = try  encoder.encode(items)
            
            UserDefaults.standard.setValue(data, forKey: key)
        } catch {
            print("ERROR : \(error.localizedDescription)")
        }
    }
}
