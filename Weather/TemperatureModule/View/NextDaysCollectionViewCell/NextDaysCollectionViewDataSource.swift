//
//  HoursCollectionViewDataSource.swift
//  Weather-2.1
//
//  Created by Дмитрий  on 23.09.2021.
//

import UIKit

final class NextDaysCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    var weatherOfTheDays = [[WeatherList]]()
    var indexOfFirstSection: Int!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HoursCollectionViewCell.id, for: indexPath) as! HoursCollectionViewCell
        
        cell.contentView.backgroundColor = UIColor(named: "secondCell")
        cell.configure()
        cell.contentView.layer.cornerRadius = 16
        return cell
    }
    
    private func getImage(indexOfDay: Int, indexOfHour: Int) -> UIImage {
        let icon = self.weatherOfTheDays[indexOfDay][indexOfHour].weather[0].icon
        switch icon {
        case "09d", "09n", "10d", "10n":
            return #imageLiteral(resourceName: "Rain")
        case "11n", "11d":
            return #imageLiteral(resourceName: "Thunder")
        default:
            return #imageLiteral(resourceName: "Sun")
        }
    }
}
