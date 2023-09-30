//
//  Extensions.swift
//  todos
//
//  Created by Debasis Mandal on 24/09/23.
//

import Foundation

extension Encodable {
    func asDictionary() -> [String: Any] {
        guard let data = try? JSONEncoder().encode(self) else {
            return [:]
        }
        
        do {
            let jsonData = try JSONSerialization.jsonObject(with: data) as? [String: Any]
            return jsonData ?? [:]
        } catch {
            return [:]
        }
    }
}
