
import Foundation
import UIKit

final class Obstacle: UIImageView {
    var intersectByCar: Bool = false
    
    init() {
        super.init(frame: .zero)
        self.image = UIImage(named: "Box")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
