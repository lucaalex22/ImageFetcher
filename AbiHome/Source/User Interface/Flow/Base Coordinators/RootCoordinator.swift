//
//  RootCoordinator.swift
//  AbiHome
//
//  Created by Alexandru Luca on 05/01/2021.
//

import UIKit

final class RootCoordinator: Coordinator {

    var rootViewController: UIViewController {
        UIViewController()
    }

    // MARK: - Public Properties

    var childCoordinators: [Coordinator] = []

    // MARK: - Private Properties

    private let window: UIWindow
    private let serviceProvider = ServiceProvider()
    private var tabBarCoordinator: TabBarCoordinator?

    // MARK: - Initializer

    init(window: UIWindow) {
        self.window = window
        registerServices()
    }

    // MARK: - Public Methods

    func start() {
        let tabBarCoordinator = TabBarCoordinator(with: serviceProvider)
        tabBarCoordinator.start()
        childCoordinators.append(tabBarCoordinator)

        window.rootViewController = tabBarCoordinator.rootViewController
        window.makeKeyAndVisible()

        self.tabBarCoordinator = tabBarCoordinator
    }

    // MARK: - Private Methods

    private func registerServices() {
        // MARK: - NetworkService

        serviceProvider.register(NetworkService.self, resolver: NetworkServiceImpl())

        // MARK: - ImagesService

        let networkService = serviceProvider.resolve(NetworkService.self)!
        serviceProvider.register(ImagesService.self, resolver: ImagesServiceImpl(with: networkService))
    }

}
