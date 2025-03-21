//  
//  HomeViewController.swift
//  VIPERConcurrency
//
//  Created by Thanh Nguyen Xuan on 20/3/25.
//

import UIKit
import Kingfisher
import Reusable

final class HomeViewController: UIViewController {
    @IBOutlet private var avatarImageView: UIImageView!
    @IBOutlet private var greetingLabel: UILabel!
    @IBOutlet private var tableView: UITableView!
    private let refreshControl = UIRefreshControl()

    var presenter: HomePresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.onViewDidLoad()
        setupViews()
    }

    private func setupViews() {
        tableView.register(cellType: ProductCell.self)
        tableView.dataSource = self
        refreshControl.addTarget(self, action: #selector(reloadProducts), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }

    @objc private func reloadProducts() {
        presenter.fetchProducts()
    }

    @IBAction private func settingsButtonTapped(_ sender: Any) {
        presenter.navigateToSettingsScreen()
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.products.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: ProductCell.self)
        cell.configureCell(with: presenter.products[indexPath.row])
        return cell
    }
}

extension HomeViewController:HomeViewProtocol {
    func updateView(with userDetail: UserDetail) {
        greetingLabel.text = userDetail.greeting
        avatarImageView.kf.setImage(with: URL(string: userDetail.image)!)
    }

    func reloadTableView() {
        refreshControl.endRefreshing()
        tableView.reloadData()
    }

    func showMessage(_ message: String) {
        showAlert(title: "Error", message: message)
    }
}
