//
//  DetailViewController.swift
//  FlickerApp
//
//  Created by Muralidhar reddy Kakanuru on 12/12/24.
//


import UIKit

class DetailViewController: UIViewController {
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let authorLabel = UILabel()
    private let dateLabel = UILabel()
    
    private let image: FlickrImage
    
    init(image: FlickrImage) {
        self.image = image
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configure(with: image)
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        // Image View
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        // Title Label
        titleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Description Label
        descriptionLabel.font = UIFont.preferredFont(forTextStyle: .body)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Author Label
        authorLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        authorLabel.textColor = .secondaryLabel
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Date Label
        dateLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
        dateLabel.textColor = .secondaryLabel
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Add Views
        let stackView = UIStackView(arrangedSubviews: [imageView, titleLabel, descriptionLabel, authorLabel, dateLabel])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        
        // Layout Constraints
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            imageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75)
        ])
    }
    
    private func configure(with image: FlickrImage) {
        // Load Image
        if let url = URL(string: image.imageUrl) {
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
        } else {
            imageView.image = UIImage(systemName: "photo")
        }
        
        // Set Texts
        titleLabel.text = image.title?.isEmpty == false ? image.title : "No Title Available"
        descriptionLabel.text = image.description?.isEmpty == false ? image.description : "No Description Available"
        authorLabel.text = "Author: \(image.author?.isEmpty == false ? image.author! : "Unknown")"
        dateLabel.text = "Published: \(image.formattedDate)"
    }
}
