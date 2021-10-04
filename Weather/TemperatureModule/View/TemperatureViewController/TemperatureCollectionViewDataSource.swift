//
//  TemperatureCollectionViewdelegate.swift
//  Weather-2.1
//
//  Created by Дмитрий  on 23.09.2021.
//

import UIKit

final class TemperatureCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    var infoAboutFirstDay = ModelOfTheFirstDay()
    var infoAboutSecondDays = [ModelsOfTheSecondDays]()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard infoAboutFirstDay.currentTemp != "" else { return 0 }
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CurrentTemperatureCollectionViewCell.id, for: indexPath) as! CurrentTemperatureCollectionViewCell
            cell.view = CurrentTemperatureCellScreen(frame: cell.contentView.bounds)
            DispatchQueue.main.async {
                cell.infoAboutFirstDay = self.infoAboutFirstDay
            }
            cell.configure()
            return cell
            
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NextDayCollectionViewCell.id, for: indexPath) as! NextDayCollectionViewCell
            cell.dataSource.indexOfFirstSection = indexPath.row
            cell.configure()
            cell.setUpData(model: infoAboutSecondDays[indexPath.row])
            cell.contentView.layer.cornerRadius = 16
            return cell
        }
    }
}
