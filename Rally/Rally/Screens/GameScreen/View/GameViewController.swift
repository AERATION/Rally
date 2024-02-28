import UIKit
import Foundation
import CoreMotion

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
        imageView.image = UIImage(named:"Car")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    } ()
    
    private let obstacleImageView: UIImageView = {
        let imageView  = UIImageView()
        imageView.image = UIImage(named:"Box")
        imageView.translatesAutoresizingMaskIntoConstraints = false
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
    
    var gameTimer: Timer?
    
    var gameScore: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        view.addSubview(roadView)
        view.addSubview(carImageView)
        
        swipeLeftGesture.addTarget(self, action: #selector(handleSwipeLeft(_:)))
        swipeRightGesture.addTarget(self, action: #selector(handleSwipeRight(_:)))
        view.addGestureRecognizer(swipeLeftGesture)
        view.addGestureRecognizer(swipeRightGesture)
//          tapGesture.addTarget(self, action: #selector(handleTap(_:)))
//          view.addGestureRecognizer(tapGesture)
        view.addSubview(gameScoreLabel)
        makeConstraints()
        
        obstaclesTimer = Timer.scheduledTimer(withTimeInterval: 4.0, repeats: true) { [weak self] _ in
            self?.updateObstacles()
        }
        
        gameTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.updateScoreLabel()
        }
    }
    
    private func setGameSettings() {
        
    }
    
    private func updateObstacles() {
        let randomObstacle = Int.random(in: 0..<100)
        let newObstacle = UIImageView()
        newObstacle.image = UIImage(named:"Box")
        switch randomObstacle {
            case 0..<33:
                newObstacle.frame = CGRect(x: view.bounds.minX+32, y: 50, width: 50, height: 50)
            case 33..<66:
                newObstacle.frame = CGRect(x: view.bounds.midX, y: 50, width: 50, height: 50)
            case 66...100:
                newObstacle.frame = CGRect(x: view.bounds.maxX-64, y: 50, width: 50, height: 50)
            default:
                newObstacle.frame = CGRect(x: view.bounds.midX, y: 50, width: 50, height: 50)
        }
        
        view.addSubview(newObstacle)
        obstacles.append(newObstacle)
        
        
    }
        
    private func moveCar(to direction: Direction) {
        let offset: CGFloat = direction == .left ? -100 : 100 // Замените 100 на желаемую величину смещения
        let finalCenterX = carImageView.center.x + offset
        
        // Проверка границ экрана
        let screenWidth = view.bounds.width
        let newCenterX = max(0 + carImageView.bounds.width / 2, min(finalCenterX, screenWidth - carImageView.bounds.width / 2))
        
        // Анимация перемещения машины
        UIView.animate(withDuration: 0.3) {
            self.carImageView.center = CGPoint(x: newCenterX, y: self.carImageView.center.y)
        }
    }
    
    private func removeAllObstacles() {
        for obstacle in obstacles {
            obstacle.removeFromSuperview()
        }
    }
    
    private func checkCollision() {
        for obstacle in obstacles {
            if carImageView.frame.intersects(obstacle.frame) {
                removeAllObstacles()
                showGameOverAlertController()
            }
        }
    }
    
    private func makeConstraints() {
        roadView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(86)
            make.right.equalToSuperview().inset(86)
            make.top.bottom.equalToSuperview()
        }
        carImageView.snp.makeConstraints{ make in
            make.height.equalTo(96)
            make.width.equalTo(96)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(48)
        }
        
        gameScoreLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(48)
            make.top.equalToSuperview().offset(48)
            make.height.equalTo(42)
        }
    }
    
    private func updateScoreLabel() {
        self.gameScore += 1
        self.gameScoreLabel.text = String(gameScore)
        for obstacle in obstacles {
            obstacle.frame.origin.y += 20
            if obstacle.frame.origin.y > view.bounds.height {
                // Если препятствие выходит за пределы экрана, удаляем его
                obstacle.removeFromSuperview()
            }
        }
        checkCollision()
    }
    
    private func showGameOverAlertController() {
        let alertController = UIAlertController(title: "Вы проиграли(", message:
                                                    "Вы заработали: \(gameScore) очков\nУровень сложности: \(difficulty.rawValue)\nТип управления: \(controlType.rawValue)\nДля того, чтобы начать заново нажмите", preferredStyle: .alert)

        let cancelButton = UIAlertAction(title: "Отменить", style: .cancel) {_ in
            self.navigationController?.popToRootViewController(animated: true)
        }
        alertController.addAction(cancelButton)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func handleTap(_ gestureRecognizer: UITapGestureRecognizer) {
        let location = gestureRecognizer.location(in: view)
        if location.x < view.bounds.midX {
            // Тап произведен в левой половине экрана, двигаем машину влево
            moveCar(to: .left)
        } else {
            // Тап произведен в правой половине экрана, двигаем машину вправо
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
    

    
