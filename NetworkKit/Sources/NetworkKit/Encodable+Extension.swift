import Foundation

extension Encodable {
    func encoded(using encoder: JSONEncoder = JSONEncoder()) throws -> Data {
        return try encoder.encode(self)
    }
}
