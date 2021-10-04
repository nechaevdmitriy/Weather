//
//  TemperatureScreenView.swift
//  Weather-2.1
//
//  Created by Дмитрий  on 28.09.2021.
//

import UIKit

protocol TemperatureScreenViewProtocol: UIView {
    func reloadData()
    func setupDataSource(firstDay: ModelOfTheFirstDay, secondDays: [ModelsOfTheSecondDays])
}

final class TemperatureScreenView: UIView, UICollectionViewDelegate {
    
    private let layout = UICollectionViewFlowLayout()
    var collectionView: UICollectionView!
    let dataSource = TemperatureCollectionViewDataSource()
    
    init() {
        super.init(frame: .zero)
        configureCollectionView()
        setUpConstraints()
    }
    
    private func configureCollectionView() {
        layout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = dataSource
        collectionView.register(CurrentTemperatureCollectionViewCell.self, forCellWithReuseIdentifier: CurrentTemperatureCollectionViewCell.id)
        collectionView.register(NextDayCollectionViewCell.self, forCellWithReuseIdentifier: NextDayCollectionViewCell.id)
        self.addSubview(collectionView)
        collectionView.backgroundColor = UIColor(named: "background")
    }
    
    private func setUpConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
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

extension TemperatureScreenView: TemperatureScreenViewProtocol {
    func setupDataSource(firstDay: ModelOfTheFirstDay, secondDays: [ModelsOfTheSecondDays]) {
        dataSource.infoAboutFirstDay = firstDay
        dataSource.infoAboutSecondDays = secondDays
    }
    
    func reloadData() {
        collectionView.reloadData()
    }
}
