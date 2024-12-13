//
//  NetworkManaging.swift
//  FlickerApp
//
//  Created by Muralidhar reddy Kakanuru on 12/12/24.
//

import UIKit

//MARK: - Protocols
protocol NetworkManaging {
    func fetchData(for tags: String) async throws -> [FlickrImage]
    func fetchImage(from url: URL) async throws -> UIImage
}

final class NetworkManager: NetworkManaging {
    static let shared = NetworkManager()
    private let session: URLSession
    private let imageCache = NSCache<NSString, UIImage>()

    private init(session: URLSession = .shared) {
        self.session = session
    }

    //MARK: - Function to fetch Data
    func fetchData(for tags: String) async throws -> [FlickrImage] {
        guard let url = APIEndpoints.fetchPhotosURL(tags: tags) else {
            throw NetworkError.invalidURL}

        print("Fetching images from URL: \(url)")
        let (data, _) = try await session.data(from: url)

        let decoder = JSONDecoder()
        do {
            let response = try decoder.decode(FlickrResponse.self, from: data)
            print("Fetched \(response.items.count) images from API")
            return response.items
        } catch {
            print("Decoding error: \(error)")
            throw NetworkError.decodingError
        }
    }

    //MARK: - Function to fetch Images
    func fetchImage(from url: URL) async throws -> UIImage {
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            return cachedImage
        }

        let (data, _) = try await session.data(from: url)
        guard let image = UIImage(data: data) else {
            throw NetworkError.noData
        }

        imageCache.setObject(image, forKey: url.absoluteString as NSString)
        return image
    }
}
