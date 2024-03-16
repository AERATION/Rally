import UIKit
import Foundation
import SnapKit

final class SettingsViewController: UIViewController, UINavigationControllerDelegate {
    
    //MARK: - Properties
    private var avatarImageView: UIImageView = {
        let imageView  = UIImageView()
        imageView.image = UIImage(named:"DefaultUserImage")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    } ()
    
    private let settingsTableView: UITableView = UITableView()
    
    private let avatarPicker = UIImagePickerController()
    
    private let changeAvatarButton = SubmitButton(titleLabel: LocalizedStrings.changeAvatarButtonTitle)

    private var settingsModel: SettingsModel = SettingsModel()
    
    var pickerView: UIPickerView!

    //MARK: - VC methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        changeAvatarButton.addTarget(self, action: #selector(selectAvatarTapped(sender: )), for: .touchDown)
        configureUI()
        loadData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        StorageService.shared.save(self.settingsModel)
    }
    
    //MARK: Private functions
    private func loadData() {
        if let settings = StorageService.shared.load() {
            self.settingsModel.setControlType(controlType: settings.getControlType())
            self.settingsModel.setDifficultType(difficultType: settings.getDifficultType())
            self.settingsModel.setNickname(nickname: settings.getNickname())
            self.settingsModel.setImageId(imageid: settings.getImageid())
            self.settingsModel.setCarImage(carImage: settings.getCarImage())
            self.settingsModel.setObstacleImage(obstacleImage: settings.getObstacleImage())
            self.avatarImageView.image = StorageService.shared.loadImage(by: self.settingsModel.getImageid())
        }
    }
    
    private func configureUI() {
        avatarPicker.delegate = self
        view.backgroundColor = .white
        view.addSubview(settingsTableView)
        settingsTableView.rowHeight = UR.Constants.SettingsScreen.settingsTableViewHeight
        view.addSubview(avatarImageView)
        view.addSubview(changeAvatarButton)
        
        title = LocalizedStrings.settingsButtonTitle
        setupTableView()
        makeConstraints()
    }
    
    private func makeConstraints() {
        
        avatarImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(UR.Constants.SettingsScreen.avatarImageViewTop)
            make.centerX.equalToSuperview()
            make.height.equalTo(UR.Constants.SettingsScreen.avatarImageViewHeight)
            make.width.equalTo(UR.Constants.SettingsScreen.avatarImageViewWidth)
        }
        
        changeAvatarButton.snp.makeConstraints { make in
            make.top.equalTo(avatarImageView.snp.bottom).offset(UR.Constants.SettingsScreen.changeAvatarButtonTop)
            make.centerX.equalToSuperview()
            make.height.equalTo(UR.Constants.SettingsScreen.changeAvatarButtonHeight)
            make.width.equalTo(UR.Constants.SettingsScreen.changeAvatarButtonWidth)
        }
        
        settingsTableView.snp.makeConstraints { make in
            make.top.equalTo(changeAvatarButton.snp.bottom).offset(UR.Constants.SettingsScreen.settingTableViewTop)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    private func setupTableView() {
        settingsTableView.dataSource = self
        settingsTableView.delegate = self
        
        settingsTableView.register(UITableViewCell.self, forCellReuseIdentifier: UR.TableViews.controlTypeCellIdentifier)
        settingsTableView.register(UITableViewCell.self, forCellReuseIdentifier: UR.TableViews.difficultyCellIdentifier)
        settingsTableView.register(UITableViewCell.self, forCellReuseIdentifier: UR.TableViews.nicknameCellIdentifier)
        
        settingsTableView.tableFooterView = UIView()
    }
    
    //MARK: - Functions
    @objc func selectAvatarTapped(sender: UITextField) {
        present(avatarPicker, animated: true, completion: nil)
    }
    
    func setAvatarImage(image: UIImage) {
        self.avatarImageView.image = image
    }
    
    func settingsTableReloadData() {
        settingsTableView.reloadData()
    }
    //MARK: - Getters
    func getSettingsTableView() -> UITableView { return settingsTableView }
    
    func getSettingsModel() -> SettingsModel { return settingsModel }
}
