
import Foundation
import UIKit

final class GesturesModel {
    
    private let swipeLeftGesture: UISwipeGestureRecognizer
    
    private let swipeRightGesture: UISwipeGestureRecognizer
    
    private let tapGesture: UITapGestureRecognizer
    
    init(swipeLeftGesture: UISwipeGestureRecognizer, swipeRightGesture: UISwipeGestureRecognizer, tapGesture: UITapGestureRecognizer) {
        self.swipeLeftGesture = swipeLeftGesture
        self.swipeRightGesture = swipeRightGesture
        self.tapGesture = tapGesture
        setGesturesPropertioes()
    }
    
    private func setGesturesPropertioes() {
        self.swipeLeftGesture.direction = .left
        self.swipeRightGesture.direction = .right
        self.tapGesture.numberOfTapsRequired = 1
    }
}
