
import UIKit
import Foundation

class CustomSegmentedControl: UISegmentedControl {
    
    
    let items = [UIImage(named: "Car"), UIImage(named: "Car2"), UIImage(named: "Car3")]
    init() {
        super.init(items: items)
//        super.init(frame: .zero)
        setupSegmentedControl()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSegmentedControl() {
        self.selectedSegmentIndex = 0
    }
}
