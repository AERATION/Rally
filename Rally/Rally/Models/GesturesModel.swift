
import Foundation
import UIKit

protocol GesturesProtocol {
    var swipeLeftGesture: UISwipeGestureRecognizer { get }
    
    var swipeRightGesture: UISwipeGestureRecognizer { get }
    
    var tapGesture: UITapGestureRecognizer { get }
}

final class GesturesModel: GesturesProtocol {
    
    var swipeLeftGesture: UISwipeGestureRecognizer = UISwipeGestureRecognizer()
    
    var swipeRightGesture: UISwipeGestureRecognizer = UISwipeGestureRecognizer()
    
    var tapGesture: UITapGestureRecognizer = UITapGestureRecognizer()
    
    init() {
        setGesturesPropertioes()
    }
    
    private func setGesturesPropertioes() {
        self.swipeLeftGesture.direction = .left
        self.swipeRightGesture.direction = .right
        self.tapGesture.numberOfTapsRequired = 1
    }
}
