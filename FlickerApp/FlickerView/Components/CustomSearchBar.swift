//
//  CustomSearchBar.swift
//  FlickerApp
//
//  Created by Muralidhar reddy Kakanuru on 12/13/24.
//


import UIKit

class CustomSearchBar: UISearchBar {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    private func setupUI() {
        self.placeholder = "Search Flicks.."
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
