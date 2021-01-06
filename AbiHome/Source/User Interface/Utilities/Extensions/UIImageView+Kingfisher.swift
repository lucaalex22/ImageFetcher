//
//  UIImageView+Kingfisher.swift
//  AbiHome
//
//  Created by Alexandru Luca on 05/01/2021.
//

import Foundation
import Kingfisher

extension UIImageView {

    func setImage(_ URL: URL?, enableDownsampling: Bool = true) {
        var options: KingfisherOptionsInfo = [.transition(.fade(0.3))]

        if enableDownsampling {
            let width = max(frame.size.width, 200)
            let height = max(frame.size.height, 300)
            let size = CGSize(width: width, height: height)
            let downsamplingProcessor = DownsamplingImageProcessor(size: size)
            options.append(contentsOf: [.processor(downsamplingProcessor),
                                        .scaleFactor(UIScreen.main.scale),
                                        .cacheOriginalImage])
        }

        kf.indicatorType = .activity
        kf.setImage(with: URL, options: options)
    }

    func resetImageLoading() {
        kf.cancelDownloadTask()
    }

    static func startPrefetch(forURLs urls: [URL]) {
        ImagePrefetcher(urls: urls).start()
    }
}
