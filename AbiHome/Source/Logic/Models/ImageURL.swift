//
//  ImageURL.swift
//  AbiHome
//
//  Created by Alexandru Luca on 05/01/2021.
//

import Foundation

struct ImageURL: Decodable {
    let url: URL

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        url = try container.decode(URL.self)
    }

    init(url: URL) {
        self.url = url
    }
}
