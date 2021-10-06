//
//  HoursCollectionViewDataSource.swift
//  Weather-2.1
//
//  Created by Дмитрий  on 23.09.2021.
//

import UIKit

final class NextDaysCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    var weatherByHours = [WeatherByHours]()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        weatherByHours.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HoursCollectionViewCell.id, for: indexPath) as! HoursCollectionViewCell
        
        cell.contentView.backgroundColor = UIColor(named: "secondCell")
        cell.configure()
        cell.setUpData(model: weatherByHours[indexPath.row])
        cell.contentView.layer.cornerRadius = 16
        
        return cell
    }
}
