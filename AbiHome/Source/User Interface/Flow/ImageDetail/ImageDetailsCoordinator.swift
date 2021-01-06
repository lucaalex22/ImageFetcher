//
//  ImageDetailsCoordinator.swift
//  AbiHome
//
//  Created by Alexandru Luca on 05/01/2021.
//

import UIKit

final class ImageDetailsCoordinator: Coordinator {

    // MARK: - Properties

    var childCoordinators: [Coordinator] = []
    private let text: String

    private lazy var imageDetailViewModel: ImageDetailViewModelImpl = {
        ImageDetailViewModelImpl(text: text)
    }()

    lazy var rootViewController: UIViewController = {
        let imageDetailViewController = ImageDetailViewController(with: imageDetailViewModel)
        imageDetailViewModel.viewUpdater = imageDetailViewController

        return imageDetailViewController
    }()

    // MARK: - Initializer

    init(text: String) {
        self.text = text
    }

    // MARK: - Methods

    func start() {
        // Do nothing, since this will be embedded in a tab bar controller
    }

    func updateImageURL(to newImageURL: URL) {
        imageDetailViewModel.updateImageURL(to: newImageURL)
    }
}

