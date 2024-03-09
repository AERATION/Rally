
import UIKit
import SnapKit

final class StartViewController: UIViewController {
    
    //MARK: - UI elements
    private let startButton: SubmitButton = SubmitButton(titleLabel: "Start")
    
    private let settingsButton: SubmitButton = SubmitButton(titleLabel: "Settings")
    
    private let ratingsButton: SubmitButton = SubmitButton(titleLabel: "Ratings")
    
    private let startScreenImageView: StartIconImageView = StartIconImageView(imageName: "StartScreenIcon")
    
    //MARK: - VC methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    //MARK: - Configure UI
    private func configureUI() {
        addTargets()
        view.backgroundColor = .white
        view.addSubview(startScreenImageView)
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
        startScreenImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaInsets.top).offset(64)
            make.height.equalTo(256)
            make.width.equalTo(256)
            make.centerX.equalToSuperview()
        }
        
        startButton.snp.makeConstraints { make in
            make.bottom.equalTo(settingsButton.snp.top).offset(-16)
            make.height.equalTo(UR.Constants.startButtonsHeight)
            make.left.equalToSuperview().offset(UR.Constants.leftAnchors)
            make.right.equalToSuperview().inset(UR.Constants.rightAnchors)
        }
        
        settingsButton.snp.makeConstraints { make in
            make.height.equalTo(UR.Constants.startButtonsHeight)
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(UR.Constants.leftAnchors)
            make.right.equalToSuperview().inset(UR.Constants.rightAnchors)
        }
        
        ratingsButton.snp.makeConstraints { make in
            make.top.equalTo(settingsButton.snp.bottom).offset(UR.Constants.leftAnchors)
            make.height.equalTo(UR.Constants.startButtonsHeight)
            make.left.equalToSuperview().offset(UR.Constants.leftAnchors)
            make.right.equalToSuperview().inset(UR.Constants.rightAnchors)
        }
    }
}

//MARK: - Extensions
extension StartViewController {
    
    @objc func startButtonClick(sender: UITextField) {
        let gameView = GameViewController()
        self.navigationController?.pushViewController(gameView, animated: true)
    }
    
    @objc func settingsButtonClick(sender: UITextField) {
        let settingsView = SettingsViewController()
        self.navigationController?.pushViewController(settingsView, animated: true)
    }
    
    @objc func ratingsButtonClick(sender: UITextField) {
        let ratingsView = RatingViewController()
        self.navigationController?.pushViewController(ratingsView, animated: true)
    }
}
