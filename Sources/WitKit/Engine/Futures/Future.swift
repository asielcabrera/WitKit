//
//  Future.swift
//  
//
//  Created by Asiel Cabrera Gonzalez on 12/9/21.
//

import Foundation

public class Future<Value> {
    public typealias Result = Swift.Result<Value, Error>
    
    var result: Result? {
        // Observe whenever a result is assigned, and report it:
        didSet {
            result.map(report)
        }
    }
    private var callbacks = [(Result) -> Void]()
    
    public func observe(using callback: @escaping (Result) -> Void) {
        // If a result has already been set, call the callback directly:
        if let result = result {
            print("result --- \(result)")
            return callback(result)
        }
        print("no result")
        callbacks.append(callback)
    }
    
    private func report(result: Result) {
        callbacks.forEach { $0(result) }
        callbacks = []
    }
}



public extension Future where Value: Decodable {
    func saved<Savable: Database>(in database: Savable) -> Future<Value> {
        chained { value in
            let promise = Promise<Value>()
            
            database.save(value) {
                promise.resolve(with: value)
            }
            
            return promise
        }
    }
}


public protocol Database {
    func save<T: Decodable> (_ value: T, completion: @escaping () -> () ) -> Void
}

//public class Database {
//    public init() {}
//
//    public func save<T: Decodable> (_ value: T, completion: @escaping (T) -> ()) -> Void{
//        print(value)
//        return completion()
//    }
//}
