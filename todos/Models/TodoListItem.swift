//
//  TodoListItem.swift
//  todos
//
//  Created by Debasis Mandal on 23/09/23.
//

import Foundation

struct TodoListItem: Codable, Identifiable {
    let id: String
    let title: String
    let dueDate: TimeInterval
    let createdDate: TimeInterval
    var isDone: Bool
    
    mutating func markDone(_ state: Bool) {
        isDone = state
    }
}
