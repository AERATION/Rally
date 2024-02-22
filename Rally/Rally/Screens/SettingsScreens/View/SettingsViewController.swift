import UIKit
import Foundation
import SnapKit




//enum ControlType: String, CaseIterable {
//    case swipe = "Свайп"
//    case accelerometer = "Акселерометр"
//    case tap = "Тап по экрану"
//}
//
//enum Difficulty: String, CaseIterable {
//    case easy = "Легкая"
//    case medium = "Средняя"
//    case hard = "Сложная"
//}
//
//class SettingsViewController: UIViewController {
//    
//    private let settingsTableView: UITableView = UITableView()
//    
//    public let controlTypeKey = "ControlType"
//    public let difficultyKey = "Difficulty"
//    
//    var controlType: ControlType = .swipe {
//        didSet {
//            UserDefaults.standard.set(controlType.rawValue, forKey: controlTypeKey)
//        }
//    }
//    
//    var difficulty: Difficulty = .easy {
//        didSet {
//            UserDefaults.standard.set(difficulty.rawValue, forKey: difficultyKey)
//        }
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        configureUI()
//        settingsTableView.dataSource = self
//        
//    }
//    
//    private func configureUI() {
//        view.backgroundColor = .white
//        view.addSubview(settingsTableView)
//        makeConstraints()
//    }
//    
//    private func makeConstraints() {
//        settingsTableView.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//        }
//    }
//    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        //tableView.register(UITableViewCell.self, forCellReuseIdentifier: "SettingsCell")
//    }
//    
//}
//
//extension SettingsViewController: UITableViewDataSource {
//    
//
//    
//    func numberOfSections(in tableView: UITableView) -> Int {
//            return 1
//    }
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        2
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell(style: .default, reuseIdentifier: "MyCell")
//                
//        switch indexPath.row {
//            case 0:
//                cell.textLabel?.text = "Тип управленияdfsfgsfgsfg"
//                let controlTypeControl = UISegmentedControl(items: ControlType.allCases.map { $0.rawValue })
//                controlTypeControl.selectedSegmentIndex = ControlType.allCases.firstIndex(of: controlType)!
//                controlTypeControl.addTarget(self, action: #selector(controlTypeChanged(_:)), for: .valueChanged)
//                cell.accessoryView = controlTypeControl
//            case 1:
//                cell.textLabel?.text = "Сложностьafsdafadsfadgadgasdfgagddagd"
//                let difficultyControl = UISegmentedControl(items: Difficulty.allCases.map { $0.rawValue })
//                difficultyControl.selectedSegmentIndex = Difficulty.allCases.firstIndex(of: difficulty)!
//                difficultyControl.addTarget(self, action: #selector(difficultyChanged(_:)), for: .valueChanged)
//                cell.accessoryView = difficultyControl
//            default:
//                break
//        }
//        
//        return cell
//    }
//    
//    @objc func controlTypeChanged(_ sender: UISegmentedControl) {
//        
//    }
//    
//    @objc func difficultyChanged(_ sender: UISegmentedControl) {
//        
//    }
//
//}

