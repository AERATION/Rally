import UIKit
import Foundation
import CoreMotion

/*
    Задание таргетов в отдельную функцию.
    Создать модель данных для работы
    Создать settingsModel
    Добавить марки
    Добавить final
*/
 

class GameViewController: UIViewController, UIGestureRecognizerDelegate {
    
    private let roadView: UIView = {
        let road: UIView = UIView()
        road.backgroundColor = .lightGray
        return road
    } ()
    
    private let settingsModel: SettingsModel = SettingsModel(controlType: .swipe, difficultType: .easy, nickName: "User", imageId: "DefaultUserImage")
    
    private let carImageView: UIImageView = {
        let imageView  = UIImageView()
        imageView.image = UIImage(named: "Car")
        return imageView
    } ()

    
//    private let gesturesModel: GesturesModel = GesturesModel(UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeLeft(_:))))
    
    let swipeLeftGesture: UISwipeGestureRecognizer = {
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeLeft(_:)))
        swipeGesture.direction = .left
        return swipeGesture
    }()
    
    let swipeRightGesture: UISwipeGestureRecognizer = {
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeRight(_:)))
        swipeGesture.direction = .right
        return swipeGesture
    }()
  
    let tapGesture: UITapGestureRecognizer = {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        tapGesture.numberOfTapsRequired = 1
        return tapGesture
    }()
    
    var gameScoreLabel: UILabel = {
        let label = UILabel()
        label.text = "Score: 0"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 22)
        return label
    }()
    
    
    private var obstacles = [Obstacle]()
    
    private var obstaclesTimer: Timer?
    
    private var obstacleSpeed: CGFloat = 0
    
    private var obstacleUpdate: TimeInterval = 0
    
    private var gameTimer: Timer?
    
    private var gameScore: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        startGame()
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        view.addSubview(roadView)
        view.addSubview(carImageView)
        view.addSubview(gameScoreLabel)

        makeConstraints()
    }
    
    private func startGame() {
        setGameSettings()
        setTimers()
    }
    
    private func gameOver() {
        showGameOverAlertController()
        removeAllObstacles()
        gameTimer?.invalidate()
        obstaclesTimer?.invalidate()
    }
    
