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
                    .onTapGesture { // Long Press 보다 위에
                        viewModel.todoInputViewModel = TodoInputViewModel(
                            isPresentedTodoInputView: $viewModel.isPresentedTodoInputView,
                            isUpdated: viewModel.isUpdated
                        )
                        
                        viewModel.todoInputViewModel?.id = todoItem.id.wrappedValue
                        viewModel.todoInputViewModel?.title = todoItem.title.wrappedValue
                        viewModel.todoInputViewModel?.location = todoItem.location.wrappedValue
                        viewModel.todoInputViewModel?.description = todoItem.description.wrappedValue
                        viewModel.todoInputViewModel?.timeStemp = todoItem.timeStamp.wrappedValue
                        
                        viewModel.isPresentedTodoInputView = true
                    }
                    .onLongPressGesture {
                        viewModel.isShowDeleteAlert = (true, todoItem.wrappedValue)
                    }
                
            } // List
            .onAppear {
                viewModel.fetchTodoList()
            }
            
            .toolbar {
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    
                    Button {
                        viewModel.todoInputViewModel = TodoInputViewModel(
                            isPresentedTodoInputView: $viewModel.isPresentedTodoInputView,
                            isUpdated: viewModel.isUpdated
                        )
                        
                        viewModel.isPresentedTodoInputView = true
                        
                    } label: {
                        Image(systemName: "plus")
                    }
                    
                }
                
            }
            
        } // NavigationView
        .sheet(isPresented: $viewModel.isPresentedTodoInputView) {
            if let todoInputViewModel = viewModel.todoInputViewModel {
                TodoInputView(viewModel: todoInputViewModel)
            }
        }
        .alert("정말로 삭제할까요?", isPresented: $viewModel.isShowDeleteAlert.isShow) {
            Button("Cancel", role: .cancel) {
                viewModel.isShowDeleteAlert.isShow = false
            }
            Button("OK") {
                guard let deleteItem = viewModel.isShowDeleteAlert.item else {
                    return
                }
                viewModel.deleteTodoItem(item: deleteItem)
            }
        } message: {
            Text("삭제되면 복구할 수 없습니다.")
        }
        
    }
    
}

struct TodoListView_Previews: PreviewProvider {
    static var previews: some View {
        TodoListView(viewModel: TodoListViewModel())
    }
}
