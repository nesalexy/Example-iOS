//
//  UserListCoordinator.swift
//  code-example
//
//  Created by Alexy Nesterchuk on 17.07.2024.
//

import Foundation
import UIKit

// MARK: Simple navigation
protocol UserListCoordinatorProtocol {
    func launchUserList()
}

final class UserListCoordinator: UserListCoordinatorProtocol {
    
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func launchUserList() {
        // can be changed to Swinject(DI)
        let repository: UserRepositoryProtocol = UserRepository(client: URLSession.shared)
        let viewModel: UserListViewModelProtocol = UserListViewModel(repository: repository)
        
        let viewController = UserListViewController(viewModel: viewModel)
        viewModel.view = viewController
        
        navigationController.pushViewController(viewController, animated: false)
    }
}
