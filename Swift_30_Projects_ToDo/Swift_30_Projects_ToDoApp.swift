//
//  Swift_30_Projects_ToDoApp.swift
//  Swift_30_Projects_ToDo
//
//  Created by yc on 2023/05/01.
//

import SwiftUI

@main
struct Swift_30_Projects_ToDoApp: App {
    var body: some Scene {
        WindowGroup {
            let todoListViewModel = TodoListViewModel()
            TodoListView(viewModel: todoListViewModel)
        }
    }
}
