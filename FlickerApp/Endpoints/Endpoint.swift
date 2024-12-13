//
//  Endpoint.swift
//  FlickerApp
//
//  Created by Muralidhar reddy Kakanuru on 12/12/24.
//


import Foundation

enum Endpoint {
    case searchImages(tags: String)

    var url: URL? {
        switch self {
        case .searchImages(let tags):
            let encodedTags = tags.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            return URL(string: "\(Constants.API.baseURL)?format=json&nojsoncallback=1&tags=\(encodedTags)")
        }
    }
}

enum Constants {
    enum API {
        static let baseURL = "https://api.flickr.com/services/feeds/photos_public.gne"
    }
}
