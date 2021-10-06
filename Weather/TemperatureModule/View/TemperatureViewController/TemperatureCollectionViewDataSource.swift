//
//  TemperatureCollectionViewdelegate.swift
//  Weather-2.1
//
//  Created by Дмитрий  on 23.09.2021.
//

import UIKit

final class TemperatureCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    var days = [Any]()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        days.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CurrentTemperatureCollectionViewCell.id, for: indexPath) as! CurrentTemperatureCollectionViewCell
            cell.view = CurrentTemperatureCellScreen(frame: cell.contentView.bounds)
            guard let firstDay = days[0] as? WeatherOfTheFirstDay else { return cell }
            cell.infoAboutFirstDay = firstDay
            cell.configure()
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NextDayCollectionViewCell.id, for: indexPath) as! NextDayCollectionViewCell
            cell.configure()
            guard let otherDay = days[indexPath.row] as? WeatherOfTheOtherDays else { return cell }
            cell.setUpData(model: otherDay)
            cell.contentView.layer.cornerRadius = 16
            return cell
        }
    }
}
