
import UIKit

final class StartIconImageView: UIView {

    private var startIconImageView: UIImageView = {
        let view = UIImageView()
        return view
    }()

    init(imageName: String) {
        super.init(frame: .zero)
        self.addSubview(startIconImageView)
        makeConstraints()
        setImage(imageName)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeConstraints() {
        startIconImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setImage(_ image: String){
        startIconImageView.image = UIImage(named: image)
    }
    
}
