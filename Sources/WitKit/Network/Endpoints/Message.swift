//
//  Message.swift
//  
//
//  Created by Asiel Cabrera Gonzalez on 12/7/21.
//

import Foundation

public enum Message {
    case basic(text: String)
    case withContext(text: String, context: String)
}


extension Message: Endpoint {
    
    public var path: String {
        return "message"
    }
    
    public var query: String {
        switch self {
            
            case .basic(let text):
                let message = text.replacingOccurrences(of: " ", with: "%20")
                return "q=\(message)"
            case .withContext(let text, let context):
                let message = text.replacingOccurrences(of: " ", with: "%20")
                return "q=\(message)&context=\(context)"
        }
    }
}
