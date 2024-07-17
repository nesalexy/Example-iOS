//
//  BaseRepository.swift
//  code-example
//
//  Created by Alexy Nesterchuk on 17.07.2024.
//

import Foundation
import Combine
import NetworkKit


protocol BaseRepository {
    init(client: HTTPClient)
    func defaultHandler<T>(publisher: AnyPublisher<(data: Data, response: HTTPURLResponse), Error>) -> AnyPublisher<T, Error> where T: Decodable
}

extension BaseRepository {
    
    /// handler for combine
    func defaultHandler<T>(publisher: AnyPublisher<(data: Data, response: HTTPURLResponse), Error>) -> AnyPublisher<T, Error> where T: Decodable {
        publisher
            .subscribe(on: DispatchQueue.global(qos: .userInitiated))
            .tryMap(DefaultMapping.map)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    /// handler for swift concurrency
    func defaultHandler<T>(data: (data: Data, response: HTTPURLResponse)) throws -> T where T: Decodable {
        try DefaultMapping.map(data: data.data, response: data.response)
    }
    
    /// handler for swift closure
    func defaultHandler<T: Decodable>(result: Result<(data: Data, response: HTTPURLResponse), Error>,
                                      completionHandler: @escaping (Result<T, Error>) -> Void) {
        switch result {
        case .success(let data):
            do {
                let mappedData: T = try self.defaultHandler(data: data)
                completionHandler(.success(mappedData))
            } catch {
                completionHandler(.failure(error))
            }
        case .failure(let error):
            completionHandler(.failure(error))
        }
    }
}

// MARK: - Default mapping
final class DefaultMapping {
    
    static func map<T>(data: Data, response: HTTPURLResponse) throws -> T where T: Decodable {
        /// can handle specific http codes
        if (500...600).contains(response.statusCode) {
            throw RepositoryError.mapError
        }
        
        return try T.self.decoded(from: data)
    }
}
