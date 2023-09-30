//
//  NewItemViewModel.swift
//  todos
//
//  Created by Debasis Mandal on 23/09/23.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class NewItemViewModel: ObservableObject {
    
    @Published var title = ""
    @Published var dueDate = Date()
    @Published var isShowAlert = false
//    @Published var currentUserId = ""
    
    init() {}
    
    func save() {
        // get current user ID
        guard let currentUserId = Auth.auth().currentUser?.uid else {
            return
        }
        
        insert(id: currentUserId)
    }
    
    var validate: Bool {
        guard !title.trimmingCharacters(in: .whitespaces).isEmpty else {
            return false
        }
        
        guard dueDate > Date().addingTimeInterval(-86400) else {
            return false
        }
        
        return true
    }
    
    func insert(id: String) {
        
        // create a model
        let newItemId = UUID().uuidString
        let newItem = TodoListItem(id: newItemId, title: title, dueDate: dueDate.timeIntervalSince1970, createdDate: Date().timeIntervalSince1970, isDone: false)
        
        let db = Firestore.firestore()
        
        // save model
        db.collection("users")
            .document(id)
            .collection("todos")
            .document(newItemId)
            .setData(newItem.asDictionary())
    }
}
