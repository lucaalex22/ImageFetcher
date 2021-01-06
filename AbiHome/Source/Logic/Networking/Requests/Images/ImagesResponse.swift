//
//  ImagesResponse.swift
//  AbiHome
//
//  Created by Alexandru Luca on 05/01/2021.
//

import Foundation

struct ImagesResponse: Decodable {
    let images: [ImageURL]

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        images = try container.decode([ImageURL].self)
    }
}
