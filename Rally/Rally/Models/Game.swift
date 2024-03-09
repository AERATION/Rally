

import Foundation

final class Game {
    
    var settingsModel: SettingsModel = SettingsModel(controlType: .swipe, difficultType: .easy, nickName: "User", imageId: "DefaultUserImage")
    
    let gesturesModel: GesturesModel = GesturesModel()
    
    var obstacles = [Obstacle]()
    
    var obstaclesTimer: Timer?
    
    var obstacleSpeed: CGFloat = 0
    
    var obstacleUpdate: TimeInterval = 0
    
    var gameTimer: Timer?
    
    var gameScore: Int = 0
    
    func setObstacleProperties(speed: CGFloat, update: TimeInterval) {
        self.obstacleSpeed = speed
        self.obstacleUpdate = update
    }
    
    func upGameScore() {
        gameScore += 1
    }
    
    func removeTimers() {
        obstaclesTimer?.invalidate()
        gameTimer?.invalidate()
    }
    
    func setSettings(controlType: ControlType, difficultType: Difficulty, nickName: String, imageid: String) {
        settingsModel.controlType = controlType
        settingsModel.difficultType = difficultType
        settingsModel.nickName = nickName
        settingsModel.imageId = imageid
    }
    
 
}
