
import Foundation
import UIKit

class RatingViewController: UIViewController {
    
    //MARK: - Propertioes
    private let ratingTableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.register(RatingsTableViewCell.self, forCellReuseIdentifier: RatingsTableViewCell.identifier)
        tableView.rowHeight = CGFloat(UR.TableViews.ratingTableViewRowHeight)
        return tableView
    } ()
    
    private let notificationLabel: UILabel = {
        let label = UILabel()
        label.text = "Список пуст"
        label.isHidden = true
        return label
    } ()
    
    private var users: [User] = [] {
        didSet {
            users.sort {$0.score > $1.score }
        }
    }
    
    //MARK: - Inits
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        configureUI()
    }
    
    //MARK: - Private functions
    private func configureUI() {
        view.addSubview(ratingTableView)
        view.addSubview(notificationLabel)
        ratingTableView.dataSource = self
        makeConstraints()
        title = LocalizedStrings.ratingsButtonTitle
    }
    
    private func makeConstraints() {
        ratingTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        notificationLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    private func loadData() {
        if let users = StorageService.shared.loadUserRatings() {
            self.users = users
            ratingTableView.reloadData()
            notificationLabel.isHidden = true
        } else {
            notificationLabel.isHidden = false
        }
    }
}

//MARK: - TableViewDataSource
extension RatingViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RatingsTableViewCell.identifier, for: indexPath) as? RatingsTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: users[indexPath.row])
        return cell
    }
}