//    private func addGestureTargets() {
//        gesturesModel.swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeLeft(_:)))
//    }
    
    private func setTimers() {
        gameTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            self?.moveObstacles()
            self?.checkCollision()
        }
        
        obstaclesTimer = Timer.scheduledTimer(withTimeInterval: obstacleUpdate, repeats: true) { [weak self] _ in
            self?.generateObstacles()
        }
    }
    
    private func setGameSettings() {
        if let settings = StorageService.shared.load() {
            self.settingsModel.controlType = settings.controlType
            self.settingsModel.difficultType = settings.difficultType
            self.settingsModel.nickName = settings.nickName
            self.settingsModel.imageId = settings.imageId
        }
        switch settingsModel.difficultType {
            case .easy:
                obstacleSpeed = 70
                obstacleUpdate = 4
            case .medium:
                obstacleSpeed = 100
                obstacleUpdate = 3
            case .hard:
                obstacleSpeed = 150
                obstacleUpdate = 2
            default:
                obstacleSpeed = 40
        }
        switch(settingsModel.controlType){
            case .swipe:
                swipeLeftGesture.addTarget(self, action: #selector(handleSwipeLeft(_:)))
                swipeRightGesture.addTarget(self, action: #selector(handleSwipeRight(_:)))
                view.addGestureRecognizer(swipeLeftGesture)
                view.addGestureRecognizer(swipeRightGesture)
            case .tap:
                tapGesture.addTarget(self, action: #selector(handleTap(_:)))
                view.addGestureRecognizer(tapGesture)
        }

    }
    
    private func generateObstacles() {
        let randomObstacle = Int.random(in: 0..<100)
        let newObstacle: Obstacle = Obstacle()
        switch randomObstacle {
            case 0..<25:
            newObstacle.frame = CGRect(x: view.bounds.minX+50, y: 50, width: UR.Constants.obstacleWidth, height: UR.Constants.obstacleHeight)
            case 25..<50:
                newObstacle.frame = CGRect(x: view.bounds.width/4*2+50, y: 50, width: UR.Constants.obstacleWidth, height: UR.Constants.obstacleHeight)
            case 50...75:
                newObstacle.frame = CGRect(x: view.bounds.width/4*3+50, y: 50, width: UR.Constants.obstacleWidth, height: UR.Constants.obstacleHeight)
            case 75...100:
                newObstacle.frame = CGRect(x: view.bounds.width-50, y: 50, width: UR.Constants.obstacleWidth, height: UR.Constants.obstacleHeight)
            default:
                newObstacle.frame = CGRect(x: view.bounds.midX, y: 50, width: UR.Constants.obstacleWidth, height: UR.Constants.obstacleHeight)
        }
        
        self.view.addSubview(newObstacle)
        obstacles.append(newObstacle)
    }
        
    private func moveCar(to direction: Direction) {
        let offset: CGFloat = direction == .left ? -100 : 100
        let finalCenterX = carImageView.center.x + offset
        
        let newCenterX = 0 + finalCenterX
        
        UIView.animate(withDuration: 0.3) {
            self.carImageView.center = CGPoint(x: newCenterX, y: self.carImageView.center.y)
        }
    }
    
    private func moveObstacles() {
        for obstacle in obstacles {
            UIView.animate(withDuration: obstacleUpdate) {
//                obstacle.center.y += self.obstacleSpeed
                obstacle.frame.origin.y += self.obstacleSpeed
            }
            
            if obstacle.frame.origin.y > UIScreen.main.bounds.height {
                obstacle.removeFromSuperview()
                obstacles.removeFirst()
            }
        }
    }
    
    private func removeAllObstacles() {
        for obstacle in obstacles {
            obstacle.removeFromSuperview()
        }
    }
    
    private func checkCollision() {

        let rect = CGRect(x: carImageView.center.x, y: carImageView.center.y, width: 85, height: 96)
        for obstacle in obstacles {
            let rectObstacle = CGRect(x: obstacle.center.x, y: obstacle.center.y, width: 10, height: 10)
//            if rect.intersects(obstacle.frame) {
//                gameOver()
//                print("gey")
//            }
//            if CGRectIntersectsRect(rect, obstacle.frame) {
//                gameOver()
//            }
            if CGRectGetMinY(carImageView.frame) < CGRectGetMaxY(obstacle.frame) && (CGRectGetMinX(carImageView.frame) <= CGRectGetMaxX(obstacle.frame) || CGRectGetMaxX(carImageView.frame) >= CGRectGetMaxX(obstacle.frame)) {
                gameOver()
            }
            if CGRectGetMinY(carImageView.frame) < CGRectGetMaxY(obstacle.frame) && CGRectGetMaxY(carImageView.frame) > CGRectGetMinY(obstacle.frame) && obstacle.intersectByCar == false {
                updateScoreLabel()
                obstacle.intersectByCar = true
            }
        }
        if !rect.intersects(view.frame) {
            gameOver()
        }
    }
    
    private func makeConstraints() {
        carImageView.frame = CGRect(x: view.center.x, y: view.bounds.maxY-164, width: 96, height: 96)
        
        roadView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(UR.Constants.roadViewLeading)
            make.trailing.equalToSuperview().inset(UR.Constants.roadViewTrailing)
            make.top.bottom.equalToSuperview()
        }
        
        gameScoreLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(UR.Constants.gameScoreLabelTrailing)
            make.top.equalToSuperview().offset(UR.Constants.gameScoreLabelTop)
            make.height.equalTo(UR.Constants.gameScoreLabelHeight)
        }
    }
    
    private func updateScoreLabel() {
        self.gameScore += 1
        self.gameScoreLabel.text = String("Score: \(gameScore)")
    }
    
    private func showGameOverAlertController() {
        let alertController = UIAlertController(title: "Вы проиграли(", message:
                                                    "Количество очков: \(gameScore)\nУровень сложности: \(settingsModel.difficultType.rawValue)\nТип управления: \(settingsModel.controlType.rawValue)\nДля того, чтобы начать заново нажмите", preferredStyle: .alert)

        let cancelButton = UIAlertAction(title: "Сохранить и выйти", style: .cancel) {_ in
            self.navigationController?.popToRootViewController(animated: true)
            let currentData = Date()
            try? StorageService.shared.saveUserRatings(User(username: self.settingsModel.nickName, score: self.gameScore, date: currentData, avatarImageKey: self.settingsModel.imageId))
        }
        alertController.addAction(cancelButton)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func handleTap(_ gestureRecognizer: UITapGestureRecognizer) {
        let location = gestureRecognizer.location(in: view)
        if location.x < view.bounds.midX {
            moveCar(to: .left)
        } else {
            moveCar(to: .right)
        }
    }
    
      @objc func handleSwipeLeft(_ gestureRecognizer: UIGestureRecognizer) {
          moveCar(to: .left)
      }
      
      @objc func handleSwipeRight(_ gestureRecognizer: UIGestureRecognizer) {
          moveCar(to: .right)
      }
      
      enum Direction {
          case left
          case right
      }
    
}
    

    
