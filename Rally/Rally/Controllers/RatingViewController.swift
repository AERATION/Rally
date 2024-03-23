
import Foundation
import UIKit

class RatingViewController: UIViewController {
    
    //MARK: - Propertioes
    private lazy var ratingTableView: UITableView = UITableView()
    
    private lazy var notificationLabel: UILabel = {
        let label = UILabel()
        label.text = LocalizedStrings.notificationMessage
        label.font = UR.Fonts.textFont
        label.textColor = .gray
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
    
    override func viewDidDisappear(_ animated: Bool) {
        view.gestureRecognizers?.forEach(view.removeGestureRecognizer)
    }
    
    //MARK: - Private functions
    private func configureUI() {
        view.addSubview(ratingTableView)
        view.addSubview(notificationLabel)
        setupTableView()
        makeConstraints()
        title = LocalizedStrings.ratingsButtonTitle
    }
    
    private func setupTableView() {
        ratingTableView.dataSource = self
        ratingTableView.register(RatingsTableViewCell.self, forCellReuseIdentifier: RatingsTableViewCell.identifier)
        ratingTableView.rowHeight = CGFloat(UR.TableViews.ratingTableViewRowHeight)
        ratingTableView.separatorColor = .black
        ratingTableView.layoutMargins = UIEdgeInsets.zero
        ratingTableView.separatorInset = UIEdgeInsets.zero
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