//class SettingsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
//
//    let avatarImageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.contentMode = .scaleAspectFit
//        imageView.clipsToBounds = true
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        return imageView
//    }()
//    
//    let nicknameTextField: UITextField = {
//        let textField = UITextField()
//        textField.placeholder = "Введите никнейм"
//        textField.translatesAutoresizingMaskIntoConstraints = false
//        return textField
//    }()
//    
//    let avatarPicker = UIImagePickerController()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        title = "Настройки"
//        
//        view.backgroundColor = .white
//        
//        // Настройка UIImagePickerController
//        avatarPicker.delegate = self
//        avatarPicker.allowsEditing = true
//        
//        // Добавление аватара и никнейма на экран
//        view.addSubview(avatarImageView)
//        view.addSubview(nicknameTextField)
//        
//        // Добавление кнопки для выбора аватара
//        let selectAvatarButton = UIButton(type: .system)
//        selectAvatarButton.setTitle("Выбрать аватар", for: .normal)
//        selectAvatarButton.addTarget(self, action: #selector(selectAvatarTapped), for: .touchUpInside)
//        view.addSubview(selectAvatarButton)
//        
//        // Настройка Auto Layout
//        setupAutoLayout()
//        
//        // Делегирование текстовому полю
//        nicknameTextField.delegate = self
//    }
//    
//    @objc func selectAvatarTapped() {
//        present(avatarPicker, animated: true, completion: nil)
//    }
//    
//    // MARK: - UIImagePickerControllerDelegate
//    
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        if let image = info[.originalImage] as? UIImage {
//            avatarImageView.image = image
//        }
//        dismiss(animated: true, completion: nil)
//    }
//    
//    // MARK: - UITextFieldDelegate
//    
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        // Сохранение никнейма
//        UserDefaults.standard.set(textField.text, forKey: "nickname")
//    }
//    
//    // MARK: - Auto Layout
//    
//    func setupAutoLayout() {
//        avatarImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        avatarImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -80).isActive = true
//        avatarImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
//        avatarImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
//        
//        nicknameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        nicknameTextField.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 20).isActive = true
//        nicknameTextField.widthAnchor.constraint(equalToConstant: 200).isActive = true
//        nicknameTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
//        
//        let selectAvatarButton = UIButton(type: .system)
//        selectAvatarButton.setTitle("Выбрать аватар", for: .normal)
//        selectAvatarButton.addTarget(self, action: #selector(selectAvatarTapped), for: .touchUpInside)
//        view.addSubview(selectAvatarButton)
//        selectAvatarButton.translatesAutoresizingMaskIntoConstraints = false
//        selectAvatarButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        selectAvatarButton.topAnchor.constraint(equalTo: nicknameTextField.bottomAnchor, constant: 20).isActive = true
//        selectAvatarButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
//        selectAvatarButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
//    }
//}

//import UIKit
//
//enum ControlType: String, CaseIterable {
//    case swipe = "Свайп"
//    case accelerometer = "Акселерометр"
//    case tap = "Тап по экрану"
//}
//
//enum Difficulty: String, CaseIterable {
//    case easy = "Легкая"
//    case medium = "Средняя"
//    case hard = "Сложная"
//}
//
//class SettingsTableView: UITableViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
//
//    let controlTypeKey = "ControlType"
//    let difficultyKey = "Difficulty"
//    let nicknameKey = "Nickname"
//    
//    var controlType: ControlType = .swipe {
//        didSet {
//            UserDefaults.standard.set(controlType.rawValue, forKey: controlTypeKey)
//        }
//    }
//    
//    var difficulty: Difficulty = .easy {
//        didSet {
//            UserDefaults.standard.set(difficulty.rawValue, forKey: difficultyKey)
//        }
//    }
//    
//    var nickname: String = "" {
//        didSet {
//            UserDefaults.standard.set(nickname, forKey: nicknameKey)
//        }
//    }
//    
//    var pickerView: UIPickerView!
//    var toolbar: UIToolbar!
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        title = "Настройки"
//        
//        // Загрузка сохраненных настроек
//        if let savedControlType = UserDefaults.standard.string(forKey: controlTypeKey),
//           let controlType = ControlType(rawValue: savedControlType) {
//            self.controlType = controlType
//        }
//        
//        if let savedDifficulty = UserDefaults.standard.string(forKey: difficultyKey),
//           let difficulty = Difficulty(rawValue: savedDifficulty) {
//            self.difficulty = difficulty
//        }
//        
//        nickname = UserDefaults.standard.string(forKey: nicknameKey) ?? ""
//        
//        tableView.tableFooterView = UIView()
//    }
//    
//    // MARK: - Table view data source
//    
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//    
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 3
//    }
//    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath)
//        
//        switch indexPath.row {
//        case 0:
//            cell.textLabel?.text = "Тип управления"
//            let controlTypeButton = UIButton(type: .system)
//            controlTypeButton.setTitle(controlType.rawValue, for: .normal)
//            controlTypeButton.addTarget(self, action: #selector(showControlTypePicker), for: .touchUpInside)
//            cell.accessoryView = controlTypeButton
//        case 1:
//            cell.textLabel?.text = "Сложность"
//            let difficultyButton = UIButton(type: .system)
//            difficultyButton.setTitle(difficulty.rawValue, for: .normal)
//            difficultyButton.addTarget(self, action: #selector(showDifficultyPicker), for: .touchUpInside)
//            cell.accessoryView = difficultyButton
//        case 2:
//            cell.textLabel?.text = "Никнейм"
//            let nicknameField = UITextField(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
//            nicknameField.text = nickname
//            nicknameField.delegate = self
//            cell.accessoryView = nicknameField
//        default:
//            break
//        }
//        
//        return cell
//    }
//    
//    @objc func showControlTypePicker() {
//        showPicker(withOptions: ControlType.allCases.map { $0.rawValue }, selectedOption: controlType.rawValue)
//    }
//    
//    @objc func showDifficultyPicker() {
//        showPicker(withOptions: Difficulty.allCases.map { $0.rawValue }, selectedOption: difficulty.rawValue)
//    }
//    
//    func showPicker(withOptions options: [String], selectedOption: String) {
//        pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 216))
//        pickerView.delegate = self
//        pickerView.dataSource = self
//        
//        toolbar = UIToolbar()
//        toolbar.sizeToFit()
//        
//        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(donePicker))
//        toolbar.setItems([doneButton], animated: false)
//        
//        let pickerViewController = UIViewController()
//        pickerViewController.view.addSubview(pickerView)
//        pickerViewController.view.addSubview(toolbar)
//        
//        pickerView.translatesAutoresizingMaskIntoConstraints = false
//        toolbar.translatesAutoresizingMaskIntoConstraints = false
//        
//        NSLayoutConstraint.activate([
//            pickerView.leadingAnchor.constraint(equalTo: pickerViewController.view.leadingAnchor),
//            pickerView.trailingAnchor.constraint(equalTo: pickerViewController.view.trailingAnchor),
//            pickerView.topAnchor.constraint(equalTo: pickerViewController.view.topAnchor),
//            pickerView.bottomAnchor.constraint(equalTo: toolbar.topAnchor),
//            
//            toolbar.leadingAnchor.constraint(equalTo: pickerViewController.view.leadingAnchor),
//            toolbar.trailingAnchor.constraint(equalTo: pickerViewController.view.trailingAnchor),
//            toolbar.bottomAnchor.constraint(equalTo: pickerViewController.view.bottomAnchor)
//        ])
//        
//        pickerViewController.preferredContentSize = CGSize(width: view.frame.width, height: 216 + toolbar.frame.height)
////        pickerView.selectRow(selectedOption, inComponent: 0, animated: false)
//        
//        present(pickerViewController, animated: true, completion: nil)
//    }
//    
//    @objc func donePicker() {
////        if let selectedRow = pickerView.selectedRow(inComponent: 0) {
////            if let selectedOption = ControlType.allCases[selectedRow].rawValue {
////                controlType = ControlType(rawValue: selectedOption)!
////            } else if let selectedOption = Difficulty.allCases[selectedRow].rawValue {
////                difficulty = Difficulty(rawValue: selectedOption)!
////            }
////        }
//        dismiss(animated: true, completion: nil)
//    }
//    
//    // MARK: - UIPickerViewDataSource
//    
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
//    
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return pickerView.tag == 0 ? ControlType.allCases.count : Difficulty.allCases.count
//    }
//    
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return pickerView.tag == 0 ? ControlType.allCases[row].rawValue : Difficulty.allCases[row].rawValue
//    }
//    
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        if pickerView.tag == 0 {
//            controlType = ControlType.allCases[row]
//        } else {
//            difficulty = Difficulty.allCases[row]
//        }
//    }
//    
//    // MARK: - UITextFieldDelegate
//    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//        return true
//    }
//}
//
//// MARK: - UITableViewCell
//
//class SettingsTableViewCell: UITableViewCell {
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        selectionStyle = .none
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
//
class SettingsViewController: UIViewController {
    
    let controlTypeCellIdentifier = "ControlTypeCell"
    let difficultyCellIdentifier = "DifficultyCell"
    let nicknameCellIdentifier = "NicknameCell"
    
    var controlType: ControlType = .swipe
    var difficulty: Difficulty = .easy
    var nickname: String = ""
    
    var pickerView: UIPickerView!
    var toolbar: UIToolbar!
    
    private let settingsTableView: UITableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Настройки"
        view.backgroundColor = .white
        view.addSubview(settingsTableView)
        settingsTableView.dataSource = self
        settingsTableView.delegate = self
        settingsTableView.register(UITableViewCell.self, forCellReuseIdentifier: controlTypeCellIdentifier)
        settingsTableView.register(UITableViewCell.self, forCellReuseIdentifier: difficultyCellIdentifier)
        settingsTableView.register(UITableViewCell.self, forCellReuseIdentifier: nicknameCellIdentifier)
        makeConstraints()
        settingsTableView.tableFooterView = UIView()
    }
    
    private func makeConstraints() {
        settingsTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}

extension SettingsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: indexPath.row == 0 ? controlTypeCellIdentifier : (indexPath.row == 1 ? difficultyCellIdentifier : nicknameCellIdentifier), for: indexPath)
        
        switch indexPath.row {
            case 0:
                cell.textLabel?.text = "Тип управления"
                let controlTypeButton = UIButton(type: .system)
                controlTypeButton.setTitle(controlType.rawValue, for: .normal)
//                controlTypeButton.addTarget(self, action: #selector(showControlTypePicker), for: .touchUpInside)
                cell.accessoryView = controlTypeButton
            case 1:
                cell.textLabel?.text = "Сложность"
                let difficultyButton = UIButton(type: .system)
                difficultyButton.setTitle(difficulty.rawValue, for: .normal)
//                difficultyButton.addTarget(self, action: #selector(showDifficultyPicker), for: .touchUpInside)
                cell.accessoryView = difficultyButton
            case 2:
                cell.textLabel?.text = "Никнейм"
                let nicknameField = UITextField(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
                nicknameField.text = nickname
                nicknameField.delegate = self
                cell.accessoryView = nicknameField
            default:
            break
        }
        
        return cell
    }
    
    func showPicker(withOptions options: [String], selectedOption: String) {
        pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 216))
        pickerView.delegate = self
        pickerView.dataSource = self
        
        toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(donePicker))
        toolbar.setItems([doneButton], animated: false)
        
        let pickerViewController = UIViewController()
        pickerViewController.view.addSubview(pickerView)
        pickerViewController.view.addSubview(toolbar)
        
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pickerView.leadingAnchor.constraint(equalTo: pickerViewController.view.leadingAnchor),
            pickerView.trailingAnchor.constraint(equalTo: pickerViewController.view.trailingAnchor),
            pickerView.topAnchor.constraint(equalTo: pickerViewController.view.topAnchor),
            pickerView.bottomAnchor.constraint(equalTo: toolbar.topAnchor),
            
            toolbar.leadingAnchor.constraint(equalTo: pickerViewController.view.leadingAnchor),
            toolbar.trailingAnchor.constraint(equalTo: pickerViewController.view.trailingAnchor),
            toolbar.bottomAnchor.constraint(equalTo: pickerViewController.view.bottomAnchor)
        ])
        
        pickerViewController.preferredContentSize = CGSize(width: view.frame.width, height: 216 + toolbar.frame.height)
        pickerView.selectRow(0, inComponent: 0, animated: false)
          
        present(pickerViewController, animated: true, completion: nil)

    }
    
    @objc func donePicker() {
        if let selectedRow = pickerView.selectedRow(inComponent: 0) as? Int {
            if let selectedOption = ControlType.allCases[selectedRow].rawValue as? String {
                controlType = ControlType(rawValue: selectedOption)!
            } else if let selectedOption = Difficulty.allCases[selectedRow].rawValue as? String {
                difficulty = Difficulty(rawValue: selectedOption)!
            }
        }
        dismiss(animated: true, completion: nil)
    }
    
}

extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            print("тип упрв")
            showPicker(withOptions: ControlType.allCases.map { $0.rawValue }, selectedOption: controlType.rawValue)
        } else if indexPath.row == 1 {
            print("сложностьт")
        
            showPicker(withOptions: Difficulty.allCases.map { $0.rawValue }, selectedOption: difficulty.rawValue)
        }
    }
    
    @objc func showControlTypePicker() {
        showPicker(withOptions: ControlType.allCases.map { $0.rawValue }, selectedOption: controlType.rawValue)
            
    }
       
    @objc func showDifficultyPicker() {
        showPicker(withOptions: Difficulty.allCases.map { $0.rawValue }, selectedOption: difficulty.rawValue)
           
    }
    

}

extension SettingsViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerView.tag == 0 ? ControlType.allCases.count : Difficulty.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerView.tag == 0 ? ControlType.allCases[row].rawValue : Difficulty.allCases[row].rawValue
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 0 {
            controlType = ControlType.allCases[row]
        } else {
            difficulty = Difficulty.allCases[row]
        }
    }
}


class SettingsTableViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension SettingsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text {
            nickname = text
            // Сохранить никнейм, если нужно
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


