
import Foundation

class UR {
    
    struct Constants {
        static let leftAnchors = 16
        static let topAnchors = 16
        static let rightAnchors = 16
        static let bottomAnchors = 16
        static let startButtonsHeight = 42
        
        static let changeAvatarButtonTop = 32
        static let changeAvatarButtonHeight = 32
        static let changeAvatarButtonWidth = 164
        
        static let avatarImageViewTop = 128
        static let avatarImageViewHeight = 128
        static let avatarImageViewWidth = 128
        
        static let settingTableViewTop = 32
        
        static let roadViewLeading = 86
        static let roadViewTrailing = 86
        
        static let gameScoreLabelTop = 48
        static let gameScoreLabelTrailing = 48
        static let gameScoreLabelHeight = 48
        
        static let obstacleHeight: CGFloat = 50
        static let obstacleWidth: CGFloat = 50
    }
    
    struct TableViews {
        static let ratingTableViewCell = "MyCell"
    }
    
    struct DataKeys {
        static let controlTypeKey = "ControlType"
        static let difficultyKey = "Difficulty"
        static let settingsKey = "Settings"
        static let nicknameKey = "Nickname"
        static let ratingsKey = "Ratings"
    }
}
