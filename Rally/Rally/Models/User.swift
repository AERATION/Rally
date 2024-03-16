
import Foundation

protocol UserProtocol {
    var username: String { get set }
    var score: Int { get set }
    var date: Date { get set }
    var avatarImageKey: String { get set }
}
final class User: UserProtocol, Codable {
    
    //MARK: - Properties
    var username: String
    var score: Int
    var date: Date
    var avatarImageKey: String
    
    //MARK: - Init
    init(username: String, score: Int, date: Date, avatarImageKey: String) {
        self.username = username
        self.score = score
        self.date = date
        self.avatarImageKey = avatarImageKey
    }
}
