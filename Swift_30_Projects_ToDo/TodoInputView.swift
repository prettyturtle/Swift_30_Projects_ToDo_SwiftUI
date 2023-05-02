//
//  TodoInputView.swift
//  Swift_30_Projects_ToDo
//
//  Created by yc on 2023/05/01.
//

import SwiftUI
import Combine

struct TodoInputView: View {
    
    @ObservedObject var viewModel: TodoInputViewModel
    
    var body: some View {
        
        VStack {
            
            Group {
                TextField("제목을 입력하세요...", text: $viewModel.title)
                TextField("장소를 입력하세요...", text: $viewModel.location)
                TextField("설명을 입력하세요...", text: $viewModel.description)
                
            } // Group
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray.opacity(0.4), lineWidth: 1)
            )
            .padding(.horizontal)
            
            Spacer()
                .frame(height: 48)
            
            Text("Date")
                .bold()
            
            DatePicker(
                "",
                selection: $viewModel.timeStemp,
                displayedComponents: [.date]
            )
            .datePickerStyle(.wheel)
            .labelsHidden()
            
            HStack {
                
                Button {
                    viewModel.didTapCancelButton()
                } label: {
                    Text("Cancel")
                        .foregroundColor(.red)
                }
                
                Spacer()
                
                Button {
                    viewModel.didTapSaveButton()
                } label: {
                    Text("Save")
                        .foregroundColor(.blue)
                }
                
            } // HStack
            
        } // VStack
        .fixedSize()
        
    } // body
    
}

struct TodoInputView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = TodoInputViewModel(isPresentedTodoInputView: .constant(false), isUpdated: PassthroughSubject<Void, Never>())
        TodoInputView(viewModel: viewModel)
    }
}
