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
 

final class GameViewController: UIViewController, UIGestureRecognizerDelegate {
    
    //MARK: - Propertioes
    private let roadView: UIView = {
        let road: UIView = UIView()
        road.backgroundColor = .lightGray
        return road
    } ()
    
    private let game: Game = Game()
    
    private let carImageView: UIImageView = {
        let imageView  = UIImageView()
        imageView.image = UIImage(named: "Car")
        return imageView
    } ()
    
    var gameScoreLabel: UILabel = {
        let label = UILabel()
        label.text = "\(LocalizedStrings.scoreLabelText)0"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 22)
        return label
    }()
    
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
        game.removeTimers()
    }
    
    private func setTimers() {
        
        game.gameTimer = Timer.scheduledTimer(withTimeInterval: game.checkCollisionTimer, repeats: true) { [weak self] _ in
            self?.moveObstacles()
            self?.checkCollision()
        }
        
        game.obstaclesTimer = Timer.scheduledTimer(withTimeInterval: game.obstacleSpawn, repeats: true) { [weak self] _ in
            self?.generateObstacles()
        }
    }
    
    private func setGameSettings() {
        if let settings = StorageService.shared.load() {
            game.setSettings(controlType: settings.getControlType(), difficultType: settings.getDifficultType(), nickName: settings.getNickname(), imageid: settings.getImageid())
        }
        switch game.settingsModel.getDifficultType() {
            case .easy: game.setObstacleProperties(speed: 15, spawn: 3, checkCollision: 0.4, animationDuration: 0.6)
            case .medium: game.setObstacleProperties(speed: 20, spawn: 2, checkCollision: 0.3, animationDuration: 0.5)
            case .hard: game.setObstacleProperties(speed: 30, spawn: 1, checkCollision: 0.1, animationDuration: 0.3)
            default: game.setObstacleProperties(speed: 70, spawn: 4, checkCollision: 0.4, animationDuration: 0.6)
        }
        switch game.settingsModel.getControlType() {
            case .swipe:
                game.gesturesModel.swipeLeftGesture.addTarget(self, action: #selector(handleSwipeLeft(_:)))
                game.gesturesModel.swipeRightGesture.addTarget(self, action: #selector(handleSwipeRight(_:)))
                view.addGestureRecognizer(game.gesturesModel.swipeLeftGesture)
                view.addGestureRecognizer(game.gesturesModel.swipeRightGesture)
            case .tap:
                game.gesturesModel.tapGesture.addTarget(self, action: #selector(handleTap(_:)))
                view.addGestureRecognizer(game.gesturesModel.tapGesture)
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
        game.obstacles.append(newObstacle)
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
        for obstacle in game.obstacles {
            UIView.animate(withDuration: game.animationDuration) {
//                obstacle.center.y += self.obstacleSpeed
                obstacle.frame.origin.y += self.game.obstacleSpeed
            }
            
            if obstacle.frame.origin.y > UIScreen.main.bounds.height {
                obstacle.removeFromSuperview()
                game.obstacles.removeFirst()
            }
        }
    }
    
    private func removeAllObstacles() {
        for obstacle in game.obstacles {
            obstacle.removeFromSuperview()
        }
    }
    
    private func checkCollision() {

        let rect = CGRect(x: carImageView.center.x, y: carImageView.center.y, width: 85, height: 96)
        for obstacle in game.obstacles {
            let rectObstacle = CGRect(x: obstacle.center.x, y: obstacle.center.y, width: 10, height: 10)
            if rect.intersects(obstacle.frame) {
                gameOver()
            }
//            if CGRectIntersectsRect(rect, obstacle.frame) {
//                gameOver()
//            }
//            if CGRectGetMinY(carImageView.frame) < CGRectGetMaxY(obstacle.frame) && (CGRectGetMinX(carImageView.frame) <= CGRectGetMaxX(obstacle.frame) || CGRectGetMaxX(carImageView.frame) >= CGRectGetMaxX(obstacle.frame)) {
//                gameOver()
//            }
//            if CGRectGetMinY(carImageView.frame) < CGRectGetMaxY(obstacle.frame) && CGRectGetMaxY(carImageView.frame) > CGRectGetMinY(obstacle.frame) && obstacle.intersectByCar == false {
//                updateScoreLabel()
//                obstacle.intersectByCar = true
//            }
            
            if doViewsIntersect(view1: carImageView, view2: obstacle) && obstacle.intersectByCar == false {
                updateScoreLabel()
                obstacle.intersectByCar = true
            }
        }
        if !rect.intersects(view.frame) {
            gameOver()
        }
    }
    
    func doViewsIntersect(view1: UIView, view2: UIView) -> Bool {
        let view1Frame = view1.frame
        let view2Frame = view2.frame
        
        // Проверяем, пересекаются ли вертикальные границы двух view
        let intersectsOnY = (view1Frame.origin.y < view2Frame.origin.y + view2Frame.size.height) &&
                            (view1Frame.origin.y + view1Frame.size.height > view2Frame.origin.y)
        
        return intersectsOnY
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
        game.upGameScore()
        self.gameScoreLabel.text = String("\(LocalizedStrings.scoreLabelText)\(game.gameScore)")
    }
    
    private func showGameOverAlertController() {
        let alertController = UIAlertController(title: "Вы проиграли(", message:
                                                    "Количество очков: \(game.gameScore)\nУровень сложности: \(game.settingsModel.getDifficultType().rawValue)\nТип управления: \(game.settingsModel.getControlType().rawValue)\nДля того, чтобы начать заново нажмите", preferredStyle: .alert)

        let cancelButton = UIAlertAction(title: LocalizedStrings.saveAndExitMessage, style: .cancel) {_ in
            self.navigationController?.popToRootViewController(animated: true)
            let currentData = Date()
            try? StorageService.shared.saveUserRatings(User(username: self.game.settingsModel.getNickname(), score: self.game.gameScore, date: currentData, avatarImageKey: self.game.settingsModel.getImageid()))
        }
        let startAgainButton = UIAlertAction(title: LocalizedStrings.startAgainMessage, style: .destructive) { _ in
            self.game.gameScore = 0
            self.gameScoreLabel.text = "\(LocalizedStrings.scoreLabelText)0"
            self.carImageView.frame = CGRect(x: self.view.center.x, y: self.view.bounds.maxY-164, width: 96, height: 96)
            self.startGame()
        }
        alertController.addAction(cancelButton)
        alertController.addAction(startAgainButton)
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
    

    
