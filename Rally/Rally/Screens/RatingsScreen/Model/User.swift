
import Foundation

protocol UserProtocol {
    var username: String { get set }
    var score: Int { get set }
    var date: Date { get set }
    var avatarImageKey: String { get set }
}
struct User: UserProtocol {
    var username: String
    var score: Int
    var date: Date
    var avatarImageKey: String
}
