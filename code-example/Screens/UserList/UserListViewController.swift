//
//  ViewController.swift
//  code-example
//
//  Created by Alexy Nesterchuk on 17.07.2024.
//

import UIKit

protocol UserListViewInput: BaseViewInput {
    func fill(items: [User])
}

class UserListViewController: BaseViewController, UserListViewInput {

    override var contentView: BaseView {
        userListView
    }
    
    private lazy var userListView = UserListView()
    
    private let viewModel: UserListViewModelProtocol
    
    init(viewModel: UserListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }
    
}

// MARK: - ViewInput
extension UserListViewController {
    func fill(items: [User]) {
        userListView.fill(with: items)
    }
}

