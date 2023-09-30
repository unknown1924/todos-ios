//
//  TodoListItemsView.swift
//  todos
//
//  Created by Debasis Mandal on 23/09/23.
//

import SwiftUI
import FirebaseFirestoreSwift

struct TodoListView: View {
    
    @StateObject var viewModel: TodoListViewModel
    @FirestoreQuery var items: [TodoListItem]
    @State private var searchTerm = ""
    
    var filteredItems: [TodoListItem] {
        guard !searchTerm.isEmpty else { return items }
        return items.filter { $0.title.localizedCaseInsensitiveContains(searchTerm) }
    }
    
    init(userId: String) {
        self._items = FirestoreQuery(collectionPath: "users/\(userId)/todos")
        self._viewModel = StateObject(wrappedValue: TodoListViewModel(userId: userId))
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                List(filteredItems) { item in
                    TodoListItemView(item: item)
                        .swipeActions {
                            Button("Delete") {
                                viewModel.delete(id: item.id)
                            }
                            .tint(.red)
                        }
                }
            }
            .navigationTitle("Todos")
            .searchable(text: $searchTerm, prompt: "Search your todos")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        viewModel.showNewItemView = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $viewModel.showNewItemView) {
                NewItemView(showNewItemView: $viewModel.showNewItemView)
            }
        }
    }
}

#Preview {
        TodoListView(userId: "GZd9tP8RSTfH3nF9fanhJzr6N2c2")
}
