//
//  Reusable.swift
//  AbiHome
//
//  Created by Alexandru Luca on 05/01/2021.
//

import UIKit

protocol Reusable {
    static var reuseIdentifier: String { get }
}

extension Reusable {
    static var reuseIdentifier: String { return String(describing: self) }
}

extension UICollectionReusableView: Reusable { }

extension UICollectionView {

    func register<T: UICollectionViewCell>(_ cellClass: T.Type?) {
        register(cellClass, forCellWithReuseIdentifier: T.reuseIdentifier)
    }

    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T? {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            assertionFailure("Failed to dequeue cell with identifier: \(T.reuseIdentifier)")
            return nil
        }

        return cell
    }

}
