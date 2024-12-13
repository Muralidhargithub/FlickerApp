//
//  ImageCell.swift
//  FlickerApp
//
//  Created by Muralidhar reddy Kakanuru on 12/12/24.
//


import UIKit

class ImageCell: UICollectionViewCell {
    static let identifier = "ImageCell"
    private let imageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(){
        contentView.addSubview(imageView)
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    func configure(with image: FlickrImage) {
        guard let url = URL(string: image.imageUrl) else {
            print("Invalid image URL: \(image.imageUrl)")
            imageView.image = UIImage(systemName: "photo")
            return
        }
        print("Fetching image from URL: \(url)")
        Task {
            do {
                let fetchedImage = try await NetworkManager.shared.fetchImage(from: url)
                DispatchQueue.main.async {
                    self.imageView.image = fetchedImage
                }
            } catch {
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(systemName: "photo")
                }
            }
        }
    }

}
