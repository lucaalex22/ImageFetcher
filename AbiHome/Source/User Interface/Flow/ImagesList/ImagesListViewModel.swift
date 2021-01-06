//
//  ImagesListViewModel.swift
//  AbiHome
//
//  Created by Alexandru Luca on 05/01/2021.
//

import UIKit

protocol ImagesListFlowDelegate: AnyObject {
    func didSelectImageWith(url: URL)
    func didEncounterError(_ error: ServiceError)
}

protocol ImagesListViewUpdater: AnyObject {
    func reloadData()
    func showLoading(_ value: Bool)
}

protocol ImagesListViewModel {
    var dataSourceSnapshot: ImagesListViewModelImpl.DataSourceType { get }
    var viewUpdater: ImagesListViewUpdater? { get set }

    func handleViewDidLoad()
    func handlePrefetch(for indexes: [Int])
    func handleSelection(on index: Int)
}

final class ImagesListViewModelImpl: ImagesListViewModel {

    // MARK: - Typealiases

    typealias DataSourceType = NSDiffableDataSourceSnapshot<Section, ImageCellViewModelImpl>

    // MARK: - Properties
    var dataSourceSnapshot: DataSourceType
    weak var viewUpdater: ImagesListViewUpdater?
    weak var flowDelegate: ImagesListFlowDelegate?

    // MARK: - Dependencies

    private let imagesService: ImagesService

    // MARK: - Initializer

    init(imagesService: ImagesService) {
        self.imagesService = imagesService

        dataSourceSnapshot = DataSourceType()
        dataSourceSnapshot.appendSections(Section.allCases)
    }

    // MARK: - Public Methods

    func handleViewDidLoad() {
        fetchImages()
    }

    func handlePrefetch(for indexes: [Int]) {
        var imageURLs: [URL] = []

        for index in indexes {
            let imageURL = dataSourceSnapshot.itemIdentifiers(inSection: .images)[index].imageURL
            imageURLs.append(imageURL)
        }

        if !imageURLs.isEmpty {
            UIImageView.startPrefetch(forURLs: imageURLs)
        }
    }

    func handleSelection(on index: Int) {
        let imageURL = dataSourceSnapshot.itemIdentifiers(inSection: .images)[index].imageURL
        flowDelegate?.didSelectImageWith(url: imageURL)
    }

    // MARK: - Private Methods

    private func fetchImages() {
        viewUpdater?.showLoading(true)
        
        imagesService.getImages { [weak self] result in
            guard let self = self else { return }

            self.viewUpdater?.showLoading(false)
            switch result {
            case .success(let images):
                self.dataSourceSnapshot.appendItems(images.map { ImageCellViewModelImpl(imageURL: $0.url, isSelected: false) })
                self.viewUpdater?.reloadData()
            case .failure(let error):
                self.flowDelegate?.didEncounterError(error)
            }
        }
    }
}

// MARK: - Section

extension ImagesListViewModelImpl {

    enum Section: CaseIterable {
        case images
    }

}
