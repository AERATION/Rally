
import Foundation

final class UR {
    struct Constants {
        
        //MARK: - Game model constants
        struct Game {
            static let easySpeed: CGFloat = 15
            static let mediumSpeed: CGFloat = 20
            static let hardSpeed: CGFloat = 30
            
            static let easySpawn: TimeInterval = 3
            static let mediumSpawn: TimeInterval = 2
            static let hardSpawn: TimeInterval = 1
            
            static let easyCheckCollision: TimeInterval = 0.3
            static let mediumCheckCollision: TimeInterval = 0.3
            static let hardCheckCollision: TimeInterval = 0.1
            
            static let easyAnimationDuration: Double = 0.6
            static let mediumAnimationDuration: Double = 0.5
            static let hardAnimationDuration: Double = 0.3
        }
        
        //MARK: - GameScreen constants
        struct GameScreen {
            static let roadViewLeading = 86
            static let roadViewTrailing = 86
            
            static let gameScoreLabelTop = 48
            static let gameScoreLabelTrailing = 48
            static let gameScoreLabelHeight = 48
            
            static let obstacleHeight: CGFloat = 50
            static let obstacleWidth: CGFloat = 50
            
            static let carImageViewWidth: CGFloat = 96
            static let carImageViewHeight: CGFloat = 96
            static let carImageViewY: CGFloat = 164
            static let carSpeed: CGFloat = 80
            static let carMoveAnimationDuration = 0.3
        }
        
        //MARK: - SettingsScreen constants
        struct SettingsScreen {
            static let avatarImageViewTop = 128
            static let avatarImageViewHeight = 128
            static let avatarImageViewWidth = 128
            
            static let changeAvatarButtonTop = 32
            static let changeAvatarButtonHeight = 32
            static let changeAvatarButtonWidth = 232
            
            static let settingTableViewTop = 32
            static let settingsTableViewHeight: CGFloat = 64
        }
        
        //MARK: - StartScreen constants
        struct StartScreen {
            static let startImageViewTop = 64
            static let startImageViewHeight = 256
            static let startImageViewWidth = 256
            
            static let startButtonBottom = -16
            static let startButtonLeading = 16
            static let startButtonTrailing = 16
            static let startButtonHeight = 42
        }
    }
    
    //MARK: - TableView constants
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
        
        static let controlTypeButtonWidth = 200
        static let controlTypeButtonHeight = 30
        
        static let difficultyButtonWidth = 200
        static let difficultyButtonHeight = 30
        
        static let nickLabelWidth = 125
        static let nickLabelHeight = 30
        
        static let carLabelWidth = 230
        static let carLabelHeight = 50
        
        static let obstacleLabelWidth = 230
        static let obstacleLabelHeight = 60
        
        static let pickerViewHeight: CGFloat = 216
        
        static let controlTypeCellIdentifier = "ControlTypeCell"
        static let difficultyCellIdentifier = "DifficultyCell"
        static let nicknameCellIdentifier = "NicknameCell"
    }
    
    //MARK: - DataKeys
    struct DataKeys {
        static let settingsKey = "Settings"
        static let ratingsKey = "Ratings"
    }
    
    //MARK: - Fonts
    struct Fonts {
        static let buttonFont = FM.interBlack(23)
        static let textFont = FM.interRegular(20)
    }
}
