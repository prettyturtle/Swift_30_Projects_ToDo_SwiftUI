//
//  TodoListViewModel.swift
//  Swift_30_Projects_ToDo
//
//  Created by yc on 2023/05/02.
//

import Foundation
import Combine

final class TodoListViewModel: ObservableObject {
    @Published var todoList: [ToDoItem] = []
    @Published var isPresentedTodoInputView = false
    
    var isUpdated: PassthroughSubject<Void, Never> = PassthroughSubject()
    
    private var disposeBag: Set<AnyCancellable> = Set()
    
    init() {
        bind()
    }
    
    func fetchTodoList() {
        todoList = ToDoManager.shared.read()
    }
    
    private func bind() {
        isUpdated
            .print("[TodoListViewModel] bind() ::")
            .sink { _ in
                self.fetchTodoList()
            }
            .store(in: &disposeBag)
    }
}
