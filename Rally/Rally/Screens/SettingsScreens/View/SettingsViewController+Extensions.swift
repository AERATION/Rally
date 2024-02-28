
import Foundation
import UIKit

//MARK: - TableViewDataSource
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
                let controlTypeButton = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
                controlTypeButton.setTitle(controlType.rawValue, for: .normal)
                controlTypeButton.setTitleColor(.blue, for: .normal)
                controlTypeButton.addTarget(self, action: #selector(showControlTypePicker), for: .touchUpInside)
                cell.accessoryView = controlTypeButton
            case 1:
                cell.textLabel?.text = "Сложность"
                let difficultyButton = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
                difficultyButton.setTitle(difficulty.rawValue, for: .normal)
                difficultyButton.setTitleColor(.blue, for: .normal)
                difficultyButton.addTarget(self, action: #selector(showDifficultyPicker), for: .touchUpInside)
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
        
        pickerViewController.preferredContentSize = CGSize(width: view.frame.width, height: /*216 +*/ toolbar.frame.height)
        pickerView.selectRow(0, inComponent: 0, animated: false)
        
        present(pickerViewController, animated: true, completion: nil)
    }
    
    @objc func donePicker() {
        let selectedRow = pickerView.selectedRow(inComponent: 0)
        if pickerView.tag == 0 {
            let selectedOption = ControlType.allCases[selectedRow].rawValue
            controlType = ControlType(rawValue: selectedOption)!
        } else {
            let selectedOption = Difficulty.allCases[selectedRow].rawValue
            difficulty = Difficulty(rawValue: selectedOption)!
        }
        settingsTableView.reloadData()
        dismiss(animated: true, completion: nil)
    }
}

//MARK: - TableViewDelegate
extension SettingsViewController: UITableViewDelegate {
    
    @objc func showControlTypePicker() {
        showPicker(withOptions: ControlType.allCases.map { $0.rawValue }, selectedOption: controlType.rawValue)
        pickerView.tag = 0
            
    }
       
    @objc func showDifficultyPicker() {
        showPicker(withOptions: Difficulty.allCases.map { $0.rawValue }, selectedOption: difficulty.rawValue)
        pickerView.tag = 1
           
    }
}

// MARK: - PickerViewDelegate, PickerViewDataSource
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


//MARK: - ImagePickerControllerDelegate
extension SettingsViewController: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            avatarImageView.image = image
            let avatarImageKey = "avatarImage" as NSString
            cache.setObject(image, forKey: avatarImageKey)
            print(image)
        }
        dismiss(animated: true, completion: nil)
    }
}

//MARK: - TextFieldDelegate
extension SettingsViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text {
            nickname = text

        }
    }
}
