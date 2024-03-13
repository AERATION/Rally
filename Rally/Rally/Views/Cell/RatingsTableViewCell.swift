
import Foundation
import UIKit

final class RatingsTableViewCell: UITableViewCell {
    
    static var identifier: String { "\(Self.self)"}
    
    //MARK: - UI elements
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
        label.text = LocalizedStrings.scoreLabelText
        return label
    } ()
    
    private let avatarImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "DefaultUserAvatar")
        return image
    } ()
    
    //MARK: - Inits
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.isUserInteractionEnabled = false
        
        contentView.addSubview(dataLabel)
        contentView.addSubview(nicknameLabel)
        contentView.addSubview(scoreLabel)
        contentView.addSubview(avatarImageView)
        
        makeCellConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nicknameLabel.text = nil
        scoreLabel.text = nil
        dataLabel.text = nil
    }
    
    //MARK: - Constraints
    private func makeCellConstraints() {
        avatarImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(UR.TableViews.avatarImageViewCellLeading)
            make.centerY.equalToSuperview()
            make.height.equalTo(UR.TableViews.avatarImageViewCellHeight)
            make.width.equalTo(UR.TableViews.avatarImageViewCellWidth)
        }
        
        nicknameLabel.snp.makeConstraints { make in
            make.leading.equalTo(avatarImageView.snp.trailing).offset(UR.TableViews.nicknameLabelLeading)
            make.top.equalToSuperview()
            make.height.equalTo(UR.TableViews.avatarImageViewCellHeight)
        }
        
        scoreLabel.snp.makeConstraints { make in
            make.leading.equalTo(avatarImageView.snp.trailing).offset(UR.TableViews.scoreLabelLeading)
            make.bottom.equalToSuperview()
            make.height.equalTo(UR.TableViews.scoreLabelHeight)
        }
        
        dataLabel.snp.makeConstraints { make in
            make.leading.equalTo(scoreLabel.snp.trailing).offset(UR.TableViews.dataLabelLeading)
            make.bottom.equalToSuperview()
            make.height.equalTo(UR.TableViews.dataLabelHeight)
        }
    }
    
    //MARK: - Configures
    func configure(with model: User) {
        nicknameLabel.text = model.username
        scoreLabel.text = "\(LocalizedStrings.scoreLabelText)\(String(model.score))"
        avatarImageView.image = StorageService.shared.loadImage(by: model.avatarImageKey)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        dataLabel.text = formatter.string(from: model.date)
    }
}
