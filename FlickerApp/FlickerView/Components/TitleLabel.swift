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
        self.textAlignment = .center
        self.translatesAutoresizingMaskIntoConstraints = false
        
        let shadow = NSShadow()
        shadow.shadowColor = UIColor.white
            shadow.shadowBlurRadius = 2
            shadow.shadowOffset = CGSize(width: 2, height: 2)
        
        let attributedText = NSMutableAttributedString(
            string: "Flickr",
            attributes: [
                .font: UIFont(name: "Copperplate", size: 50) ?? UIFont.boldSystemFont(ofSize: 30),
                .foregroundColor: UIColor.white,
                .shadow: shadow
            ]
        )
        self.attributedText = attributedText
    }
}
