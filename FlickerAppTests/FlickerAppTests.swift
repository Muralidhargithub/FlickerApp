//
//  FlickerAppTests.swift
//  FlickerAppTests
//
//  Created by Muralidhar reddy Kakanuru on 12/12/24.
//


import XCTest
@testable import FlickerApp

final class FlickerAppTests: XCTestCase {

    private var viewModel: FlickrViewModel!
        
        override func setUp() {
            super.setUp()
        }
        
        override func tearDown() {
            viewModel = nil
            super.tearDown()
        }
        
        func testSearchImagesSuccess() async {
            // Arrange
            let testImages = [
                FlickrImage(title: "Test Image 1", link: nil, media: Media(m: "https://example.com/image1.jpg"), dateTaken: nil, description: nil, published: nil, author: nil, authorID: nil, tags: nil),
                FlickrImage(title: "Test Image 2", link: nil, media: Media(m: "https://example.com/image2.jpg"), dateTaken: nil, description: nil, published: nil, author: nil, authorID: nil, tags: nil)
            ]
            
            viewModel = FlickrViewModel(networkManager: InlineNetworkManager(fetchDataHandler: { _ in
                return testImages
            }))
            
            let expectation = XCTestExpectation(description: "Images updated")
            
            viewModel.updateImages = { images in
                XCTAssertEqual(images.count, 2)
                XCTAssertEqual(images.first?.title, "Test Image 1")
                expectation.fulfill()
            }
            
            // Act
            viewModel.searchImages(for: "nature")
            
            // Assert
            wait(for: [expectation], timeout: 1.0)
        }

}
