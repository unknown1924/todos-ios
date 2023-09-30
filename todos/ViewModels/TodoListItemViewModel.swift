//
//  TodoListItemViewModel.swift
//  todos
//
//  Created by Debasis Mandal on 23/09/23.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

/// viewmodel for a single todo list item
class TodoListItemViewModel: ObservableObject {
    
    init() {}
    
    func toggleDone(item: TodoListItem) {
        var newItem = item
        newItem.markDone(!item.isDone)
        
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(userId)
            .collection("todos")
            .document(newItem.id)
            .setData(newItem.asDictionary())
    }
    
}
