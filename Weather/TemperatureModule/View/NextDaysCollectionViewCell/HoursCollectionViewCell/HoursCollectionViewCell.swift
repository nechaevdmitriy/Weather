//
//  HoursCollectionViewCell.swift
//  Weather-2.1
//
//  Created by Дмитрий  on 23.09.2021.
//

import UIKit

final class HoursCollectionViewCell: UICollectionViewCell {
    
    static let id = "HoursCollectionViewCell"
    
    var hourLabel = UILabel()
    var weatherImage = UIImageView()
    var temperatureLabel = UILabel()
    
    func configure() {
        setUpUI()
        setUpConstraints()
    }
    
    func setUpData(model: WeatherByHours) {
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
        contentView.addSubview(hourLabel)
        hourLabel.textColor = UIColor(named: "grayText")
        weatherImage.image = #imageLiteral(resourceName: "01d")
        
        contentView.addSubview(weatherImage)
        
        temperatureLabel.text = "temp"
        temperatureLabel.font = UIFont.extraBold(size: 16)
        temperatureLabel.textAlignment = .center
        contentView.addSubview(temperatureLabel)
    }
    
    private func setUpConstraints() {
        offAutoresizingMasks(elements: [hourLabel, weatherImage, temperatureLabel])
        
        NSLayoutConstraint.activate([
            hourLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            hourLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            hourLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            weatherImage.topAnchor.constraint(equalTo: hourLabel.bottomAnchor, constant: 8),
            weatherImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            weatherImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            weatherImage.heightAnchor.constraint(equalTo: weatherImage.widthAnchor, multiplier: 1.0/1.0),
            
            temperatureLabel.topAnchor.constraint(equalTo: weatherImage.bottomAnchor, constant: 8),
            temperatureLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            temperatureLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            temperatureLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
    }
}
