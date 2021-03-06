//
//  HoursCollectionViewScreen.swift
//  Weather
//
//  Created by Дмитрий  on 08.10.2021.
//

import UIKit

final class HoursCollectionViewScreen: UIView, HoursCollectionViewCellProtocol {
    
    private var hourLabel = UILabel()
    private var weatherImage = UIImageView()
    private var temperatureLabel = UILabel()
    
    func setUpData(model: WeatherByHours) {
        setUpUI()
        setUpConstraints()
        hourLabel.text = model.hour
        weatherImage.image = UIImage(named: model.weatherImage) ?? #imageLiteral(resourceName: "01d")
        temperatureLabel.text = model.temp
    }
    
    private func setUpUI() {
        hourLabel.text = "hour"
        hourLabel.font = UIFont.medium(size: 16)
        hourLabel.textAlignment = .center
        hourLabel.adjustsFontSizeToFitWidth = true
        hourLabel.minimumScaleFactor = 0.5
        
        self.addSubview(hourLabel)
        
        hourLabel.textColor = UIColor(named: "grayText")
        weatherImage.image = #imageLiteral(resourceName: "01d")
        
        self.addSubview(weatherImage)
        
        temperatureLabel.text = "temp"
        temperatureLabel.font = UIFont.extraBold(size: 16)
        temperatureLabel.textAlignment = .center
        temperatureLabel.adjustsFontSizeToFitWidth = true
        temperatureLabel.minimumScaleFactor = 0.5
        
        self.addSubview(temperatureLabel)
    }
    
    private func setUpConstraints() {
        offAutoresizingMasks(elements: [hourLabel, weatherImage, temperatureLabel])
        
        NSLayoutConstraint.activate([
            hourLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
            hourLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            hourLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            weatherImage.topAnchor.constraint(equalTo: hourLabel.bottomAnchor, constant: 8),
            weatherImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            weatherImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            weatherImage.heightAnchor.constraint(equalTo: weatherImage.widthAnchor, multiplier: 1.0/1.0),
            
            temperatureLabel.topAnchor.constraint(equalTo: weatherImage.bottomAnchor, constant: 8),
            temperatureLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            temperatureLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            temperatureLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12)
        ])
    }
}
