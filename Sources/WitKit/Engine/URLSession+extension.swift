//
//  URLSession.swift
//  
//
//  Created by Asiel Cabrera Gonzalez on 12/9/21.
//

import Foundation

extension URLSession {
    func request(url: URL) -> Future<Data> {
        // We'll start by constructing a Promise, that will later be
        // returned as a Future:
        let promise = Promise<Data>()
        
        // Perform a data task, just like we normally would:
        let task = dataTask(with: url) { data, _, error in
            // Reject or resolve the promise, depending on the result:
            if let error = error {
                promise.reject(with: error)
            } else {
                promise.resolve(with: data ?? Data())
            }
        }
        
        task.resume()
        return promise
    }
    
    func request(urlRequest: URLRequest) -> Future<Data> {
        // We'll start by constructing a Promise, that will later be
        // returned as a Future:
        let promise = Promise<Data>()
        
        // Perform a data task, just like we normally would:
        let task = dataTask(with: urlRequest) { data, _, error in
            // Reject or resolve the promise, depending on the result:
            if let error = error {
                promise.reject(with: error)
            } else {
                promise.resolve(with: data!)
            }
        }

        task.resume()
        return promise
    }    
}
