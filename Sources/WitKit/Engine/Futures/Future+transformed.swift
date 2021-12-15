//
//  Future+transformed.swift
//  
//
//  Created by Asiel Cabrera Gonzalez on 12/9/21.
//

import Foundation

public extension Future {
    func transformed<T>(
        with closure: @escaping (Value) throws -> T
    ) -> Future<T> {
         chained { value in
             try Promise(value: closure(value))
        }
    }
}
