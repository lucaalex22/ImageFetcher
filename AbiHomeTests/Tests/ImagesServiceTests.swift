//
//  ImagesServiceTests.swift
//  AbiHomeTests
//
//  Created by Alexandru Luca on 06/01/2021.
//

import XCTest
@testable import AbiHome

final class ImagesServiceTests: XCTestCase {

    private var networkService = MockNetworkService()
    private lazy var imagesService: ImagesService = ImagesServiceImpl(with: networkService)

    private var successfulData = "[\"https://google.com\",\"https://apple.com\"]".data(using: .utf8)!
    private var corruptedData = "{\"key\": \"value\"}".data(using: .utf8)!

    func testGetImageSuccess() {
        networkService.strategy = .success(successfulData)

        imagesService.getImages { result in
            let imageURLs = try! result.get()
            XCTAssertEqual(imageURLs.count, 2)
        }
    }

    func testGetImageCorruptedData() {
        networkService.strategy = .success(corruptedData)

        imagesService.getImages { result in
            let imageURLs = try? result.get()
            XCTAssertNil(imageURLs)
        }
    }

    func testErrorIsReturnedOnNetworkRequestFail() {
        networkService.strategy = .failure(.generalError)

        imagesService.getImages { result in
            switch result {
            case .success: XCTFail("Strategy is failure. This should NOT be success")
            case .failure(let error):
                XCTAssertEqual(error, .requestFailed)
            }
        }
    }
}
