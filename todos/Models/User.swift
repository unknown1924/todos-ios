//
//  User.swift
//  todos
//
//  Created by Debasis Mandal on 23/09/23.
//

import Foundation

struct User: Codable {
    let id: String
    let name: String
    let email: String
    var image: String
    let joined: TimeInterval
}
