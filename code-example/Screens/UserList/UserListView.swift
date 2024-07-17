//
//  UserListView.swift
//  code-example
//
//  Created by Alexy Nesterchuk on 17.07.2024.
//

import Foundation
import UIKit


final class UserListView: BaseView {
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private var items = [User]()
    
    override func setupUI() {
        super.setupUI()
        addSubview(tableView)
        setupTableView()
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}

//MARK: - Setup TableView
extension UserListView {
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(item: UserListCell.self)
    }
}

//MARK: - TableView delegate
extension UserListView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UserListCell = tableView.deque(for: indexPath)
        cell.fill(with: items[indexPath.row])
        return cell
    }
}

//MARK: - Fill
extension UserListView {
    func fill(with items: [User]) {
        self.items = items
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}
