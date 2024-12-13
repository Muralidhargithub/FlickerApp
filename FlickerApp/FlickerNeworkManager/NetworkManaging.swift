//
//  NetworkManaging.swift
//  FlickerApp
//
//  Created by Muralidhar reddy Kakanuru on 12/12/24.
//

import UIKit

// MARK: - Protocols
protocol NetworkManaging {
    func fetchData<T: Decodable>(for tags: String, decodingType: T.Type) async throws -> T
    func fetchImage(from url: URL) async throws -> UIImage
}

final class NetworkManager: NetworkManaging {
    static let shared = NetworkManager()
    private let session: URLSession
    private let imageCache = NSCache<NSString, UIImage>()

    private init(session: URLSession = .shared) {
        self.session = session
    }

    // MARK: - Function to fetch Data
    func fetchData<T: Decodable>(for tags: String, decodingType: T.Type) async throws -> T {
        guard let url = APIEndpoints.fetchPhotosURL(tags: tags) else {
            throw NetworkError.invalidURL
        }

        print("Fetching data from URL: \(url)")
        let (data, _) = try await session.data(from: url)

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        do {
            let decodedResponse = try decoder.decode(T.self, from: data)
            print("Successfully decoded response")
            return decodedResponse
        } catch {
            print("Decoding error: \(error)")
            throw NetworkError.decodingError
        }
    }

    // MARK: - Function to fetch Image
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
