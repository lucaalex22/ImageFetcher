//
//  NSLayoutConstraint+Extensions.swift
//  AbiHome
//
//  Created by Alexandru Luca on 05/01/2021.
//

import UIKit

extension NSLayoutConstraint {

    static func constraints(for view: UIView, filling superView: UIView, with edgeInsets: UIEdgeInsets = .zero) -> [NSLayoutConstraint] {
        return [
            view.topAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.topAnchor, constant: edgeInsets.top),
            view.leadingAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.leadingAnchor, constant: edgeInsets.left),
            view.trailingAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.trailingAnchor, constant: -edgeInsets.right),
            view.bottomAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.bottomAnchor, constant: -edgeInsets.bottom)
        ]
    }
    
}

