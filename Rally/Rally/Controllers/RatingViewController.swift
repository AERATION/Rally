
import Foundation
import UIKit

class RatingViewController: UIViewController {
    
    private let ratingTableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.register(RatingsTableViewCell.self, forCellReuseIdentifier: RatingsTableViewCell.identifier)
        tableView.layer.cornerRadius = 15
        tableView.rowHeight = CGFloat(64)
        return tableView
    } ()
    
    private var users: [User] = [] {
        didSet {
            users.sort {$0.score > $1.score }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let users = StorageService.shared.loadUserRatings() {
            self.users = users
            ratingTableView.reloadData()
        } else {
            
        }
        configureUI()
    }
    
    private func configureUI() {
        view.addSubview(ratingTableView)
        ratingTableView.dataSource = self
        makeConstraints()
        title = "Рейтинг"
    }
    
    private func makeConstraints() {
        ratingTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

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
