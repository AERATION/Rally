import UIKit
import Foundation
import SnapKit

class SettingsViewController: UIViewController, UINavigationControllerDelegate {
    
    let controlTypeCellIdentifier = "ControlTypeCell"
    let difficultyCellIdentifier = "DifficultyCell"
    let nicknameCellIdentifier = "NicknameCell"
    
    var imageCache = NSMutableDictionary()
    
    var avatarImageView: UIImageView = {
        let imageView  = UIImageView()
        imageView.image = UIImage(named:"DefaultUserImage")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    } ()
    
    var settingsModel: SettingsModel = SettingsModel(controlType: .swipe, difficultType: .easy, nickName: "User", imageId: "DefaultUserImage") 
    
    let avatarPicker = UIImagePickerController()
    
    let changeAvatarButton = SubmitButton(titleLabel: "Сменить аватарку")
    
    var pickerView: UIPickerView!
    
    var toolbar: UIToolbar!
    
    let settingsTableView: UITableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Настройки"

        changeAvatarButton.addTarget(self, action: #selector(selectAvatarTapped(sender: )), for: .touchDown)
        configureUI()

        if let settings = StorageService.shared.load() {
            self.settingsModel.controlType = settings.controlType
            self.settingsModel.difficultType = settings.difficultType
            self.settingsModel.nickName = settings.nickName
            self.settingsModel.imageId = settings.imageId
            self.avatarImageView.image = StorageService.shared.loadImage(by: self.settingsModel.imageId)
        }
      
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        StorageService.shared.save(self.settingsModel)
    }
    
    private func configureUI() {
        avatarPicker.delegate = self
        view.backgroundColor = .white
        view.addSubview(settingsTableView)
        view.addSubview(avatarImageView)
        view.addSubview(changeAvatarButton)
        
        setupTableView()
        makeConstraints()
    }
    
    private func setupTableView() {
        settingsTableView.dataSource = self
        settingsTableView.delegate = self
        
        settingsTableView.register(UITableViewCell.self, forCellReuseIdentifier: controlTypeCellIdentifier)
        settingsTableView.register(UITableViewCell.self, forCellReuseIdentifier: difficultyCellIdentifier)
        settingsTableView.register(UITableViewCell.self, forCellReuseIdentifier: nicknameCellIdentifier)
        
        settingsTableView.tableFooterView = UIView()
    }
    
    @objc func selectAvatarTapped(sender: UITextField) {
            present(avatarPicker, animated: true, completion: nil)
    }
    
    private func makeConstraints() {
        
        avatarImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(UR.Constants.avatarImageViewTop)
            make.centerX.equalToSuperview()
            make.height.equalTo(UR.Constants.avatarImageViewHeight)
            make.width.equalTo(UR.Constants.avatarImageViewWidth)
        }
        
        changeAvatarButton.snp.makeConstraints { make in
            make.top.equalTo(avatarImageView.snp.bottom).offset(UR.Constants.changeAvatarButtonTop)
            make.centerX.equalToSuperview()
            make.height.equalTo(UR.Constants.changeAvatarButtonHeight)
            make.width.equalTo(UR.Constants.changeAvatarButtonWidth)
        }
        
        settingsTableView.snp.makeConstraints { make in
            make.top.equalTo(changeAvatarButton.snp.bottom).offset(UR.Constants.settingTableViewTop)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
