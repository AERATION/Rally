
import Foundation
import UIKit

final class GesturesModel {
    
    //MARK: - Propertiest
    private var swipeLeftGesture: UISwipeGestureRecognizer = UISwipeGestureRecognizer()
    
    private var swipeRightGesture: UISwipeGestureRecognizer = UISwipeGestureRecognizer()
    
    private var tapGesture: UITapGestureRecognizer = UITapGestureRecognizer()
    
    //MARK: - Init
    init() {
        setGesturesPropertioes()
    }
    
    //MARK: - Setters
    private func setGesturesPropertioes() {
        self.swipeLeftGesture.direction = .left
        self.swipeRightGesture.direction = .right
        self.tapGesture.numberOfTapsRequired = 1
    }
    
    //MARK: - Getters
    func getSwipeLeft() -> UISwipeGestureRecognizer { return swipeLeftGesture }
    
    func getSwipeRight() -> UISwipeGestureRecognizer { return swipeRightGesture }
    
    func getTap() -> UITapGestureRecognizer { return tapGesture }
}
