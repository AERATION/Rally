
import UIKit
import Foundation

final class ImageCache {
    static var shared = ImageCache()
    
    private let imageCache = NSCache<NSString, UIImage>()
    
    func save(key: String,value: UIImage) {
        imageCache.setObject(value, forKey: key as NSString)
    }
    
    func get(key: String) -> UIImage? {
        return imageCache.object(forKey: key as NSString)
    }
}
