//
//  Promise.swift
//  
//
//  Created by Asiel Cabrera Gonzalez on 12/9/21.
//

import Foundation

public class Promise<Value>: Future<Value> {
    public init(value: Value? = nil) {
        super.init()
        
        // If the value was already known at the time the promise
        // was constructed, we can report it directly:
        result = value.map(Result.success)
    }
    
    public func resolve(with value: Value) {
        result = .success(value)
    }
    
    public func reject(with error: Error) {
        result = .failure(error)
    }
}
