//
//  TodoListView.swift
//  Swift_30_Projects_ToDo
//
//  Created by yc on 2023/05/01.
//

import SwiftUI

struct TodoListView: View {
    
    @StateObject var viewModel: TodoListViewModel
    
    var body: some View {
        
        NavigationView {
            
            List($viewModel.todoList) { todoItem in
                
                TodoItemCell(todoItem: todoItem)
                    .listRowInsets(
                        EdgeInsets(
                            top: 0,
                            leading: 0,
                            bottom: 0,
                            trailing: 0
                        )
                    )
                
            } // List
            .onAppear {
                viewModel.fetchTodoList()
            }
            
            .toolbar {
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    
                    Button {
                        
                        viewModel.isPresentedTodoInputView = true
                        
                    } label: {
                        Image(systemName: "plus")
                    }
                    
                }
                
            }
            
        } // NavigationView
        .sheet(isPresented: $viewModel.isPresentedTodoInputView) {
            let todoInputViewModel = TodoInputViewModel(isPresentedTodoInputView: $viewModel.isPresentedTodoInputView, isUpdated: viewModel.isUpdated)
            TodoInputView(viewModel: todoInputViewModel)
        }
        
    }
    
}

struct TodoListView_Previews: PreviewProvider {
    static var previews: some View {
        TodoListView(viewModel: TodoListViewModel())
    }
}
