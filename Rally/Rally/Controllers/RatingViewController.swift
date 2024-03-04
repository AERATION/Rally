
import Foundation
import UIKit

class RatingViewController: UIViewController {
    
    private let ratingTableView: UITableView = UITableView()
    
    private var users: [UserProtocol] = [] {
        didSet {
            users.sort {$0.score > $1.score }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        view.addSubview(ratingTableView)
        ratingTableView.dataSource = self
        makeConstraints()
        loadUsers()
    }
    
    private func makeConstraints() {
        ratingTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func loadUsers() {
        let currentDate = Date()
        users.append(User(username: "AERATION", score: 124, date: currentDate, avatarImageKey: "hey"))
        users.append(User(username: "Basylyo", score: 73, date: currentDate, avatarImageKey: "hey"))
    }
}

extension RatingViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        if let reuseCell = tableView.dequeueReusableCell(withIdentifier: UR.TableViews.ratingTableViewCell) {
            cell = reuseCell
        } else {
            cell = UITableViewCell(style: .default, reuseIdentifier: UR.TableViews.ratingTableViewCell)
        }
        configure(cell: &cell, for: indexPath)
        return cell
    }
    
    private func configure(cell: inout UITableViewCell, for indexPath: IndexPath) {
        if #available(iOS 14, *) {
            var configuration = cell.defaultContentConfiguration()
            configuration.text = users[indexPath.row].username
            configuration.secondaryText = String(users[indexPath.row].score)
            cell.contentConfiguration = configuration
        } else {
            cell.textLabel?.text = "Строка \(indexPath.row)"
        }
    }
}
