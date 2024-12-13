//
//  InlineNetworkManager.swift
//  FlickerApp
//
//  Created by Muralidhar reddy Kakanuru on 12/13/24.
//


import UIKit
@testable import FlickerApp

final class InlineNetworkManager: NetworkManaging {
    private let fetchDataHandler: (String) async throws -> [FlickrImage]
    private let fetchImageHandler: (URL) async throws -> UIImage

    init(fetchDataHandler: @escaping (String) async throws -> [FlickrImage],
         fetchImageHandler: @escaping (URL) async throws -> UIImage = { _ in UIImage() }) {
        self.fetchDataHandler = fetchDataHandler
        self.fetchImageHandler = fetchImageHandler
    }

    func fetchData(for tags: String) async throws -> [FlickrImage] {
        return try await fetchDataHandler(tags)
    }

    func fetchImage(from url: URL) async throws -> UIImage {
        return try await fetchImageHandler(url)
    }
}
