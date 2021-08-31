//
//  CurrentWeatherCollectionViewCell.swift
//  Weather
//  Created by Дмитрий  on 23.08.2021.

import UIKit

class CurrentWeatherCollectionViewCell: UICollectionViewCell {

    static let collectionCell = CurrentWeatherCollectionViewCell()
    
    @IBOutlet weak var currentDayLabel: UILabel!
    @IBOutlet weak var currentTemperatureLabel: UILabel!
    @IBOutlet weak var weatherDescription: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    
    static let id = "CurrentWeatherCollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "CurrentWeatherCollectionViewCell", bundle: nil)
    }
    
    func confugure(city: String, indexPath: Int) {
        NetworkWeatherManager.networkManager.fetchCurrentWeather(forCity: city, indexPath: indexPath) { [weak self] currentWeather in
//            DispatchQueue.main.async {
//                self?.weatherDescription.text = currentWeather.temperatureDescription
//                self?.currentTemperatureLabel.text = currentWeather.temperatureString
//                self?.currentDayLabel.text = currentWeather.cityName
//            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
