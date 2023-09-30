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
    
    init() {}
    
    let db = Firestore.firestore()
    
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
    
    func insert(id: String, newItemId: String = UUID().uuidString) {
        
        // create a model
//        let newItemId = UUID().uuidString
        let newItem = TodoListItem(id: newItemId, title: title, dueDate: dueDate.timeIntervalSince1970, createdDate: Date().timeIntervalSince1970, isDone: false)
        
        // save model
        db.collection("users")
            .document(id)
            .collection("todos")
            .document(newItemId)
            .setData(newItem.asDictionary())
    }
    
    func fetch(itemId: String) {
        var item = NewItemViewModel()
        
        guard let currentUserId = Auth.auth().currentUser?.uid else {
            return
        }
        
        
        db.collection("users")
            .document(currentUserId)
            .collection("todos")
            .document(itemId)
            .getDocument { docuement, error in
                guard let data = docuement?.data(), error == nil else {
                    return
                }
                
                self.title = data["title"] as? String ?? ""
                self.dueDate = data["dueDate"] as? Date ?? Date()
            }
    }
    
    func update(itemId: String) {
        guard let currentUserId = Auth.auth().currentUser?.uid else {
            return
        }
        
        // Delete
        db.collection("users")
            .document(currentUserId)
            .collection("todos")
            .document(itemId)
            .delete()
        
        // Save
        insert(id: currentUserId, newItemId: itemId)
    }
}
