import UIKit
import Foundation
import CoreMotion

/*
    Задание таргетов в отдельную функцию.
    Создать модель данных для работы
    Создать settingsModel
*/
 

class GameViewController: UIViewController, UIGestureRecognizerDelegate {
    
    private let roadView: UIView = {
        let road: UIView = UIView()
        road.backgroundColor = .lightGray
        return road
    } ()
    
    private let difficulty: Difficulty = {
        let difficultyKey = UR.DataKeys.difficultyKey
        let savedDifficulty = UserDefaults.standard.string(forKey: difficultyKey)
        let difficulty = Difficulty(rawValue: savedDifficulty!)
        return difficulty!
    } ()

    private let controlType: ControlType = {
        let controlTypeKey = UR.DataKeys.controlTypeKey
        let savedControlType = UserDefaults.standard.string(forKey: controlTypeKey)
        let controlType = ControlType(rawValue: savedControlType!)
        return controlType!
    } ()
    
    private let carImageView: UIImageView = {
        let imageView  = UIImageView()
        imageView.image = UIImage(named: "Car")
        return imageView
    } ()

    
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
        label.text = "0"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 22)
        return label
    }()
    
    
    var obstacles = [UIImageView]()
    
    var obstaclesTimer: Timer?
    
    var obstacleSpeed: CGFloat = 0
    
    var obstacleUpdate: TimeInterval = 0
    
    var gameTimer: Timer?
    
    var gameScore: Int = 0
    
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
    
    private func setTimers() {
        
        gameTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.moveObstacles()
            self?.checkCollision()
            
        }
        
        obstaclesTimer = Timer.scheduledTimer(withTimeInterval: obstacleUpdate, repeats: true) { [weak self] _ in
            self?.generateObstacles()
        }
    }
    
    private func setGameSettings() {
        switch difficulty {
            case .easy:
                obstacleSpeed = 40
                obstacleUpdate = 4
            case .medium:
                obstacleSpeed = 80
                obstacleUpdate = 3
            case .hard:
                obstacleSpeed = 120
                obstacleUpdate = 2
            default:
                obstacleSpeed = 40
        }
        switch(controlType){
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
        let newObstacle: UIImageView = {
            let imageView  = UIImageView()
            imageView.image = UIImage(named:"Box")
            return imageView
        } ()
        switch randomObstacle {
            case 0..<25:
                newObstacle.frame = CGRect(x: view.bounds.minX+50, y: 50, width: 50, height: 50)
            case 25..<50:
                newObstacle.frame = CGRect(x: view.bounds.width/4*2+50, y: 50, width: 50, height: 50)
            case 50...75:
                newObstacle.frame = CGRect(x: view.bounds.width/4*3+50, y: 50, width: 50, height: 50)
            case 75...100:
                newObstacle.frame = CGRect(x: view.bounds.width-50, y: 50, width: 50, height: 50)
            default:
                newObstacle.frame = CGRect(x: view.bounds.midX, y: 50, width: 50, height: 50)
        }
        
        self.view.addSubview(newObstacle)
        obstacles.append(newObstacle)
    }
        
    private func moveCar(to direction: Direction) {
        let offset: CGFloat = direction == .left ? -100 : 100
        let finalCenterX = carImageView.center.x + offset
        
//        let screenWidth = view.bounds.width
//        let newCenterX = max(0 + carImageView.bounds.width / 2, min(finalCenterX, screenWidth - carImageView.bounds.width / 2))
        
        let newCenterX = 0 + finalCenterX
        
        UIView.animate(withDuration: 0.3) {
            self.carImageView.center = CGPoint(x: newCenterX, y: self.carImageView.center.y)
        }
    }
    
    private func moveObstacles() {
        for obstacle in obstacles {
            UIView.animate(withDuration: obstacleUpdate) {
                obstacle.center.y += self.obstacleSpeed
            }
            if obstacle.frame.origin.y > view.bounds.height {
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

        let rect = CGRect(x: carImageView.center.x, y: carImageView.center.y, width: 44, height: 96)
        for obstacle in obstacles {
            if rect.intersects(obstacle.frame) {
                gameOver()
            }
            if CGRectGetMinY(carImageView.frame) < CGRectGetMaxY(obstacle.frame) && CGRectGetMaxY(carImageView.frame) > CGRectGetMinY(obstacle.frame)  {
                updateScoreLabel()
            }
        }
        if !rect.intersects(view.frame) {
            gameOver()
        }
    }
    
    private func makeConstraints() {
        carImageView.frame = CGRect(x: view.center.x, y: view.bounds.maxY-96, width: 96, height: 96)
        
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
        self.gameScoreLabel.text = String(gameScore)
    }
    
    private func showGameOverAlertController() {
        let alertController = UIAlertController(title: "Вы проиграли(", message:
                                                    "Количество очков: \(gameScore)\nУровень сложности: \(difficulty.rawValue)\nТип управления: \(controlType.rawValue)\nДля того, чтобы начать заново нажмите", preferredStyle: .alert)

        let cancelButton = UIAlertAction(title: "Отменить", style: .cancel) {_ in
            self.navigationController?.popToRootViewController(animated: true)
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
    

    
