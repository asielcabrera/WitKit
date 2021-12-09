//
//  WitResult.swift
//  
//
//  Created by Asiel Cabrera Gonzalez on 12/7/21.
//

import Foundation

public enum WitResult<T, U> where U: Error {
    case success(T)
    case failure(U)
}
