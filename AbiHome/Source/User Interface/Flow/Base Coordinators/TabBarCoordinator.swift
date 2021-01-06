//
//  TabBarCoordinator.swift
//  AbiHome
//
//  Created by Alexandru Luca on 05/01/2021.
//

import UIKit

class TabBarCoordinator: Coordinator {
    // MARK: - Properties

    var childCoordinators: [Coordinator] = []

    var rootViewController: UIViewController {
        tabBarController
    }

    private let tabBarController = UITabBarController()
    private let serviceProvider: ServiceProvider

    private var currentImageDetailsCoordinator: ImageDetailsCoordinator?
    private var previousImageDetailsCoordinator: ImageDetailsCoordinator?

    private var currentlySelectedImageURL: URL?

    // MARK: - Initializer

    init(with serviceProvider: ServiceProvider) {
        self.serviceProvider = serviceProvider
    }

    // MARK: - Methods
    
    func start() {
        // ImagesListCoordinator
        let imagesListCoordinator = ImagesListCoordinator(serviceProvider: serviceProvider)
        imagesListCoordinator.delegate = self
        imagesListCoordinator.rootViewController.tabBarItem = UITabBarItem(title: "Images", image: nil, selectedImage: nil)
        imagesListCoordinator.start()

        // ImageDetailsCoordinator - Currently selected image
        let currentImageDetailsCoordinator = ImageDetailsCoordinator(text: "No currently selected image")
        currentImageDetailsCoordinator.rootViewController.tabBarItem = UITabBarItem(title: "Current", image: nil, selectedImage: nil)
        currentImageDetailsCoordinator.start()
        self.currentImageDetailsCoordinator = currentImageDetailsCoordinator

        // ImageDetailsCoordinator - Previously selected image
        let previousImageDetailsCoordinator = ImageDetailsCoordinator(text: "No previously selected image")
        previousImageDetailsCoordinator.rootViewController.tabBarItem = UITabBarItem(title: "Previous", image: nil, selectedImage: nil)
        previousImageDetailsCoordinator.start()
        self.previousImageDetailsCoordinator = previousImageDetailsCoordinator

        let tabBarChildrenCoordinators: [Coordinator] = [imagesListCoordinator, currentImageDetailsCoordinator, previousImageDetailsCoordinator]
        childCoordinators = tabBarChildrenCoordinators

        let rootViewControllers = tabBarChildrenCoordinators.map { $0.rootViewController }
        tabBarController.setViewControllers(rootViewControllers, animated: false)
    }

}

extension TabBarCoordinator: ImagesListCoordinatorDelegate {

    func didSelectImage(with url: URL) {
        guard currentlySelectedImageURL != url else { return }

        if let currentlySelectedImageURL = currentlySelectedImageURL {
            previousImageDetailsCoordinator?.updateImageURL(to: currentlySelectedImageURL)
        }

        currentImageDetailsCoordinator?.updateImageURL(to: url)
        currentlySelectedImageURL = url
    }

}
