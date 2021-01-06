//
//  CollectionViewCell.swift
//  AbiHome
//
//  Created by Alexandru Luca on 05/01/2021.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupView()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods

    func setupView() {}
    func setupConstraints() {}
}
