
import Foundation
import UIKit

final class GesturesModel {
    
    let swipeLeftGesture: UISwipeGestureRecognizer = UISwipeGestureRecognizer()
    
    let swipeRightGesture: UISwipeGestureRecognizer = UISwipeGestureRecognizer()
    
    let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer()
    
    init() {
        setGesturesPropertioes()
    }
    
    private func setGesturesPropertioes() {
        self.swipeLeftGesture.direction = .left
        self.swipeRightGesture.direction = .right
        self.tapGesture.numberOfTapsRequired = 1
    }
}
