

import Foundation

final class Game {
    
    var settingsModel: SettingsModel = SettingsModel(controlType: .swipe, difficultType: .easy, nickName: "User", imageId: "DefaultUserImage")
    
    let gesturesModel: GesturesModel = GesturesModel()
    
    var obstacles = [Obstacle]()
    
    var obstaclesTimer: Timer?
    
    var obstacleSpeed: CGFloat = 0
    
    var obstacleSpawn: TimeInterval = 0
    
    var checkCollisionTimer: Double = 0
    
    var animationDuration: Double = 0
    
    var gameTimer: Timer?
    
    var gameScore: Int = 0
    
    func setObstacleProperties(speed: CGFloat, spawn: TimeInterval, checkCollision: TimeInterval, animationDuration: Double) {
        self.obstacleSpeed = speed
        self.obstacleSpawn = spawn
        self.checkCollisionTimer = checkCollision
        self.animationDuration = animationDuration
    }
    
    func upGameScore() {
        gameScore += 1
    }
    
    func removeTimers() {
        obstaclesTimer?.invalidate()
        gameTimer?.invalidate()
    }
    
    func setSettings(controlType: ControlType, difficultType: Difficulty, nickName: String, imageid: String) {
        settingsModel.setControlType(controlType: controlType)
        settingsModel.setDifficultType(difficultType: difficultType)
        settingsModel.setNickname(nickname: nickName)
        settingsModel.setImageId(imageid: imageid)
    }
    
 
}
