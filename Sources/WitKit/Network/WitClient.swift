//
//  WitClient.swift
//  
//
//  Created by Asiel Cabrera Gonzalez on 12/7/21.
//

import Foundation

public class WitClient: WitAPIClient {
    public var session: URLSession
    private var token: String
    
    public init(token: String) {
        self.token = token
        self.session = .shared
    }
    
    public func message(_ message: Message, completion: @escaping (WitResult<WitMessage?, WitNetworkError>) -> Void) {
        fetch(with: message.request(token: token, witVersion: "20211206"), decode:  { data -> WitMessage? in
            guard let message = data as? WitMessage else { return nil }
            return message
        }, completion: completion)
    }
    
    public func messageAsync<T:Decodable>(_ message: Message) -> Future<T> {
        session.request(urlRequest: message.request(token: token, witVersion: "20211206"))
            .decoded(as: T.self, using: .init())
    }
}
