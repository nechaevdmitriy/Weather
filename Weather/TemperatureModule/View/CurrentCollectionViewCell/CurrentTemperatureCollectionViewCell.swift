//
//  CurrentTemperatureCollectionViewCell.swift
//  Weather-2.1
//
//  Created by Дмитрий  on 22.09.2021.
//

import UIKit

final class CurrentTemperatureCollectionViewCell: UICollectionViewCell {
    
    static let id = "CurrentTemperatureCollectionViewCell"
    
    var currentDateLabel = UILabel()
    var weatherImage = UIImageView()
    var currentTemperatureLabel = UILabel()
    var currentWeatherDescription = UILabel()
    var backgroundImage = UIImageView()
    
    func configure() {
        addSubviews()
        setUpConstraints()
        configureLabels()
        setUpImages()
    }
    
    private func setUpConstraints() {
        offAutoresizingMasks(elements: [currentDateLabel, weatherImage, currentTemperatureLabel, currentWeatherDescription, backgroundImage])
        
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            currentDateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            currentDateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            currentDateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            weatherImage.topAnchor.constraint(equalTo: currentDateLabel.bottomAnchor, constant: 12),
            weatherImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            weatherImage.widthAnchor.constraint(equalToConstant: 100),
            weatherImage.heightAnchor.constraint(equalToConstant: 100),
            
            currentTemperatureLabel.topAnchor.constraint(equalTo: weatherImage.bottomAnchor, constant: 6),
            currentTemperatureLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            currentTemperatureLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            currentWeatherDescription.topAnchor.constraint(equalTo: currentTemperatureLabel.bottomAnchor, constant: 2),
            currentWeatherDescription.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            currentWeatherDescription.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }
    
    private func addSubviews() {
        contentView.addSubview(backgroundImage)
        contentView.addSubview(currentDateLabel)
        contentView.addSubview(weatherImage)
        contentView.addSubview(currentTemperatureLabel)
        contentView.addSubview(currentWeatherDescription)
    }
    
    private func configureLabels() {
        currentDateLabel.text = "date"
        currentDateLabel.textAlignment = .center
        currentDateLabel.font = UIFont.semiBold(size: 14)
        currentDateLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        currentWeatherDescription.text = "description"
        currentWeatherDescription.textAlignment = .center
        currentWeatherDescription.font = UIFont.semiBold(size: 14)
        currentWeatherDescription.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        currentTemperatureLabel.text = "temp"
        currentTemperatureLabel.textAlignment = .center
        currentTemperatureLabel.font = UIFont.extraBold(size: 48)
        currentTemperatureLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
    
    private func setUpImages() {
        backgroundImage.image = #imageLiteral(resourceName: "Group 33510")
        weatherImage.image = #imageLiteral(resourceName: "Sun")
    }
}
