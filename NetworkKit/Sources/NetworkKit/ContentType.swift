import Foundation

public enum ContentType {
    case json

    var key: String {
        "Content-Type"
    }

    var value: String {
        switch self {
        case .json:
            "application/json; charset=utf-8"
        }
    }
}
