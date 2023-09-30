//
//  todosApp.swift
//  todos
//
//  Created by Debasis Mandal on 23/09/23.
//

import FirebaseCore
import SwiftUI

@main
struct todosApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
