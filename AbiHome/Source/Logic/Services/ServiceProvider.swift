//
//  ServiceProvider.swift
//  AbiHome
//
//  Created by Alexandru Luca on 05/01/2021.
//

import Foundation

final class ServiceProvider {

    // MARK: - Private properties

    private var resolvers: [ObjectIdentifier: () -> AnyObject] = [:]
    private var cachedServices = NSCache<AnyObject, AnyObject>()

    // MARK: - Public methods

    func register<T>(_ type: T.Type, resolver: @escaping @autoclosure () -> AnyObject) {
        let id = ObjectIdentifier(type)
        resolvers[id] = resolver
    }

    func resolve<T>(_ type: T.Type) -> T? {
        let id = ObjectIdentifier(type)
        if let service = cachedServices.object(forKey: id as AnyObject) as? T {
            return service
        } else if let resolver = resolvers[id], let service = resolver() as? T {
            cachedServices.setObject(service as AnyObject, forKey: id as AnyObject)
            return service
        }

        return nil
    }

}
