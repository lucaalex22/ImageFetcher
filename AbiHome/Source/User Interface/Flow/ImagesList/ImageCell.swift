//
//  ImageCell.swift
//  AbiHome
//
//  Created by Alexandru Luca on 05/01/2021.
//

import UIKit

final class ImageCell: CollectionViewCell {

    // MARK: - Public Properties
    var viewModel: ImageCellViewModel? {
        didSet {
            imageView.setImage(viewModel?.imageURL)
        }
    }

    // MARK: - Private Properties

    private let imageView = UIImageView {
        $0.contentMode = .scaleAspectFit
    }

    private let overlayView = UIView {
        $0.backgroundColor = .black
        $0.alpha = 0.2
        $0.isHidden = true
    }

    override func setupView() {
        contentView.addSubviews([imageView, overlayView])
    }

    override func setupConstraints() {
        NSLayoutConstraint.activate(
            NSLayoutConstraint.constraints(for: imageView, filling: contentView) +
            NSLayoutConstraint.constraints(for: overlayView, filling: contentView)
        )
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        imageView.resetImageLoading()
        overlayView.isHidden = true
    }

    override var isSelected: Bool {
        didSet {
            overlayView.isHidden = !isSelected
            viewModel?.isSelected = isSelected
        }
    }

}
