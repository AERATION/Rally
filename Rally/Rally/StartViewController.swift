
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
        view.backgroundColor = .white
        view.addSubview(startButton)
        view.addSubview(settingsButton)
        view.addSubview(ratingsButton)
        makeConstraints()
    }
    
    private func makeConstraints() {
        
        startButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(70)
            make.height.equalTo(42)
            make.left.equalToSuperview().offset(UR.Constants.leftAnchors)
            make.right.equalToSuperview().inset(UR.Constants.rightAnchors)
        }
        
        
        settingsButton.snp.makeConstraints { make in
            make.top.equalTo(startButton.snp.bottom).offset(UR.Constants.leftAnchors)
            make.height.equalTo(42)
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

