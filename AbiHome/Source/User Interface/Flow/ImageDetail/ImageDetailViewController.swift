//
//  ImageDetailViewController.swift
//  AbiHome
//
//  Created by Alexandru Luca on 05/01/2021.
//

import UIKit

final class ImageDetailViewController: ViewController {

    // MARK: - Properties

    private let viewModel: ImageDetailViewModel

    private let imageView = UIImageView {
        $0.contentMode = .scaleAspectFit
        $0.isHidden = true
    }

    private let placeholderLabel = UILabel {
        $0.textColor = .black
    }

    // MARK: - Initializer

    init(with viewModel: ImageDetailViewModel) {
        self.viewModel = viewModel
        super.init()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setupView() {
        view.backgroundColor = .white
        view.addSubviews([placeholderLabel, imageView])
    }

    override func setupConstraints() {
        NSLayoutConstraint.activate([
            placeholderLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            placeholderLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            placeholderLabel.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: Constants.padding),
            placeholderLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -Constants.padding),

            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2),
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.2),
        ])
    }

    override func setupBindings() {
        placeholderLabel.text = viewModel.text
    }

}

// MARK: - ImageDetailViewUpdater

extension ImageDetailViewController: ImageDetailViewUpdater {

    func updateImage() {
        if let imageURL = viewModel.imageURL {
            placeholderLabel.isHidden = true
            imageView.isHidden = false
            imageView.setImage(imageURL)
        } else {
            placeholderLabel.isHidden = false
            imageView.isHidden = true
        }
    }

}

// MARK: - Constants

extension ImageDetailViewController {

    enum Constants {
        static let padding: CGFloat = 16
    }

}
