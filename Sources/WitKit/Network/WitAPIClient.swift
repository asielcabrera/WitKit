//
//  WitAPIClient.swift
//  
//
//  Created by Asiel Cabrera Gonzalez on 12/7/21.
//

import Foundation

public protocol WitAPIClient {
    
    var session: URLSession { get }
    
    func fetch<T: Decodable>(with request: URLRequest, decode: @escaping (Decodable) -> T?, completion: @escaping (WitResult<T, WitNetworkError>) -> Void)
}

public extension WitAPIClient {
    
    typealias CompletionHandler = (Decodable?, WitNetworkError?) -> Void
    
    func decodingTask<T: Decodable>(with request: URLRequest, decodingType: T.Type, completionHandler completion: @escaping CompletionHandler) -> URLSessionDataTask {
        
        let task = session.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(nil, .requestFailed)
                return
            }
            if httpResponse.statusCode == 200 {
                if let data = data {
                    do {
                        let genericModel = try JSONDecoder().decode(decodingType, from: data)
                        completion(genericModel, nil)
                    } catch {
                        completion(nil, .jsonConversionFailure)
                    }
                } else {
                    completion(nil, .invalidData)
                }
            } else {
                completion(nil, .responseUnsuccessful)
            }
        }
        return task
    }
    
    func fetch<T: Decodable>(with request: URLRequest, decode: @escaping (Decodable) -> T?, completion: @escaping (WitResult<T, WitNetworkError>) -> Void) {
        let task = decodingTask(with: request, decodingType: T.self) { (json , error) in
            guard let json = json else {
                if let error = error {
                    completion(WitResult.failure(error))
                } else {
                    completion(WitResult.failure(.invalidData))
                }
                return
            }
            if let value = decode(json) {
                completion(.success(value))
            } else {
                completion(.failure(.jsonParsingFailure))
            }
        }
        task.resume()
    }
    
}
