//
//  DetailsWeatherCollectionViewCell.swift
//  Weather
//
//  Created by Дмитрий  on 20.10.2021.
//

import UIKit

final class DetailWeatherCollectionViewCell: UICollectionViewCell {
    
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
    
    func configure(weatherData: DetailsWeatherModelProtocol) {
        createUI(weatherData: weatherData)
    }
    
    private func createUI(weatherData: DetailsWeatherModelProtocol) {
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
}
