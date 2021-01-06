//
//  ImageCellViewModel.swift
//  AbiHome
//
//  Created by Alexandru Luca on 05/01/2021.
//

import Foundation

protocol ImageCellViewModel {
    var imageURL: URL { get }
    var isSelected: Bool { get set }
}

final class ImageCellViewModelImpl: ImageCellViewModel {

    // MARK: - Properties

    var imageURL: URL
    var isSelected: Bool

    // MARK: - Initializer

    init(imageURL: URL, isSelected: Bool) {
        self.imageURL = imageURL
        self.isSelected = isSelected
    }
    
}

extension ImageCellViewModelImpl: Hashable {

    func hash(into hasher: inout Hasher) {
        hasher.combine(imageURL)
        hasher.combine(isSelected)
    }

    static func == (lhs: ImageCellViewModelImpl, rhs: ImageCellViewModelImpl) -> Bool {
        lhs.imageURL == rhs.imageURL && lhs.isSelected == rhs.isSelected
    }

}
