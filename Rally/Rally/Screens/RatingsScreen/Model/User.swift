
import Foundation

protocol UserProtocol {
    var username: String { get set }
    var score: Int { get set }
}
struct User: UserProtocol {
    var username: String
    var score: Int
}
