
import Foundation

protocol SettingsModelProtocol {
    var controlType: ControlTypeD { get set }
    var difficultType: DifficultyD { get set }
    var nickName: String { get set }
}

class SettingsModel: SettingsModelProtocol {
    
    var controlType: ControlTypeD = .swipe
    var difficultType: DifficultyD = .easy
    var nickName: String = ""

}

enum ControlTypeD: String, CaseIterable {
    case swipe = "Свайп"
    case tap = "Тап по экрану"
}

enum DifficultyD: String, CaseIterable {
    case easy = "Легкая"
    case medium = "Средняя"
    case hard = "Сложная"
}
