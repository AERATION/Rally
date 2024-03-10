
import Foundation

protocol SettingsModelProtocol {
    var controlType: ControlType { get set }
    var difficultType: Difficulty { get set }
    var imageId: String { get set }
    var nickname: String { get set }
}

final class SettingsModel: Codable {
    
    //MARK: - Properties
    private var controlType: ControlType 
    private var difficultType: Difficulty
    private var nickname: String
    private var imageId: String
    
    //MARK: - Init
    init(controlType: ControlType, difficultType: Difficulty, nickName: String, imageId: String) {
        self.controlType = controlType
        self.difficultType = difficultType
        self.nickname = nickName
        self.imageId = imageId
    }
    
    //MARK: - Setters
    func setControlType(controlType: ControlType) {
        self.controlType = controlType
    }
    
    func setDifficultType(difficultType: Difficulty) {
        self.difficultType = difficultType
    }
    
    func setNickname(nickname: String) {
        self.nickname = nickname
    }
    
    func setImageId(imageid: String) {
        self.imageId = imageid
    }
    
    //MARK: - Getters
    func getControlType() -> ControlType { return self.controlType }
    
    func getDifficultType() -> Difficulty { return self.difficultType }
    
    func getNickname() -> String { return self.nickname }
    
    func getImageid() -> String { return self.imageId }
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
