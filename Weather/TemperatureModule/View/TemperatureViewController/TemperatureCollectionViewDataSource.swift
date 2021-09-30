//
//  TemperatureCollectionViewdelegate.swift
//  Weather-2.1
//
//  Created by Дмитрий  on 23.09.2021.
//

import UIKit

final class TemperatureCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    var weatherOfTheDays: [[WeatherList]]?
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        weatherOfTheDays?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CurrentTemperatureCollectionViewCell.id, for: indexPath) as! CurrentTemperatureCollectionViewCell
            
            DispatchQueue.main.async {
                cell.currentDateLabel.text = self.weatherOfTheDays?[indexPath.row][indexPath.row].dtTxt
                cell.currentWeatherDescription.text = self.weatherOfTheDays?[indexPath.row][indexPath.row].weather[0].weatherDescription
                cell.currentTemperatureLabel.text = self.self.weatherOfTheDays?[indexPath.row][indexPath.row].main.temp.description
                cell.weatherImage.image = self.getImage(indexOfDay: 0, indexOfHour: 0)
            }
            
            cell.configure()
            return cell
            
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NextDayCollectionViewCell.id, for: indexPath) as! NextDayCollectionViewCell
            cell.dataSource.indexOfFirstSection = indexPath.row
            cell.dataSource.weatherOfTheDays = weatherOfTheDays
            
            DispatchQueue.main.async {
                cell.weatherImage.image = self.getImage(indexOfDay: indexPath.row, indexOfHour: 3)
                cell.dateLabel.text = self.weatherOfTheDays?[indexPath.row][0].dtTxt.split(separator: " ").first?.description
                cell.temperatureLabel.text = self.weatherOfTheDays?[indexPath.row][0].main.temp.description
                cell.feelsLikeLabel.text = self.weatherOfTheDays?[indexPath.row][0].main.feelsLike.description
            }
            
            cell.configure()
            cell.contentView.layer.cornerRadius = 16
            return cell
        }
    }
    
    private func getImage(indexOfDay: Int, indexOfHour: Int) -> UIImage {
        let a = weatherOfTheDays?[indexOfDay][indexOfHour].weather[0].icon
        switch a {
        case "09d", "09n", "10d", "10n":
            return #imageLiteral(resourceName: "Rain")
        case "11n", "11d":
            return #imageLiteral(resourceName: "Thunder")
        default:
            return #imageLiteral(resourceName: "Sun")
        }
    }
}
