import UIKit
import Foundation
import CoreMotion

final class GameViewController: UIViewController {
    
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
    
    private var gameScoreLabel: UILabel = {
        let label = UILabel()
        label.text = "\(LocalizedStrings.scoreLabelText)0"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 22)
        return label
    }()
    
    //MARK: - VC methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        startGame()
    }
    
    //MARK: - Private methods
    private func configureUI() {
        view.backgroundColor = .white
        view.addSubview(roadView)
        view.addSubview(carImageView)
        view.addSubview(gameScoreLabel)
//        StorageService.shared.clearAllFiles()
        makeConstraints()
    }
    
    private func startGame() {
        setGameSettings()
        setTimers()
    }
    
    private func gameOver() {
        removeAllObstacles()
        game.removeTimers()
        showGameOverAlertController()
    }
    
    private func setTimers() {
        game.gameTimer = Timer.scheduledTimer(withTimeInterval: game.getCheckCollisionTimer(), repeats: true) { [weak self] _ in
            self?.moveObstacles()
            self?.checkCollision()
        }
        game.obstaclesTimer = Timer.scheduledTimer(withTimeInterval: game.getObstacleSpawn(), repeats: true) { [weak self] _ in
            self?.generateObstacles()
        }
    }
    
    private func setGameSettings() {
        if let settings = StorageService.shared.load() {
            game.setSettings(controlType: settings.getControlType(), difficultType: settings.getDifficultType(), nickName: settings.getNickname(), imageid: settings.getImageid())
        }
        switch game.getSettingsModel().getDifficultType() {
            case .easy: game.setObstacleProperties(speed: UR.Constants.Game.easySpeed, spawn: UR.Constants.Game.easySpawn, checkCollision: UR.Constants.Game.easyCheckCollision, animationDuration: UR.Constants.Game.easyAnimationDuration)
            case .medium: game.setObstacleProperties(speed: UR.Constants.Game.mediumSpeed, spawn: UR.Constants.Game.mediumSpawn, checkCollision: UR.Constants.Game.mediumCheckCollision, animationDuration: UR.Constants.Game.mediumAnimationDuration)
            case .hard: game.setObstacleProperties(speed: UR.Constants.Game.hardSpeed, spawn: UR.Constants.Game.hardSpawn, checkCollision: UR.Constants.Game.hardCheckCollision, animationDuration: UR.Constants.Game.hardAnimationDuration)
        }
        switch game.getSettingsModel().getControlType() {
            case .swipe:
                game.getGesturesModel().swipeLeftGesture.addTarget(self, action: #selector(handleSwipeLeft(_:)))
                game.getGesturesModel().swipeRightGesture.addTarget(self, action: #selector(handleSwipeRight(_:)))
                view.addGestureRecognizer(game.getGesturesModel().swipeLeftGesture)
                view.addGestureRecognizer(game.getGesturesModel().swipeRightGesture)
            case .tap:
                game.getGesturesModel().tapGesture.addTarget(self, action: #selector(handleTap(_:)))
                view.addGestureRecognizer(game.getGesturesModel().tapGesture)
        }

    }
    
    private func generateObstacles() {
        let randomObstacle = Int.random(in: 0..<100)
        let newObstacle: Obstacle = Obstacle()
        switch randomObstacle {
            case 0..<25:
                newObstacle.frame = CGRect(x: view.bounds.minX+50, y: UR.Constants.GameScreen.obstacleHeight, width: UR.Constants.GameScreen.obstacleWidth, height: UR.Constants.GameScreen.obstacleHeight)
            case 25..<50:
                newObstacle.frame = CGRect(x: view.bounds.width/4*2+50, y: UR.Constants.GameScreen.obstacleHeight, width: UR.Constants.GameScreen.obstacleWidth, height: UR.Constants.GameScreen.obstacleHeight)
            case 50...75:
                newObstacle.frame = CGRect(x: view.bounds.width/4*3+50, y: UR.Constants.GameScreen.obstacleHeight, width: UR.Constants.GameScreen.obstacleWidth, height: UR.Constants.GameScreen.obstacleHeight)
            case 75...100:
                newObstacle.frame = CGRect(x: view.bounds.width-50, y: UR.Constants.GameScreen.obstacleHeight, width: UR.Constants.GameScreen.obstacleWidth, height: UR.Constants.GameScreen.obstacleHeight)
            default:
                newObstacle.frame = CGRect(x: view.bounds.midX, y: UR.Constants.GameScreen.obstacleHeight, width: UR.Constants.GameScreen.obstacleWidth, height: UR.Constants.GameScreen.obstacleHeight)
        }
        
        self.view.addSubview(newObstacle)
        game.addObstacles(obstacle: newObstacle)
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
        for obstacle in game.getObstacles() {
            UIView.animate(withDuration: game.getAnimationDuration()) {
                obstacle.frame.origin.y += self.game.getObstacleSpeed()
            }
            
            if obstacle.frame.origin.y > UIScreen.main.bounds.height {
                obstacle.removeFromSuperview()
                game.removeFirstObstacle()
            }
        }
    }
    
    private func removeAllObstacles() {
        for obstacle in game.getObstacles() {
            obstacle.removeFromSuperview()
        }
        game.removeAllObstacles()
    }
    
    private func checkCollision() {
        let rect = CGRect(x: carImageView.center.x, y: carImageView.center.y, width: 40, height: 96)
        for obstacle in game.getObstacles() {
            if rect.intersects(obstacle.frame) {
                gameOver()
            }
            if doViewsIntersectY(view1: carImageView, view2: obstacle) && obstacle.intersectByCar == false {
                updateScoreLabel()
                obstacle.intersectByCar = true
            }
        }
        if !rect.intersects(view.frame) {
            gameOver()
        }
    }
    
    private func doViewsIntersectY(view1: UIView, view2: UIView) -> Bool {
        let view1Frame = view1.frame
        let view2Frame = view2.frame
        
        let intersectsOnY = (view1Frame.origin.y < view2Frame.origin.y + view2Frame.size.height) &&
                            (view1Frame.origin.y + view1Frame.size.height > view2Frame.origin.y)
        
        return intersectsOnY
    }
    
    private func makeConstraints() {
        carImageView.frame = CGRect(x: view.center.x, y: view.bounds.maxY-164, width: 96, height: 96)
        carImageView.center = CGPoint(x: view.center.x, y: view.bounds.maxY-164)
        
        roadView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(UR.Constants.GameScreen.roadViewLeading)
            make.trailing.equalToSuperview().inset(UR.Constants.GameScreen.roadViewTrailing)
            make.top.bottom.equalToSuperview()
        }
        
        gameScoreLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(UR.Constants.GameScreen.gameScoreLabelTrailing)
            make.top.equalToSuperview().offset(UR.Constants.GameScreen.gameScoreLabelTop)
            make.height.equalTo(UR.Constants.GameScreen.gameScoreLabelHeight)
        }
    }
    
    private func updateScoreLabel() {
        game.upGameScore()
        self.gameScoreLabel.text = String("\(LocalizedStrings.scoreLabelText)\(game.getGameScore())")
    }
    
    private func showGameOverAlertController() {
        let alertController = UIAlertController(title: "Вы проиграли(", message:
                                                    "Количество очков: \(game.getGameScore())\nУровень сложности: \(game.getSettingsModel().getDifficultType().rawValue)\nТип управления: \(game.getSettingsModel().getControlType().rawValue)\nДля того, чтобы начать заново нажмите кнопку ниже", preferredStyle: .alert)

        let cancelButton = UIAlertAction(title: LocalizedStrings.saveAndExitMessage, style: .cancel) {_ in
            self.navigationController?.popToRootViewController(animated: true)
            let currentData = Date()
            try? StorageService.shared.saveUserRatings(User(username: self.game.getSettingsModel().getNickname(), score: self.game.getGameScore(), date: currentData, avatarImageKey: self.game.getSettingsModel().getImageid()))
        }
        let startAgainButton = UIAlertAction(title: LocalizedStrings.startAgainMessage, style: .default) { _ in
            self.game.setGameScore(newScore: 0)
            self.gameScoreLabel.text = "\(LocalizedStrings.scoreLabelText)0"
            self.carImageView.center = CGPoint(x: self.view.center.x, y: self.view.bounds.maxY-164)
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
    

    
