//
//  TitleLabel.swift
//  FlickerApp
//
//  Created by Muralidhar reddy Kakanuru on 12/13/24.
//


import UIKit

class TitleLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    private func setupUI() {
        self.text = "Flickr Search"
        self.font = UIFont(name: "AvenirNext-Bold", size: 24)
        self.textColor = .init(white: 4, alpha: 4)
        self.textAlignment = .center
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
