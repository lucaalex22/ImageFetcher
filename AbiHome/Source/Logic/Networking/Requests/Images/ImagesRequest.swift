//
//  ImagesRequest.swift
//  AbiHome
//
//  Created by Alexandru Luca on 05/01/2021.
//

import Foundation

struct ImagesRequest: Request {
    typealias Response = ImagesResponse
    let path = API.Path.images
}
