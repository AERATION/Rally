
import Foundation

final class Game {
    
    //MARK: - Properties
    private var settingsModel: SettingsModel = SettingsModel()
    
    private let gesturesModel: GesturesModel = GesturesModel()
    
    private var obstacles = [Obstacle]()
    
    private var obstacleSpeed: CGFloat = 0
    
    private var obstacleSpawn: TimeInterval = 0
    
    private var checkCollisionTimer: Double = 0
    
    private var animationDuration: Double = 0
    
    private var gameScore: Int = 0
    
    var gameTimer: Timer?
    
    var obstaclesTimer: Timer?
    
    //MARK: - Methods of obstacles
    func removeAllObstacles() {
        obstacles.removeAll()
    }
    
    func addObstacles(obstacle: Obstacle) {
        obstacles.append(obstacle)
    }
    
    func removeFirstObstacle() {
        obstacles.removeFirst()
    }
    
    func setObstacleProperties(speed: CGFloat, spawn: TimeInterval, checkCollision: TimeInterval, animationDuration: Double) {
        self.obstacleSpeed = speed
        self.obstacleSpawn = spawn
        self.checkCollisionTimer = checkCollision
        self.animationDuration = animationDuration
    }
    
    //MARK: - Methods of game score
    func setGameScore(newScore: Int) {
        gameScore = newScore
    }
    
    func upGameScore() {
        gameScore += 1
    }
    
    func removeTimers() {
        obstaclesTimer?.invalidate()
        gameTimer?.invalidate()
    }
    
    func setSettings(controlType: ControlType, difficultType: Difficulty, nickName: String, imageid: String, carImage: CarImage, obstacleImage: ObstacleImage) {
        settingsModel.setControlType(controlType: controlType)
        settingsModel.setDifficultType(difficultType: difficultType)
        settingsModel.setNickname(nickname: nickName)
        settingsModel.setImageId(imageid: imageid)
        settingsModel.setCarImage(carImage: carImage)
        settingsModel.setObstacleImage(obstacleImage: obstacleImage)
    }
    
    //MARK: - Getters
    func getObstacles() -> [Obstacle] { return obstacles }
    
    func getGesturesModel() -> GesturesModel { return gesturesModel }
    
    func getSettingsModel() -> SettingsModel { return settingsModel }
    
    func getObstacleSpeed() -> CGFloat { return obstacleSpeed }
    
    func getObstacleSpawn() -> TimeInterval { return obstacleSpawn }
    
    func getCheckCollisionTimer() -> Double { return checkCollisionTimer }
    
    func getAnimationDuration() -> Double { return animationDuration }
    
    func getGameTimer() -> Timer? { return gameTimer }
    
    func getObstacleTimer() -> Timer? { return obstaclesTimer }
    
    func getGameScore() -> Int { return gameScore }
 
}
