//
//  NetworkManaging.swift
//  FlickerApp
//
//  Created by Muralidhar reddy Kakanuru on 12/12/24.
//

import UIKit

protocol NetworkManaging {
    func fetchImages(for tags: String) async throws -> [FlickrImage]
    func fetchImage(from url: URL) async throws -> UIImage
}

final class NetworkManager: NetworkManaging {
    static let shared = NetworkManager()
    private let session: URLSession
    private let imageCache = NSCache<NSString, UIImage>()

    private init(session: URLSession = .shared) {
        self.session = session
    }

    func fetchImages(for tags: String) async throws -> [FlickrImage] {
        let encodedTags = tags.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        guard let url = URL(string: "https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1&tags=\(encodedTags)") else {
            throw NetworkError.invalidURL
        }

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
