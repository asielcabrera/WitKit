//
//  URLSession.swift
//  
//
//  Created by Asiel Cabrera Gonzalez on 12/9/21.
//

import Foundation
import Combine

extension URLSession {
    
    private var semaphore: DispatchSemaphore { return DispatchSemaphore (value: 0) }
    
    func request(url: URL) -> Future<Data> {
        // We'll start by constructing a Promise, that will later be
        // returned as a Future:
        let promise = Promise<Data>()
        
        // Perform a data task, just like we normally would:
        let task = dataTask(with: url) { [weak self] data, _, error in
            // Reject or resolve the promise, depending on the result:
            if let error = error {
                promise.reject(with: error)
                self?.semaphore.signal()
            } else {
                promise.resolve(with: data ?? Data())
                self?.semaphore.signal()
            }
        }
        
        task.resume()
        semaphore.wait()
        return promise
    }
    
    func request(urlRequest: URLRequest) -> Future<Data> {
        // We'll start by constructing a Promise, that will later be
        // returned as a Future:
        let promise = Promise<Data>()
        
        // Perform a data task, just like we normally would:
        let task = dataTask(with: urlRequest) { [weak self] data, _, error in
            print(String(data: data!, encoding: .utf8)!)
            // Reject or resolve the promise, depending on the result:
            if let error = error {
                promise.reject(with: error)
                self?.semaphore.signal()
            } else {
                print("resolver urlsession")
                promise.resolve(with: data!)
                self?.semaphore.signal()
            }
            self?.semaphore.signal()
        }

        task.resume()
        semaphore.wait()
        
        return promise
    }
    
    
    @available(macOS 10.15, *)
    func requestPrueba(urlRequest: URLRequest) -> AnyPublisher<WitMessage, Error> {
        dataTaskPublisher(for: urlRequest)
            .map(\.data)
            .decode(type: WitMessage.self, decoder: JSONDecoder())
            .print()
            .eraseToAnyPublisher()
    }
    
    
}
