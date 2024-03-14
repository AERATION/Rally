
import UIKit
import Foundation

class CustomSegmentedControl: UISegmentedControl {
    
    var carRedImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Car")
        return imageView
    } ()
    
    var carBlueImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Car3")
        return imageView
    } ()
    
    var carGreenImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Car2")
        return imageView
    } ()
    let img = UIImage(named: "Obstacle2")
    
    let items = [UIImage(named: "Car"), UIImage(named: "Car2"), UIImage(named: "Car3")]
    init() {
//        let items = [carRedImage, carBlueImage, carGreenImage]
        super.init(items: items)
        setupSegmentedControl()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSegmentedControl() {
        self.selectedSegmentIndex = 0
//        self.layer.cornerRadius = 5
    }
}
