//
//  CurrentTemperatureCellScreen.swift
//  Weather
//
//  Created by Дмитрий  on 30.09.2021.
//

import UIKit

final class CurrentTemperatureCellScreen: UIView {
    
    private var currentDateLabel = UILabel()
    private var weatherImage = UIImageView()
    private var currentTemperatureLabel = UILabel()
    private var currentWeatherDescription = UILabel()
    private var backgroundImage = UIImageView()
    
    var infoAboutFirstDay: WeatherOfTheFirstDay!
    
    private func setUpConstraints() {
        offAutoresizingMasks(elements: [currentDateLabel, weatherImage, currentTemperatureLabel, currentWeatherDescription, backgroundImage])
        
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: self.topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            currentDateLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            currentDateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            currentDateLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            weatherImage.topAnchor.constraint(equalTo: currentDateLabel.bottomAnchor, constant: 12),
            weatherImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            weatherImage.widthAnchor.constraint(equalToConstant: 100),
            weatherImage.heightAnchor.constraint(equalToConstant: 100),
            
            currentTemperatureLabel.topAnchor.constraint(equalTo: weatherImage.bottomAnchor, constant: 6),
            currentTemperatureLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            currentTemperatureLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            currentWeatherDescription.topAnchor.constraint(equalTo: currentTemperatureLabel.bottomAnchor, constant: 2),
            currentWeatherDescription.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            currentWeatherDescription.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
        ])
    }
    
    private func addSubviews() {
        self.addSubview(backgroundImage)
        self.addSubview(currentDateLabel)
        self.addSubview(weatherImage)
        self.addSubview(currentTemperatureLabel)
        self.addSubview(currentWeatherDescription)
    }

    private func configureLabels() {
        currentDateLabel.text = infoAboutFirstDay.todayDate
        currentDateLabel.textAlignment = .center
        currentDateLabel.font = UIFont.semiBold(size: 14)
        currentDateLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        currentWeatherDescription.text = infoAboutFirstDay.weatherDescription
        currentWeatherDescription.textAlignment = .center
        currentWeatherDescription.font = UIFont.semiBold(size: 14)
        currentWeatherDescription.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        currentTemperatureLabel.text = infoAboutFirstDay.currentTemp
        currentTemperatureLabel.textAlignment = .center
        currentTemperatureLabel.font = UIFont.extraBold(size: 48)
        currentTemperatureLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
    
    private func setUpImages() {
        backgroundImage.image = #imageLiteral(resourceName: "Group 33510")
        weatherImage.image = UIImage(named: infoAboutFirstDay.weatherImage) ?? #imageLiteral(resourceName: "01d")
    }

}

extension CurrentTemperatureCellScreen: CurrentTemperatureCellScreenProtocol {
    func configure(model: WeatherOfTheFirstDay) {
        self.infoAboutFirstDay = model
        addSubviews()
        setUpConstraints()
        configureLabels()
        setUpImages()
    }
}
