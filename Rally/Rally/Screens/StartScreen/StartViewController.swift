
import UIKit
import SnapKit

class StartViewController: UIViewController {

    
    private let startButton: SubmitButton = SubmitButton(titleLabel: "Start")
    
    private let settingsButton: SubmitButton = SubmitButton(titleLabel: "Settings")
    
    private let ratingsButton: SubmitButton = SubmitButton(titleLabel: "Ratings")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    private func configureUI() {
        startButton.addTarget(self, action: #selector(startButtonClick(sender: )), for: .touchDown)
        settingsButton.addTarget(self, action: #selector(settingsButtonClick(sender: )), for: .touchDown)
        ratingsButton.addTarget(self, action: #selector(ratingsButtonClick(sender: )), for: .touchDown)
        view.backgroundColor = .white
        view.addSubview(startButton)
        view.addSubview(settingsButton)
        view.addSubview(ratingsButton)
        makeConstraints()
    }
    
    private func makeConstraints() {
        startButton.snp.makeConstraints { make in
            make.bottom.equalTo(settingsButton.snp.top).offset(-16)
            make.height.equalTo(42)
            make.left.equalToSuperview().offset(UR.Constants.leftAnchors)
            make.right.equalToSuperview().inset(UR.Constants.rightAnchors)
        }
        
        settingsButton.snp.makeConstraints { make in
            make.height.equalTo(42)
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(UR.Constants.leftAnchors)
            make.right.equalToSuperview().inset(UR.Constants.rightAnchors)
        }
        
        ratingsButton.snp.makeConstraints { make in
            make.top.equalTo(settingsButton.snp.bottom).offset(UR.Constants.leftAnchors)
            make.height.equalTo(42)
            make.left.equalToSuperview().offset(UR.Constants.leftAnchors)
            make.right.equalToSuperview().inset(UR.Constants.rightAnchors)
        }
    }
}

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
