//
//  UserRepository.swift
//  code-example
//
//  Created by Alexy Nesterchuk on 17.07.2024.
//

import Foundation
import NetworkKit
import Combine


protocol UserRepositoryProtocol: BaseRepository {
    func fetchUsersCombineExample() -> AnyPublisher<[User], Error>
    func fetchUsersClosureExample(completionHandler: @escaping (Result<[User], Error>) -> Void)
    func fetchUsersSwiftConcurrencyExample() async throws -> [User]
}

final class UserRepository: UserRepositoryProtocol {
    
    private let client: HTTPClient
    
    init(client: HTTPClient) {
        self.client = client
    }
}

// MARK: - Example fetch with Closure
extension UserRepository {
        
    func fetchUsersClosureExample(completionHandler: @escaping (Result<[User], Error>) -> Void) {
        do {
            let request = try UserProvider.userList.makeRequest()
            client.make(request: request) { [weak self] result in
                guard let self = self else {
                    completionHandler(.failure(RepositoryError.selfError))
                    return
                }
                self.defaultHandler(result: result, completionHandler: completionHandler)
            }
        } catch {
            completionHandler(.failure(error))
        }
    }
}

// MARK: - Example fetch with Combine
extension UserRepository {
    
    func fetchUsersCombineExample() -> AnyPublisher<[User], Error> {
        do {
            let request = try UserProvider.userList.makeRequest()
            let publisher = client.publisher(request: request)
            return defaultHandler(publisher: publisher)
        } catch {
            return Fail(error: error).eraseToAnyPublisher()
        }
    }
}

// MARK: - Example fetch with Swift Concurrency
extension UserRepository {
    
    func fetchUsersSwiftConcurrencyExample() async throws -> [User] {
        let request = try UserProvider.userList.makeRequest()
        let data = try await client.data(request: request)
        let items: [User] = try defaultHandler(data: data)
        return items
    }
    
}
