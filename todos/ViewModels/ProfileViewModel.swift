//
//  ProfileViewModel.swift
//  todos
//
//  Created by Debasis Mandal on 23/09/23.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class ProfileViewModel: ObservableObject {
    
    @Published var currentUser: User? = nil
    @Published var image: String = ""
    
    let db = Firestore.firestore()
    
    func fetchUser() {
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        
        db.collection("users")
            .document(userId)
            .getDocument { snapshot, error in
                guard let data = snapshot?.data(), error == nil else {
                    return
                }
                
                DispatchQueue.main.async {
                    self.currentUser = User(id: data["id"] as? String ?? "",
                                            name: data["name"] as? String ?? "",
                                            email: data["email"] as? String ?? "",
                                            image: data["image"] as? String ?? "",
                                            joined: data["joined"] as? TimeInterval ?? 0)
                }
            }
    }
    
    func updateImage() {
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        
        db.collection("users")
            .document(userId)
            .updateData(["image": image]) {
                err in
                if let err = err {
                    print("Error: \(err)")
                } else {
                    print("Success")
                }
            }
    }
    
    func logout() {
        do {
            try Auth.auth().signOut()
        } catch {
            print(error)
        }
    }
}
