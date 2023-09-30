//
//  RegisterViewModel.swift
//  todos
//
//  Created by Debasis Mandal on 23/09/23.
//

import Foundation
import FirebaseAuth
import Firebase
import FirebaseCore
import FirebaseFirestore

class RegisterViewModel: ObservableObject {
    
    init() {}
    
    @Published var userName = ""
    @Published var userEmail = ""
    @Published var userPassword = ""
    @Published var errorMessage = ""
    
    func register() {
        guard validate() else {
            return
        }
        
        Auth.auth().createUser(withEmail: userEmail, password: userPassword) { [weak self] result, error in
            guard let userId = result?.user.uid else {
                return
            }
            
            self?.insertUserRecord(id: userId)
        }
    }
    
    func insertUserRecord(id: String) {
        let newUser = User(id: id, name: userName, email: userEmail, image: "cat", joined: Date().timeIntervalSince1970)
        
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(id)
            .setData(newUser.asDictionary())
    }
    
    func validate() -> Bool {
        errorMessage = ""
        guard !userName.trimmingCharacters(in: .whitespaces).isEmpty &&
                !userEmail.trimmingCharacters(in: .whitespaces).isEmpty &&
                !userPassword.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "Please fill in all the fields."
            return false
        }
        
        guard userEmail.contains("@") && userEmail.contains(".") else {
            errorMessage = "Please enter a valid email."
            return false
        }
        
        guard userPassword.count >= 6 else {
            errorMessage = "Password should be greater than 6 characters."
            return false
        }
        
        return true
    }
}
