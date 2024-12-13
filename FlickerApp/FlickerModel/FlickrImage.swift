//
//  FlickrImage 2.swift
//  FlickerApp
//
//  Created by Muralidhar reddy Kakanuru on 12/12/24.
//


import Foundation

import Foundation

// MARK: - Root Response Model
struct FlickrResponse: Codable {
    let title: String
    let link: String
    let description: String
    let modified: String
    let generator: String
    let items: [FlickrImage]
}

// MARK: - Flickr Image Model
struct FlickrImage: Codable {
    let title: String?
    let link: String?
    let media: Media
    let dateTaken: String?
    let description: String?
    let published: String?
    let author: String?
    let authorID: String?
    let tags: String?

    enum CodingKeys: String, CodingKey {
        case title
        case link
        case media
        case dateTaken = "date_taken"
        case description
        case published
        case author
        case authorID = "author_id"
        case tags
    }

    var imageUrl: String {
        media.m
    }
}

// MARK: - Media Model
struct Media: Codable {
    let m: String
}

extension FlickrImage {
    var formattedDate: String {
        guard let publishedDate = published else { return "Unknown Date" }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        guard let date = dateFormatter.date(from: publishedDate) else { return "Invalid Date" }
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: date)
    }
}
