//
//  DetailsWeatherCollectionViewCell.swift
//  Weather
//
//  Created by Дмитрий  on 20.10.2021.
//

import UIKit

final class DetailWeatherCollectionViewCell: UICollectionViewCell {
    
    var id = "DetailsWeatherCollectionViewCell"
    private var currentDayLabel: UILabel!
    private var weatherImage: UIImageView!
    private var temperatureLabel: UILabel!
    private var weatherDescription: UILabel!
    private var windLabel: UILabel!
    private var windDescription: UILabel!
    private var humidityLabel: UILabel!
    private var humidityDescription: UILabel!
    private var rainfallLabel: UILabel!
    private var rainfallDescription: UILabel!
    private var backgroundImage: UIImageView!
    
    func configure(weatherData: WeatherOfTheFirstDayProtocol) {
        contentView.layer.cornerRadius = 16
        createUI(weatherData: weatherData)
        addSubViews()
        createConstraints()
    }
    
    private func createUI(weatherData: WeatherOfTheFirstDayProtocol) {
        backgroundImage = createBackgroundImage()
        
        currentDayLabel = createCurrentDayLabel(text: weatherData.time)
        weatherImage = createWeatherImage(image: weatherData.weatherImage)
        temperatureLabel = createTemperatureLabel(text: weatherData.temperature)
        weatherDescription = createWeatherDescriptionLabel(text: weatherData.weatherDescription)
        
        windLabel = createParameterLabel(text: "Ветер")
        humidityLabel = createParameterLabel(text: "Влажность")
        rainfallLabel = createParameterLabel(text: "Осадки")
        
        windDescription = createBottomLabel(text: weatherData.windDescription)
        humidityDescription = createBottomLabel(text: weatherData.humidity)
        rainfallDescription = createBottomLabel(text: weatherData.rainfall)
    }
    
    private func addSubViews() {
        contentView.addSubview(backgroundImage)
        contentView.addSubview(rainfallDescription)
        contentView.addSubview(currentDayLabel)
        contentView.addSubview(temperatureLabel)
        contentView.addSubview(weatherDescription)
        contentView.addSubview(windLabel)
        contentView.addSubview(windDescription)
        contentView.addSubview(humidityLabel)
        contentView.addSubview(humidityDescription)
        contentView.addSubview(rainfallLabel)
        contentView.addSubview(weatherImage)
    }
    
    private func createConstraints() {
        
        offAutoresizingMasks(elements: [backgroundImage,
                                        rainfallDescription,
                                        currentDayLabel,
                                        temperatureLabel,
                                        weatherDescription,
                                        windLabel,
                                        windDescription,
                                        humidityLabel,
                                        humidityDescription,
                                        rainfallLabel,
                                        weatherImage])
        
        backgroundImage.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        backgroundImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        backgroundImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        backgroundImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        
        currentDayLabel.topAnchor.constraint(equalTo: backgroundImage.topAnchor, constant: 16).isActive = true
        currentDayLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        weatherImage.topAnchor.constraint(equalTo: currentDayLabel.bottomAnchor, constant: 12).isActive = true
        weatherImage.widthAnchor.constraint(equalToConstant: 120).isActive = true
        weatherImage.heightAnchor.constraint(equalToConstant: 120).isActive = true
        weatherImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        temperatureLabel.topAnchor.constraint(equalTo: weatherImage.bottomAnchor, constant: 8).isActive = true
        temperatureLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        weatherDescription.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 8).isActive = true
        weatherDescription.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        windLabel.topAnchor.constraint(equalTo: weatherDescription.bottomAnchor, constant: 32).isActive = true
        windLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32).isActive = true
        
        windDescription.topAnchor.constraint(equalTo: windLabel.bottomAnchor, constant: 2).isActive = true
        windDescription.leadingAnchor.constraint(equalTo: windLabel.leadingAnchor).isActive = true
        
        humidityLabel.topAnchor.constraint(equalTo: weatherDescription.bottomAnchor, constant: 32).isActive = true
        humidityLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        humidityDescription.topAnchor.constraint(equalTo: humidityLabel.bottomAnchor, constant: 2).isActive = true
        humidityDescription.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        rainfallLabel.topAnchor.constraint(equalTo: weatherDescription.bottomAnchor, constant: 32).isActive = true
        rainfallLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32).isActive = true
        
        rainfallDescription.topAnchor.constraint(equalTo: rainfallLabel.bottomAnchor, constant: 2).isActive = true
        rainfallDescription.trailingAnchor.constraint(equalTo: rainfallLabel.trailingAnchor).isActive = true
    }
}
