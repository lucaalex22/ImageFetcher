//
//  ImagesListCoordinator.swift
//  AbiHome
//
//  Created by Alexandru Luca on 05/01/2021.
//

import UIKit

protocol ImagesListCoordinatorDelegate: AnyObject {
    func didSelectImage(with url: URL)
}

final class ImagesListCoordinator: Coordinator {

    // MARK: - Properties

    weak var delegate: ImagesListCoordinatorDelegate?
    var childCoordinators: [Coordinator] = []
    private let serviceProvider: ServiceProvider

    lazy var rootViewController: UIViewController = {
        let imagesService = serviceProvider.resolve(ImagesService.self)!
        let imagesListViewModel = ImagesListViewModelImpl(imagesService: imagesService)
        let imagesListViewController = ImagesListViewController(with: imagesListViewModel)
        imagesListViewModel.viewUpdater = imagesListViewController
        imagesListViewModel.flowDelegate = self

        return imagesListViewController
    }()

    // MARK: - Initializer

    init(serviceProvider: ServiceProvider) {
        self.serviceProvider = serviceProvider
    }

    func start() {
        // Do nothing, since this will be embedded in a tab bar controller
    }
}

// MARK: - ImagesListFlowDelegate

extension ImagesListCoordinator: ImagesListFlowDelegate {
    func didSelectImageWith(url: URL) {
        delegate?.didSelectImage(with: url)
    }

    func didEncounterError(_ error: ServiceError) {
        let alert = UIAlertController(title: "Oops", message: error.message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        rootViewController.present(alert, animated: true)
    }
}
