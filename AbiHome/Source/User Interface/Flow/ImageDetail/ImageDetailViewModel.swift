//
//  ImageDetailViewModel.swift
//  AbiHome
//
//  Created by Alexandru Luca on 05/01/2021.
//

import UIKit

protocol ImageDetailViewUpdater: AnyObject {
    func updateImage()
}

protocol ImageDetailViewModel {
    var imageURL: URL? { get }
    var text: String { get }
    var viewUpdater: ImageDetailViewUpdater? { get set }
}

final class ImageDetailViewModelImpl: ImageDetailViewModel {

    // MARK: - Properties

    let text: String
    var imageURL: URL?
    weak var viewUpdater: ImageDetailViewUpdater?

    // MARK: - Initializer

    init(text: String) {
        self.text = text
    }

    // MARK: - Methods

    func updateImageURL(to newImageURL: URL) {
        imageURL = newImageURL
        viewUpdater?.updateImage()
    }
}
