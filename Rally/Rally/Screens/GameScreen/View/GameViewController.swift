import UIKit
import Foundation

class GameViewController: UIViewController, UIGestureRecognizerDelegate {
    
//    private let roadView: UIView = {
//        let road: UIView = UIView()
//        road.backgroundColor = .lightGray
//        return road
//    } ()
//    
//    private let carImageView: UIImageView = {
//        let imageView  = UIImageView()
//        imageView.image = UIImage(named:"Car")
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        return imageView
//    } ()
//    
//    
//    var obstacles = [UIView]()
//    
//    var obstaclesTimer: Timer?
//    
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        configureUI()
//    }
//    
//    private func configureUI() {
//        view.backgroundColor = .white
//        view.addSubview(roadView)
//        view.addSubview(carImageView)
//
//        
//        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
//        view.addGestureRecognizer(panGesture)
//
//        makeConstraints()
//        
//        obstaclesTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
//            self?.updateObstacles()
//        }
//    }
//    
//    func updateObstacles() {
//        let randomObstacle = Int.random(in: 0..<100)
//        let obstacleCreate = randomObstacle >= 70 ? true : false
//        if obstacleCreate {
//            let newObstacle = UIView()
//            newObstacle.frame = CGRect(x: view.bounds.midX, y: 50, width: 50, height: 50)
//            newObstacle.backgroundColor = .red
//            view.addSubview(newObstacle)
//            obstacles.append(newObstacle)
//        }
//        for obstacle in obstacles {
//            obstacle.frame.origin.y += 20
//            if obstacle.frame.origin.y > view.bounds.height {
//                // Если препятствие выходит за пределы экрана, удаляем его
//                obstacle.removeFromSuperview()
//            }
//        }
//        checkCollision()
//    }
//        
//    func checkCollision() {
//        for obstacle in obstacles {
//            if carImageView.frame.intersects(obstacle.frame) {
//                // Обработка столкновения
//                print("Game Over")
//                // Здесь вы можете добавить код для окончания игры
//            }
//        }
//    }
//    
//    @objc func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
//        let translation = gesture.translation(in: view)
//        let velocity = gesture.velocity(in: view)
//        
//        switch gesture.state {
//        case .began:
//            // Обработка начала жеста
//            break
//        case .changed:
//            // Обработка изменения положения жеста
//            if translation.x > 0 {
//                // Если пользователь перемещает вправо, повернуть машину вправо
//                carImageView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi / 4))
//                carImageView.center.x += 5
//            } else if translation.x < 0 {
//                // Если пользователь перемещает влево, повернуть машину влево
//                carImageView.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi / 4))
//                carImageView.center.x -= 5
//            }
////            let rotationAngle = translation.x > 0 ? CGFloat.pi / 8 : -CGFloat.pi / 8
////            let rotation = CGAffineTransform(rotationAngle: rotationAngle)
////            carImageView.transform = rotation
////
////            let newX = carImageView.center.x + translation.x
////            if newX > 0 && newX < view.bounds.width - carImageView.bounds.width {
////                carImageView.center.x = newX
////            }
//            break
//        case .ended:
//            // Обработка окончания жеста
//            // Возвращаем машину в исходное положение
//            carImageView.transform = .identity
//            break
//        default:
//            // Обработка отмены жеста
//            carImageView.transform = .identity
//            break
//        }
//        gesture.setTranslation(CGPoint.zero, in: view)
//        
//    }
//    
//
//    
//    private func makeConstraints() {
//        roadView.snp.makeConstraints { make in
//            make.left.equalToSuperview().offset(86)
//            make.right.equalToSuperview().inset(86)
//            make.top.bottom.equalToSuperview()
//        }
//        carImageView.snp.makeConstraints{ make in
//            make.height.equalTo(96)
//            make.width.equalTo(96)
//            make.centerX.equalToSuperview()
//            make.bottom.equalToSuperview().inset(48)
//        }
//    }

    let carImageView: UIImageView = {
          let imageView = UIImageView()
          imageView.image = UIImage(named: "Car") // Замените "car" на ваше изображение машины
          imageView.translatesAutoresizingMaskIntoConstraints = false
          return imageView
      }()
      
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
      
      override func viewDidLoad() {
          super.viewDidLoad()
          view.backgroundColor = .white
          view.addSubview(carImageView)
          swipeLeftGesture.addTarget(self, action: #selector(handleSwipeLeft(_:)))
          swipeRightGesture.addTarget(self, action: #selector(handleSwipeRight(_:)))
//          view.addGestureRecognizer(swipeLeftGesture)
//          view.addGestureRecognizer(swipeRightGesture)
          tapGesture.addTarget(self, action: #selector(handleTap(_:)))
          view.addGestureRecognizer(tapGesture)

          // Ограничения для машины
          carImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
          carImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
          carImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true // Замените 100 на желаемую ширину машины
          carImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true // Замените 50 на желаемую высоту машины
          
          // Начальное положение машины
//          carImageView.transform = CGAffineTransform(rotationAngle: .pi / 2) // Поворот машины на 90 градусов (вертикально вверх)
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
          print("swipe left")
      }
      
      @objc func handleSwipeRight(_ gestureRecognizer: UIGestureRecognizer) {
          moveCar(to: .right)
          print("swiftright")
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
      
      enum Direction {
          case left
          case right
      }

}
    
