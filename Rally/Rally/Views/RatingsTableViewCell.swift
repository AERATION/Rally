
import Foundation
import UIKit

final class RatingsTableViewCell: UITableViewCell {
    
    static var identifier: String { "\(Self.self)"}
    
    private let dataLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    } ()
    
    private let nicknameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    } ()
    
    private let scoreLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    } ()
    
    private let avatarImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "defaultUserAvatar")
        return image
    } ()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(dataLabel)
        contentView.addSubview(nicknameLabel)
        contentView.addSubview(scoreLabel)
        contentView.addSubview(avatarImageView)
        avatarImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.height.equalTo(48)
            make.width.equalTo(48)
        }
        
        nicknameLabel.snp.makeConstraints { make in
            make.leading.equalTo(avatarImageView.snp.trailing).offset(16)
            make.top.equalToSuperview()
            make.height.equalTo(32)
        }
        
        scoreLabel.snp.makeConstraints { make in
            make.leading.equalTo(avatarImageView.snp.trailing).offset(16)
            make.bottom.equalToSuperview()
            make.height.equalTo(32)
        }
        
        dataLabel.snp.makeConstraints { make in
            make.leading.equalTo(scoreLabel.snp.trailing).offset(32)
            make.bottom.equalToSuperview()
            make.height.equalTo(32)
        }
    }
    
    func configure(with model: User) {
        nicknameLabel.text = model.username
//        avatarImageView.image = model.username
        scoreLabel.text = String(model.score)
        let formatter = DateFormatter()
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.image = StorageService.shared.loadImage(by: model.avatarImageKey)
        formatter.dateFormat = "yyyy-MM-dd"
        dataLabel.text = formatter.string(from: model.date)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nicknameLabel.text = nil
        scoreLabel.text = nil
        dataLabel.text = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
