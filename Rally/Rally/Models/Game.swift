
import Foundation

protocol GameProtocol {
    var settingsModel: SettingsModel { get }
    
    var gesturesModel: GesturesModel { get }
    
    var obstacles: [Obstacle] { get }
    
    var obstaclesTimer: Timer? { get }
    
    var obstacleSpeed: CGFloat { get }
    
    var obstacleSpawn: TimeInterval { get }
    
    var checkCollisionTimer: Double { get }
    
    var animationDuration: Double { get }
    
    var gameTimer: Timer? { get }
    
    var gameScore: Int { get }
}

final class Game {
    
    //MARK: - Properties
    private var settingsModel: SettingsModel = SettingsModel(controlType: .swipe, difficultType: .easy, carImage: .car1, obstacleImage: .obstacle1, nickName: "User", imageId: "DefaultUserImage")
    
    private let gesturesModel: GesturesModel = GesturesModel()
    
    private var obstacles = [Obstacle]()
    
    var obstaclesTimer: Timer?
    
    private var obstacleSpeed: CGFloat = 0
    
    private var obstacleSpawn: TimeInterval = 0
    
    private var checkCollisionTimer: Double = 0
    
    private var animationDuration: Double = 0
    
    var gameTimer: Timer?
    
    private var gameScore: Int = 0
    
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
