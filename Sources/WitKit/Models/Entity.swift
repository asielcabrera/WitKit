//
//  Entity.swift
//  
//
//  Created by Asiel Cabrera Gonzalez on 12/7/21.
//

import Foundation

public struct Entity: Codable {
    var id: String
    var name: String
    var role: String
    var start: Int
    var end: Int
    var body: String
    var confidence: Double
    var entities: [String?: [Entity]?]
}
