import UIKit
import Foundation

final class SubmitButton: UIButton {
    
    //MARK: - Initializations
    init(titleLabel: String) {
        super.init(frame: .zero)
        setupButton(titleLabel: titleLabel)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private methods
    private func setupButton(titleLabel: String) {
        setTitle(titleLabel, for: .normal)
        setTitleColor(.white, for: .normal)
        self.titleLabel?.font = UR.Fonts.buttonFont
        backgroundColor = .blue
        layer.cornerRadius = 10
    }
}
