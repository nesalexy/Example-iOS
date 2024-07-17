import Foundation
@testable import NetworkKit

struct Config {
    
    struct APIDetails {
        public static var APIScheme: String {
            return "https"
        }

        public static var APIHost: String {
            return "test.com"
        }
        
        public static var API: String {
            return "\(APIScheme)://\(APIHost)"
        }
    }
}
