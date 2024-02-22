

import Foundation
import UIKit

class MovingDashedLineView: UIView {
    private let lineLayer = CAShapeLayer()
    private var animator: UIViewPropertyAnimator?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupDashedLine()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupDashedLine()
    }
    
    private func setupDashedLine() {
        lineLayer.strokeColor = UIColor.black.cgColor
        lineLayer.lineWidth = 2.0 // Установите желаемую ширину линии
        lineLayer.lineDashPattern = [4, 4] // Паттерн 4 пикселя штриха, 4 пикселя пробела
        lineLayer.frame = bounds
        
        // Создаем путь для линии
        let path = UIBezierPath()
        path.move(to: CGPoint(x: bounds.midX, y: 0))
        path.addLine(to: CGPoint(x: bounds.midX, y: bounds.maxY))
        lineLayer.path = path.cgPath
        
        // Добавляем слой на вьюху
        layer.addSublayer(lineLayer)
    }
    
    func startMovingLine() {
        // Создаем аниматор для движения линии вниз
        animator = UIViewPropertyAnimator(duration: 2.0, curve: .linear) {
            self.lineLayer.position = CGPoint(x: self.lineLayer.position.x, y: self.bounds.height)
        }
        
        // Зацикливаем анимацию
//        animator?.isRepeatable = true
        
        // Запускаем анимацию
        animator?.startAnimation()
    }
    
    func stopMovingLine() {
        // Останавливаем анимацию
        animator?.stopAnimation(true)
        animator = nil
    }
}

