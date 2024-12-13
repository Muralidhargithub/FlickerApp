//
//  CustomCollectionView.swift
//  FlickerApp
//
//  Created by Muralidhar reddy Kakanuru on 12/13/24.
//


import UIKit

class CustomCollectionView: UICollectionView {
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 100)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        

        super.init(frame: .zero, collectionViewLayout: layout)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    private func setupUI() {
//        self.backgroundColor = UIColor.systemGroupedBackground
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
