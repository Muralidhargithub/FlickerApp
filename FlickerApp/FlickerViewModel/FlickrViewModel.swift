//
//  FlickrViewModel.swift
//  FlickerApp
//
//  Created by Muralidhar reddy Kakanuru on 12/12/24.
//


import Foundation

class FlickrViewModel {
    private let networkManager: NetworkManaging
    var isLoading: ((Bool) -> Void)?
    var updateImages: (([FlickrImage]) -> Void)?
    var showError: ((String) -> Void)?

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
                let images = try await networkManager.fetchImages(for: query)
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
