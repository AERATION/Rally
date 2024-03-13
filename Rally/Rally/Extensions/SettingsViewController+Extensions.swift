
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
        let cell = tableView.dequeueReusableCell(withIdentifier: indexPath.row == 0 ? UR.TableViews.controlTypeCellIdentifier : (indexPath.row == 1 ? UR.TableViews.difficultyCellIdentifier : UR.TableViews.nicknameCellIdentifier), for: indexPath)
        
        switch indexPath.row {
            case 0:
                cell.textLabel?.text = LocalizedStrings.controlTypeLabel
                let controlTypeButton = UIButton(frame: CGRect(x: 0, y: 0, width: UR.TableViews.controlTypeButtonWidth, height: UR.TableViews.controlTypeButtonHeight))
                controlTypeButton.setTitle(settingsModel.getControlType().rawValue, for: .normal)
                controlTypeButton.setTitleColor(.blue, for: .normal)
                controlTypeButton.addTarget(self, action: #selector(showControlTypePicker), for: .touchUpInside)
                cell.accessoryView = controlTypeButton
            case 1:
                cell.textLabel?.text = LocalizedStrings.difficultyLabel
                let difficultyButton = UIButton(frame: CGRect(x: 0, y: 0, width: UR.TableViews.difficultyButtonWidth, height: UR.TableViews.difficultyButtonHeight))
                difficultyButton.setTitle(settingsModel.getDifficultType().rawValue, for: .normal)
                difficultyButton.setTitleColor(.blue, for: .normal)
                difficultyButton.addTarget(self, action: #selector(showDifficultyPicker), for: .touchUpInside)
                cell.accessoryView = difficultyButton
            case 2:
                cell.textLabel?.text = LocalizedStrings.nicknameLabel
                let nicknameField = UITextField(frame: CGRect(x: 0, y: 0, width: UR.TableViews.nickLabelWidth, height: UR.TableViews.nickLabelHeight))
                nicknameField.text = settingsModel.getNickname()
                nicknameField.delegate = self
                cell.accessoryView = nicknameField
            default:
                break
        }
        return cell
    }
    
    func showPicker(withOptions options: [String], selectedOption: String) {
        pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: UR.TableViews.pickerViewHeight))
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
        
        pickerView.snp.makeConstraints { make in
            make.leading.equalTo(pickerViewController.view.snp.leading)
            make.trailing.equalTo(pickerViewController.view.snp.trailing)
            make.top.equalTo(pickerViewController.view.snp.top)
            make.bottom.equalTo(toolbar.snp.top)
        }
        
        toolbar.snp.makeConstraints { make in
            make.leading.equalTo(pickerViewController.view.snp.leading)
            make.trailing.equalTo(pickerViewController.view.snp.trailing)
            make.bottom.equalTo(pickerViewController.view.snp.bottom)
        }

        pickerViewController.preferredContentSize = CGSize(width: view.frame.width, height: toolbar.frame.height)
        present(pickerViewController, animated: true, completion: nil)
    }
    
    @objc func donePicker() {
        let selectedRow = pickerView.selectedRow(inComponent: 0)
        if pickerView.tag == 0 {
            let selectedOption = ControlType.allCases[selectedRow].rawValue
            settingsModel.setControlType(controlType: ControlType(rawValue: selectedOption)!)
        } else {
            let selectedOption = Difficulty.allCases[selectedRow].rawValue
            settingsModel.setDifficultType(difficultType: Difficulty(rawValue: selectedOption)!)
        }
        settingsTableReloadData()
        dismiss(animated: true, completion: nil)
    }
}

//MARK: - TableViewDelegate
extension SettingsViewController: UITableViewDelegate {
    
    @objc func showControlTypePicker() {
        showPicker(withOptions: ControlType.allCases.map { $0.rawValue }, selectedOption: settingsModel.getControlType().rawValue)
        pickerView.selectRow(ControlType.allCases.firstIndex(of: settingsModel.getControlType())!, inComponent: 0, animated: true)
        pickerView.tag = 0
            
    }
       
    @objc func showDifficultyPicker() {
        showPicker(withOptions: Difficulty.allCases.map { $0.rawValue }, selectedOption: settingsModel.getDifficultType().rawValue)
        pickerView.selectRow(Difficulty.allCases.firstIndex(of: settingsModel.getDifficultType())!, inComponent: 0, animated: true)
        print(settingsModel.getDifficultType().rawValue)
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
            settingsModel.setControlType(controlType: ControlType.allCases[row])
        } else {
            settingsModel.setDifficultType(difficultType: Difficulty.allCases[row])
        }
    }
}

//MARK: - TableViewCell
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
            setAvatarImage(image: image)
            let imageName = try? StorageService.shared.saveImage(image)
            settingsModel.setImageId(imageid: imageName!)
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
            settingsModel.setNickname(nickname: text)
        }
    }
}
