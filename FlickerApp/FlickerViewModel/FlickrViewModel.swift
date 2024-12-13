//
//  FlickrViewModel.swift
//  FlickerApp
//
//  Created by Muralidhar reddy Kakanuru on 12/12/24.
//


import Foundation

class FlickrViewModel {
    private let networkManager: NetworkManaging
    var isLoading: ((Bool) -> ())?
    var updateImages: (([FlickrImage]) -> ())?
    var showError: ((String) -> ())?

    init(networkManager: NetworkManaging = NetworkManager.shared) {
        self.networkManager = networkManager
    }

    func searchImages(for query: String) {
        guard !query.isEmpty else {
            print("Search query is empty")
            return
        }

        isLoading?(true)
        Task {
            do {
                print("Searching for: \(query)")
                let response = try await networkManager.fetchData(for: query, decodingType: FlickrResponse.self)
                let images = response.items
                print("Fetched \(images.count) images for query: \(query)")
                isLoading?(false)
                updateImages?(images)
            } catch {
                isLoading?(false)
                print("Error fetching images: \(error)")
                showError?(error.localizedDescription)
            }
        }
    }
    func loadDefaultPhotos() {
            searchImages(for: "nature")
        }

}
