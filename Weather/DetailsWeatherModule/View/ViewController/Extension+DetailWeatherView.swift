//
//  Extension+DetailWeatherView.swift
//  Weather
//
//  Created by Дмитрий  on 20.10.2021.
//

import UIKit

extension DetailsWeatherViewController {
    
    final func createCollectionView() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 98).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 20).isActive = true
        
        collectionView.register(DetailWeatherCollectionViewCell.self, forCellWithReuseIdentifier: DetailWeatherCollectionViewCell().id)
        collectionView.dataSource = dataSource
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor(named: "background")
        
        return collectionView
    }
}
