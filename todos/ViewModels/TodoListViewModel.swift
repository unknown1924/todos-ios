//
//  TodoListViewModel.swift
//  todos
//
//  Created by Debasis Mandal on 23/09/23.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

/// viewmodel for list of todo list items
class TodoListViewModel: ObservableObject {
    @Published var showNewItemView: Bool = false
    let userId: String
    
    init(userId: String) {
        self.userId = userId
    }
    
    func delete(id: String) {
        // delete from firebase
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(userId)
            .collection("todos")
            .document(id)
            .delete()
    }
}
