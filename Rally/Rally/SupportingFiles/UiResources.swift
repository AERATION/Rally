
import Foundation

final class UR {
    
    struct Constants {
        static let leftAnchors = 16
        static let topAnchors = 16
        static let rightAnchors = 16
        static let bottomAnchors = 16
        static let startButtonsHeight = 42
        
        static let changeAvatarButtonTop = 32
        static let changeAvatarButtonHeight = 32
        static let changeAvatarButtonWidth = 232
        
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
        static let ratingTableViewRowHeight = 64
        
        static let avatarImageViewCellLeading = 16
        static let avatarImageViewCellHeight = 48
        static let avatarImageViewCellWidth = 48
        
        static let nicknameLabelLeading = 16
        static let nicknameLabelHeight = 16
        
        static let scoreLabelLeading = 16
        static let scoreLabelHeight = 32
        
        static let dataLabelLeading = 32
        static let dataLabelHeight = 32
        
        static let controlTypeCellIdentifier = "ControlTypeCell"
        static let difficultyCellIdentifier = "DifficultyCell"
        static let nicknameCellIdentifier = "NicknameCell"
    }
    
    struct DataKeys {
        static let controlTypeKey = "ControlType"
        static let difficultyKey = "Difficulty"
        static let settingsKey = "Settings"
        static let nicknameKey = "Nickname"
        static let ratingsKey = "Ratings"
    }
    
    struct Fonts {
        static let buttonFont = FM.interBlack(23)
        static let textFont = FM.interRegular(20)
    }
}
