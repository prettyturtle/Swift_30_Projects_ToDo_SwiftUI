//
//  TodoItemCell.swift
//  Swift_30_Projects_ToDo
//
//  Created by yc on 2023/05/02.
//

import SwiftUI

struct TodoItemCell: View {
    
    @Binding var todoItem: ToDoItem
    
    var body: some View {
        
        HStack {
            
            Group {
                Spacer()
            } // Group
            
            Text(todoItem.title)
            
            Group {
                Spacer()
                Divider()
                Spacer()
            } // Group
            
            Text(todoItem.location)
            
            Group {
                Spacer()
                Divider()
                Spacer()
            } // Group
            
            Text(todoItem.description)
            
            Group {
                Spacer()
            } // Group
            
        } // HStack
        .onLongPressGesture {
            ToDoManager.shared.delete(todoItem)
        }
        
    }
    
}

struct TodoItemCell_Previews: PreviewProvider {
    static var previews: some View {
        TodoItemCell(todoItem: .constant(ToDoItem(title: "title", description: "description", location: "location", timeStamp: .now)))
    }
}
