
import Foundation

protocol SettingsModelProtocol {
    var controlType: ControlType { get set }
    var difficultType: Difficulty { get set }
    var imageId: String { get set }
    var nickName: String { get set }
}

final class SettingsModel: Codable {
    var controlType: ControlType
    var difficultType: Difficulty
    var nickName: String
    var imageId: String
    
    init(controlType: ControlType, difficultType: Difficulty, nickName: String, imageId: String) {
        self.controlType = controlType
        self.difficultType = difficultType
        self.nickName = nickName
        self.imageId = imageId
    }
}

enum ControlType: String, CaseIterable, Codable {
    case swipe = "Свайп"
    case tap = "Тап по экрану"
}

enum Difficulty: String, CaseIterable, Codable {
    case easy = "Легкая"
    case medium = "Средняя"
    case hard = "Сложная"
}
