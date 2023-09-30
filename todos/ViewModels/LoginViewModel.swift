//
//  LoginViewModel.swift
//  todos
//
//  Created by Debasis Mandal on 23/09/23.
//

import FirebaseAuth
import Foundation

class LoginViewModel: ObservableObject {
    
    init() {}
    
    @Published var userEmail = ""
    @Published var userPassword = ""
    @Published var errorMessage = ""
    
    func login() {
        guard validate() else {
            return
        }
        
        Auth.auth().signIn(withEmail: userEmail, password: userPassword)
    }
    
    func validate() -> Bool {
        errorMessage = ""
        
        guard !userEmail.trimmingCharacters(in: .whitespaces).isEmpty && !userPassword.isEmpty else {
            errorMessage = "Please fill in all the fields."
            return false
        }
        
        guard userEmail.contains("@") && userEmail.contains(".") else {
            errorMessage = "Please enter a valid email."
            return false
        }
        
        return true
    }
}
