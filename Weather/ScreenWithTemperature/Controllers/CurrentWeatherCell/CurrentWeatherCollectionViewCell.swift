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
    
    func confugure() {
        NetworkWeatherManager.networkManager.fetchCurrentWeather() { [weak self] currentWeather in
            
            DispatchQueue.main.async {
                
                switch currentWeather.getDatabyDayAndHour(indexOfDay: 0, indexOfHour: 0)?.weather[0].weatherDescription {
                
                case "дождь", "пасмурно", "небольшой дождь":
                    self?.weatherImage.image = #imageLiteral(resourceName: "Rain")
                case "гроза":
                    self?.weatherImage.image = #imageLiteral(resourceName: "Thunder")
                default:
                    self?.weatherImage.image = #imageLiteral(resourceName: "sun")
                }
                
                self?.weatherDescription.text = currentWeather.getDatabyDayAndHour(indexOfDay: 0, indexOfHour: 0)?.weather[0].weatherDescription
                
                self?.currentTemperatureLabel.text = Int(currentWeather.getDatabyDayAndHour(indexOfDay: 0, indexOfHour: 0)?.main.temp ?? 0).description + "℃"
                
                let day = currentWeather.getDatabyDayAndHour(indexOfDay: 0, indexOfHour: 0)?.dtTxt.split(separator: " ").first?.description.capitalized
                
                let convertedValue = HelperDate.changeDateFormat(dateString: day ?? "", fromFormat: "yyyy-MM-dd", toFormat: "d MMMM, EEE")
                self?.currentDayLabel.text = "Сегодня," + " " + convertedValue
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        currentDayLabel.font = UIFont(name: "Manrope-SemiBold", size: 14)
        currentTemperatureLabel.font = UIFont(name: "Manrope-ExtraBold", size: 48)
        weatherDescription.font = UIFont(name: "Manrope-SemiBold", size: 14)
    }

}
