
import UIKit

//MARK: - FontManager
class FM {
    //MARK: - Inter
    static func interRegular(_ size: CGFloat) -> UIFont {
        return UIFont(name:"Inter-Regular", size: size) ?? .systemFont(ofSize: size)
    }
    
    static func interBlack(_ size: CGFloat) -> UIFont {
        return UIFont(name:"Inter-Black", size: size)  ?? .systemFont(ofSize: size)
    }
}
