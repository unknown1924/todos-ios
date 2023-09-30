//
//  TodoListItemView.swift
//  todos
//
//  Created by Debasis Mandal on 23/09/23.
//

import SwiftUI

struct TodoListItemView: View {
    @StateObject var viewModel = TodoListItemViewModel()
    let item: TodoListItem
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.title)
                    .font(.title3)
                    .bold()
                
                Text("\(Date(timeIntervalSince1970: item.dueDate).formatted(date: .abbreviated, time: .shortened))")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
                Image(systemName: item.isDone ? "checkmark.circle.fill" : "circle")
                    .font(.largeTitle)
                    .foregroundStyle(.blue)
                    .contentTransition(.symbolEffect(.replace))
                    .frame(width: 44, height: 44)
                    .onTapGesture {
                        viewModel.toggleDone(item: item)
                    }
        }
    }
}

#Preview {
    TodoListItemView(item: TodoListItem(id: "1", title: "Get Milk!", dueDate: Date().timeIntervalSince1970, createdDate: Date().timeIntervalSince1970, isDone: true))
}
