//
//  TemperatureScreenView.swift
//  Weather-2.1
//
//  Created by Дмитрий  on 28.09.2021.
//

import UIKit

protocol TemperatureScreenViewProtocol: UIView {
    var collectionView: UICollectionView! { get }
    var dataSource: TemperatureCollectionViewDataSource { get set }
}

final class TemperatureScreenView: UIView, UICollectionViewDelegate, TemperatureScreenViewProtocol {
    
    private let layout = UICollectionViewFlowLayout()
    var collectionView: UICollectionView!
    var dataSource = TemperatureCollectionViewDataSource()
    
    init() {
        super.init(frame: .zero)
        configureCollectionView()
        setUpConstraints()
    }
    
    private func configureCollectionView() {
        layout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView?.delegate = self
        collectionView?.dataSource = dataSource
        collectionView?.register(CurrentTemperatureCollectionViewCell.self, forCellWithReuseIdentifier: CurrentTemperatureCollectionViewCell.id)
        collectionView.register(NextDayCollectionViewCell.self, forCellWithReuseIdentifier: NextDayCollectionViewCell.id)
        self.addSubview(collectionView ?? UICollectionView())
        collectionView?.backgroundColor = UIColor(named: "background")
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        collectionView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TemperatureScreenView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.row == 0 {
            return CGSize(width: self.bounds.width - 32, height: 280)
        } else {
            return CGSize(width: self.bounds.width - 32, height: 206)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 16, left: 0, bottom: 20, right: 0)
    }
}
