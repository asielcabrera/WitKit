//
//  Speech.swift
//  
//
//  Created by Asiel Cabrera Gonzalez on 12/15/21.
//

import Foundation

public enum Speech {
    case basic(audio: Data)
}

extension Speech: Endpoint {
    public var path: String {
        return "speech"
    }
    
    public var query: String {
        switch self {
        case .basic(_):
            return ""
        }
    }
    
    public func request(token: String, witVersion: String, audio: Data) -> URLRequest {
        var req = URLRequest(url: URL(string: urlString)!)
        
        req.addValue("application/vnd.wit.\(witVersion)+json", forHTTPHeaderField: "Accept")
        req.addValue("audio/wav", forHTTPHeaderField: "Content-Type")
        req.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        req.httpMethod = "POST"
        req.httpBody = audio
        
        return req
    }
}
