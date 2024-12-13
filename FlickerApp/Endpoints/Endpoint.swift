//
//  Endpoint.swift
//  FlickerApp
//
//  Created by Muralidhar reddy Kakanuru on 12/12/24.
//


import Foundation

struct APIEndpoints {
    static let baseURL = "https://api.flickr.com/services/feeds/photos_public.gne"
    
    static func fetchPhotosURL(tags: String) -> URL? {
        let encodedTags = tags.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = "\(baseURL)?format=json&nojsoncallback=1&tags=\(encodedTags)"
        return URL(string: urlString)
    }
}

