
import Foundation

extension String {
    func localized() -> String {
        return NSLocalizedString(self, tableName: "LocalizedStrings", bundle: .main, value: self, comment: self)
    }
}
