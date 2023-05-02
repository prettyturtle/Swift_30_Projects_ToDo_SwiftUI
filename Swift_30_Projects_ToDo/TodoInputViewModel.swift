//
//  TodoInputViewModel.swift
//  Swift_30_Projects_ToDo
//
//  Created by yc on 2023/05/02.
//

import SwiftUI
import Combine

final class TodoInputViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var location: String = ""
    @Published var description: String = ""
    @Published var timeStemp: Date = .now
    
    @Published var isPresentedTodoInputView: Binding<Bool>
    let isUpdated: PassthroughSubject<Void, Never>
    
    init(isPresentedTodoInputView: Binding<Bool>, isUpdated: PassthroughSubject<Void, Never>) {
        self.isPresentedTodoInputView = isPresentedTodoInputView
        self.isUpdated = isUpdated
    }
    
    private func isCheck() -> Bool {
        return !(title == "" && location == "" && description == "")
    }
    
    func didTapSaveButton() {
        if !isCheck() { return }
        
        let todoItem = ToDoItem(
            title: title,
            description: description,
            location: location,
            timeStamp: timeStemp
        )
        
        ToDoManager.shared.create(todoItem)
        
        isUpdated.send(())
        
        dismiss()
    }
    
    func didTapCancelButton() {
        dismiss()
    }
    
    private func dismiss() {
        isPresentedTodoInputView.wrappedValue = false
    }
}
