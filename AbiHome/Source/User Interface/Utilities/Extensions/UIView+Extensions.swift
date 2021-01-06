//
//  UIView+Extensions.swift
//  AbiHome
//
//  Created by Alexandru Luca on 05/01/2021.
//

import UIKit

extension UIView {

    func addSubviews(_ views: [UIView]) {
        views.forEach { addSubview($0) }
    }
}
