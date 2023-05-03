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
    @Published var isShowDeleteAlert: (isShow: Bool, item: ToDoItem?) = (false, nil)
    @Published var willDeletedItem: ToDoItem?
    
    var isUpdated: PassthroughSubject<Void, Never> = PassthroughSubject()
    
    var todoInputViewModel: TodoInputViewModel?
    
    private var disposeBag: Set<AnyCancellable> = Set()
    
    init() {
        bind()
    }
    
    func fetchTodoList() {
        todoList = ToDoManager.shared.read()
    }
    
    func deleteTodoItem(item: ToDoItem) {
        ToDoManager.shared.delete(item)
        isUpdated.send(())
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
