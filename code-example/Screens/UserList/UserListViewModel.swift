//
//  UserListViewModel.swift
//  code-example
//
//  Created by Alexy Nesterchuk on 17.07.2024.
//

import Foundation
import Combine

protocol UserListViewModelProtocol: BaseViewModel {
    var view: UserListViewInput? { get set }
}


final class UserListViewModel: UserListViewModelProtocol {
    weak var view: UserListViewInput?
    
    private let repository: UserRepositoryProtocol
    private var cancellable = Set<AnyCancellable>()
    
    init(repository: UserRepositoryProtocol) {
        self.repository = repository
    }
    
    // support different approaches for fetching data
    func viewDidLoad() {
        fetchUsersClosureExample()
        // fetchUsersCombineExample()
        // fetchUsersSwiftConcurrencyExample()
    }
}

// MARK: - Examples of different approaches to obtaining data
extension UserListViewModel {
    
    private func fetchUsersClosureExample() {
        view?.showLoading()
       
        repository.fetchUsersClosureExample { [weak self] result in
            switch result {
            case .success(let items):
                self?.view?.fill(items: items)
            case .failure(let error):
                self?.view?.showAlert(message: error.localizedDescription)
            }
            self?.view?.hideLoading()
        }
    }
    
    private func fetchUsersCombineExample() {
        view?.showLoading()
        repository.fetchUsersCombineExample()
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    self?.view?.hideLoading()
                case .failure(let error):
                    self?.view?.showAlert(message: error.localizedDescription)
                }
            } receiveValue: { [weak self] items in
                self?.view?.fill(items: items)
            }
            .store(in: &cancellable)
    }
    
    private func fetchUsersSwiftConcurrencyExample() {
        view?.showLoading()
        Task { [weak self] in
            guard let self = self else { return }
            do {
                let items = try await self.repository.fetchUsersSwiftConcurrencyExample()
                self.view?.fill(items: items)
                self.view?.hideLoading()
            } catch (let error) {
                self.view?.hideLoading()
                self.view?.showAlert(message: error.localizedDescription)
            }
        }
    }
    
}
