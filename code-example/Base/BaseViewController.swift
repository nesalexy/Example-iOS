//
//  BaseViewController.swift
//  code-example
//
//  Created by Alexy Nesterchuk on 17.07.2024.
//

import Foundation
import UIKit


class BaseViewController: UIViewController {
    
    /// Convenience property for subclasses.
    /// If present it will be used to add view to hierarchy.
    var contentView: BaseView? {
        nil
    }
    
    private lazy var loadingContainer: LoadingView = {
        let loadingView = LoadingView()
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        return loadingView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setupVisual()
    }
    
    private func setupUI() {
        if let contentView = contentView {
            view.addSubview(contentView)
        }
    }
    
    private func setupConstraints() {
        guard let contentView = contentView else { return }
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    private func setupVisual() {
        view.backgroundColor = .white
    }
}

// MARK: - External functionality
extension BaseViewController {
    
    func showLoading() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            guard self.loadingContainer.superview == nil else { return }
            
            if let navigationController = navigationController {
                navigationController.view.addSubview(self.loadingContainer)
                
                NSLayoutConstraint.activate([
                    self.loadingContainer.topAnchor.constraint(equalTo: navigationController.view.topAnchor),
                    self.loadingContainer.leadingAnchor.constraint(equalTo: navigationController.view.leadingAnchor),
                    self.loadingContainer.bottomAnchor.constraint(equalTo: navigationController.view.bottomAnchor),
                    self.loadingContainer.trailingAnchor.constraint(equalTo: navigationController.view.trailingAnchor)
                ])
            } else {
                view.addSubview(self.loadingContainer)
                
                NSLayoutConstraint.activate([
                    self.loadingContainer.topAnchor.constraint(equalTo: view.topAnchor),
                    self.loadingContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                    self.loadingContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                    self.loadingContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor)
                ])
            }
        }
        
    }
    
    func hideLoading() {
        DispatchQueue.main.async { [weak self] in
            self?.loadingContainer.removeFromSuperview()
        }
    }
    
    func showAlert(title: String?, message: String?, actions: [UIAlertAction] = []) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if !actions.isEmpty {
            actions.forEach(alertController.addAction)
        } else {
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alertController.addAction(okAction)
        }
        DispatchQueue.main.async { [weak self] in
            self?.present(alertController, animated: true, completion: nil)
        }
    }
}
