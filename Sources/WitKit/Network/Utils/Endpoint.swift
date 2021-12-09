//
//  Endpoint.swift
//  
//
//  Created by Asiel Cabrera Gonzalez on 12/7/21.
//

import Foundation
//import AsyncHTTPClient

public protocol Endpoint {
    
    var path: String   { get }
    var query: String  { get }
    
}

public extension Endpoint {
    
    var base: String  {
        return "https://api.wit.ai"
    }
    
    var urlString: String  {
        let components = "\(base)/\(path)?\(query)"
        return components
    }
    
    func request(token: String, witVersion: String) ->  URLRequest {
        var req = URLRequest(url: URL(string: urlString)!)
        req.addValue("application/vnd.wit.\(witVersion)+json", forHTTPHeaderField: "Accept")
        req.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        req.httpMethod = "GET"
        return req
    }
}
