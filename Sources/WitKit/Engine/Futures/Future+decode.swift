//
//  File.swift
//  
//
//  Created by Asiel Cabrera Gonzalez on 12/9/21.
//

import Foundation


public extension Future where Value == Data {
    func decoded<T: Decodable>(
        as type: T.Type = T.self,
        using decoder: JSONDecoder = .init()
    ) -> Future<T> {
        transformed { data in
            print(data)
            return try decoder.decode(T.self, from: data)
        }
    }
}
