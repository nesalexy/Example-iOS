//
//  UserProvider.swift
//  code-example
//
//  Created by Alexy Nesterchuk on 17.07.2024.
//

import Foundation
import NetworkKit

enum UserPath: String {
    case users
}

enum UserProvider {
    case userList
}

extension UserProvider: HTTPProvider {
    var scheme: String {
        Constants.APIDetails.APIScheme
    }
    
    var host: String {
        Constants.APIDetails.APIHost
    }
    
    var path: String? {
        UserPath.users.rawValue
    }
    
    var query: [URLQueryItem]? { nil }
    
    var headers: [String : String]? { nil }
    
    var method: String {
        switch self {
        case .userList:
            HTTPMethod.GET.rawValue
        }
    }
    
    var contentType: ContentType {
        .json
    }
    
    func getData() throws -> Data? { nil }
}
