import UIKit
import Foundation
import SnapKit

class SettingsViewController: UIViewController, UINavigationControllerDelegate {
    
    let controlTypeCellIdentifier = "ControlTypeCell"
    let difficultyCellIdentifier = "DifficultyCell"
    let nicknameCellIdentifier = "NicknameCell"
    
    let cache = NSCache<NSString, UIImage>()
    
    var avatarImageView: UIImageView = {
        let imageView  = UIImageView()
        imageView.image = UIImage(named:"DefaultUserImage")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    } ()
    
    var controlType: ControlType = .swipe {
        didSet {
            UserDefaults.standard.set(controlType.rawValue, forKey: UR.DataKeys.controlTypeKey)
        }
    }
    
    var difficulty: Difficulty = .easy {
        didSet {
            UserDefaults.standard.set(difficulty.rawValue, forKey: UR.DataKeys.difficultyKey)
        }
    }
    
    var nickname: String = "User" {
        didSet {
            UserDefaults.standard.set(nickname, forKey: UR.DataKeys.nicknameKey)
        }
    }
    
    let avatarPicker = UIImagePickerController()
    
    let changeAvatarButton = SubmitButton(titleLabel: "Сменить аватарку")
    
    var pickerView: UIPickerView!
    var toolbar: UIToolbar!
    
    let settingsTableView: UITableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Настройки"
        avatarPicker.delegate = self
        view.backgroundColor = .white
        view.addSubview(settingsTableView)
        view.addSubview(avatarImageView)
        view.addSubview(changeAvatarButton)
        changeAvatarButton.addTarget(self, action: #selector(selectAvatarTapped(sender: )), for: .touchDown)
        settingsTableView.dataSource = self
        settingsTableView.delegate = self
        settingsTableView.register(UITableViewCell.self, forCellReuseIdentifier: controlTypeCellIdentifier)
        settingsTableView.register(UITableViewCell.self, forCellReuseIdentifier: difficultyCellIdentifier)
        settingsTableView.register(UITableViewCell.self, forCellReuseIdentifier: nicknameCellIdentifier)
        makeConstraints()
        settingsTableView.tableFooterView = UIView()
        
        if let savedControlType = UserDefaults.standard.string(forKey: UR.DataKeys.controlTypeKey),
          let controlType = ControlType(rawValue: savedControlType) {
           self.controlType = controlType
        }
       
        if let savedDifficulty = UserDefaults.standard.string(forKey: UR.DataKeys.difficultyKey),
          let difficulty = Difficulty(rawValue: savedDifficulty) {
           self.difficulty = difficulty
        }
        if let savedNickname = UserDefaults.standard.string(forKey: UR.DataKeys.nicknameKey) {
            self.nickname = savedNickname
        }
        let avatarImageKey = "avatarImage" as NSString
        if let avatarImage = cache.object(forKey: avatarImageKey) {
            avatarImageView.image = avatarImage
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    @objc func selectAvatarTapped(sender: UITextField) {
            present(avatarPicker, animated: true, completion: nil)
    }
    
    private func makeConstraints() {
        
        avatarImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(128)
            make.centerX.equalToSuperview()
            make.height.equalTo(96)
            make.width.equalTo(96)
        }
        
        changeAvatarButton.snp.makeConstraints { make in
            make.top.equalTo(avatarImageView.snp.bottom).offset(32)
            make.centerX.equalToSuperview()
            make.height.equalTo(32)
            make.width.equalTo(164)
        }
        
        settingsTableView.snp.makeConstraints { make in
            make.top.equalTo(changeAvatarButton.snp.bottom).offset(32)
//            make.edges.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

enum ControlType: String, CaseIterable {
    case swipe = "Свайп"
    case accelerometer = "Акселерометр"
    case tap = "Тап по экрану"
}

enum Difficulty: String, CaseIterable {
    case easy = "Легкая"
    case medium = "Средняя"
    case hard = "Сложная"
}


