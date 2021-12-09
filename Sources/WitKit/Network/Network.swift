//
//  File.swift
//  
//
//  Created by Asiel Cabrera Gonzalez on 12/6/21.
//

import Foundation
import AsyncHTTPClient

public class Network1 {
    
    
    public init() { }
    
    public static func req(method: String, path: Endpoint1, params: [String: String]) {
        
        let semaphore = DispatchSemaphore (value: 0)
        
        URLSession.shared.request(path, method: method, then: { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                return
            }
            print(String(data: data, encoding: .utf8)!)
            semaphore.signal()
        })
        semaphore.wait()
    }
}

public extension URL {
    static func makeForEndpoint(_ endPoint: String) -> URL {
        URL(string: "https://api.wit.ai/\(endPoint)")!
    }
}

public enum Endpoint1 {
    case message(text: String)
}

public extension Endpoint1 {
    var url: URL {
        switch self {
        case .message(let text):
            return .makeForEndpoint("message?q=\(text.replacingOccurrences(of: " ", with: "%20"))")
        }
    }
}

public extension URLSession {
    
    typealias Handler = (Data?, URLResponse?, Error?) -> Void
    
    @discardableResult
    func request(_ endpoint: Endpoint1, method: String, then handler: @escaping Handler) -> URLSessionDataTask {
        
        var request = URLRequest(url: endpoint.url,timeoutInterval: Double.infinity)
        request.addValue("application/vnd.wit.\(Configuration.WIT_API_VERSION)+json", forHTTPHeaderField: "Accept")
        request.addValue("Bearer \(Configuration.access_token)", forHTTPHeaderField: "Authorization")
        
        request.httpMethod = method
        
        let task = dataTask(with: request, completionHandler: handler)
        
        task.resume()
        return task
    }
}
