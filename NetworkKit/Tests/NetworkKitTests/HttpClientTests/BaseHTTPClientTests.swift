@testable import NetworkKit
import Foundation
import Combine
import XCTest

class BaseHTTPClientTests: XCTestCase {

    let url = URL(string: "https://test.com")!
    var cancellables = Set<AnyCancellable>()
    
    func makeSession(with response: (HTTPURLResponse?, Data)) -> URLSession {
        URLRequestSpyProtocol.requestHandler = { request in
            response
        }
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLRequestSpyProtocol.self]
        return URLSession(configuration: configuration)
    }
    
    func makeSessionWithResponse() -> URLSession {
        makeSession(with: (HTTPURLResponse(url: url,
                                           statusCode: 200,
                                           httpVersion: nil,
                                           headerFields: nil)!,
                           Data()))
    }
}
