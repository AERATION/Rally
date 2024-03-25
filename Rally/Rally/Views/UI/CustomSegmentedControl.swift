
import UIKit
import Foundation

class CustomSegmentedControl: UISegmentedControl {
    
    private let carItems = [UIImage(named: "Car"), UIImage(named: "Car2"), UIImage(named: "Car3")]
    
    private let obstacleItems = [UIImage(named: "Obstacle"), UIImage(named: "Obstacle2"), UIImage(named: "Obstacle3")]

    enum SegmentedItem {
        case cars
        case obstacles
    }
    
    init(segmentedItem: SegmentedItem) {
        switch segmentedItem {
            case .cars:
                super.init(items: carItems)
            case .obstacles:
                super.init(items: obstacleItems)
        }
        setupSegmentedControl()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSegmentedControl() {
        self.selectedSegmentIndex = 0
    }
}
