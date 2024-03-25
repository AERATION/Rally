
import UIKit
import SnapKit

final class StartViewController: UIViewController {
    
    //MARK: - UI elements
    private let startButton: SubmitButton = SubmitButton(titleLabel: LocalizedStrings.startButtonTitle)
    
    private let settingsButton: SubmitButton = SubmitButton(titleLabel: LocalizedStrings.settingsButtonTitle)
    
    private let ratingsButton: SubmitButton = SubmitButton(titleLabel: LocalizedStrings.ratingsButtonTitle)
    
    private let startImageView: StartIconImageView = StartIconImageView(imageName: "StartScreenIcon")
    
    //MARK: - VC methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    //MARK: - Configure UI
    private func configureUI() {
        addTargets()
        view.backgroundColor = .white
        view.addSubview(startImageView)
        view.addSubview(startButton)
        view.addSubview(settingsButton)
        view.addSubview(ratingsButton)
        makeConstraints()
    }
    
    private func addTargets() {
        startButton.addTarget(self, action: #selector(startButtonClick(sender: )), for: .touchDown)
        settingsButton.addTarget(self, action: #selector(settingsButtonClick(sender: )), for: .touchDown)
        ratingsButton.addTarget(self, action: #selector(ratingsButtonClick(sender: )), for: .touchDown)
    }
    
    private func makeConstraints() {
        startImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaInsets.top).offset(UR.Constants.StartScreen.startImageViewTop)
            make.height.equalTo(UR.Constants.StartScreen.startImageViewHeight)
            make.width.equalTo(UR.Constants.StartScreen.startImageViewWidth)
            make.centerX.equalToSuperview()
        }
        
        startButton.snp.makeConstraints { make in
            make.bottom.equalTo(settingsButton.snp.top).offset(UR.Constants.StartScreen.startButtonBottom)
            make.height.equalTo(UR.Constants.StartScreen.startButtonHeight)
            make.leading.equalToSuperview().offset(UR.Constants.StartScreen.startButtonLeading)
            make.trailing.equalToSuperview().inset(UR.Constants.StartScreen.startButtonTrailing)
        }
        
        settingsButton.snp.makeConstraints { make in
            make.height.equalTo(UR.Constants.StartScreen.startButtonHeight)
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(UR.Constants.StartScreen.startButtonLeading)
            make.trailing.equalToSuperview().inset(UR.Constants.StartScreen.startButtonTrailing)
        }
        
        ratingsButton.snp.makeConstraints { make in
            make.top.equalTo(settingsButton.snp.bottom).inset(UR.Constants.StartScreen.startButtonBottom)
            make.height.equalTo(UR.Constants.StartScreen.startButtonHeight)
            make.trailing.equalToSuperview().inset(UR.Constants.StartScreen.startButtonTrailing)
            make.leading.equalToSuperview().offset(UR.Constants.StartScreen.startButtonLeading)
        }
    }
}

//MARK: - Extensions
extension StartViewController {
    
    @objc func startButtonClick(sender: UITextField) { 
        let gameViewController = GameViewController()
        self.navigationController?.pushViewController(gameViewController, animated: true)
    }
    
    @objc func settingsButtonClick(sender: UITextField) {
        let settingsViewController = SettingsViewController()
        self.navigationController?.pushViewController(settingsViewController, animated: true)
    }
    
    @objc func ratingsButtonClick(sender: UITextField) {
        let ratingsViewController = RatingViewController()
        self.navigationController?.pushViewController(ratingsViewController, animated: true)
    }
}
