//
//  Configurable.swift
//  AbiHome
//
//  Created by Alexandru Luca on 05/01/2021.
//

import UIKit

public protocol Configurable {}

public extension Configurable where Self: Any {

    func configured(_ configure: ((Self) -> Void)? = nil) -> Self {
        configure?(self)
        return self
    }

}

public extension Configurable where Self: UIView {

    func configured(_ configure: ((Self) -> Void)? = nil) -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        configure?(self)
        return self
    }

    init(_ configure: @escaping ((Self) -> Void)) {
        self.init()
        _ = configured(configure)
    }

}

extension NSObject: Configurable {}
