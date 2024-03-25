
import Foundation

final class SettingsModel: Codable {
    
    //MARK: - Properties
    private var controlType: ControlType
    private var difficultType: Difficulty
    private var carImage: CarImage
    private var obstacleImage: ObstacleImage
    private var nickname: String
    private var imageId: String
    
    //MARK: - Init
    init() {
        self.controlType = .swipe
        self.difficultType = .easy
        self.carImage = .car1
        self.obstacleImage = .obstacle1
        self.nickname = "User"
        self.imageId = "DefaultUserImage"
    }
    
    //MARK: - Setters
    func setControlType(controlType: ControlType) {
        self.controlType = controlType
    }
    
    func setDifficultType(difficultType: Difficulty) {
        self.difficultType = difficultType
    }
    
    func setCarImage(carImage: CarImage) {
        self.carImage = carImage
    }
    
    func setObstacleImage(obstacleImage: ObstacleImage) {
        self.obstacleImage = obstacleImage
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
    
    func getCarImage() -> CarImage { return self.carImage }
    
    func getObstacleImage() -> ObstacleImage { return self.obstacleImage }
    
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

enum CarImage: Int, CaseIterable, Codable {
    case car1 = 0
    case car2 = 1
    case car3 = 2
}

enum ObstacleImage: Int, CaseIterable, Codable {
    case obstacle1 = 0
    case obstacle2 = 1
    case obstacle3 = 2
}
