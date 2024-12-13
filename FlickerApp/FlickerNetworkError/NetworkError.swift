//
//  NetworkError.swift
//  FlickerApp
//
//  Created by Muralidhar reddy Kakanuru on 12/12/24.
//


import Foundation

enum NetworkError: Error, LocalizedError {
    case invalidURL
    case decodingError
    case noData
    case networkFailure(String)

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The URL provided was invalid."
        case .decodingError:
            return "Failed to decode the response."
        case .noData:
            return "No data received from the server."
        case .networkFailure(let message):
            return message
        }
    }
}

