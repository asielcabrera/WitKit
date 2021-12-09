//
//  WitMessage.swift
//  
//
//  Created by Asiel Cabrera Gonzalez on 12/7/21.
//

import Foundation

public struct WitMessage: Decodable {
    public let text: String
    public let intents: [Intent]
    public let entities: [String: [Entity]]
    public let traits: Trait
}
