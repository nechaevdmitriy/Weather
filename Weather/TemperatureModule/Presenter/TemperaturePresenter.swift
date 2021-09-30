//
//  TemperaturePresenter.swift
//  Weather-2.0
//
//  Created by Дмитрий  on 22.09.2021.
//

import Foundation

protocol TemperatureViewProtocol: AnyObject {
    func succes(weatherOfTheDays: [[WeatherList]])
    func setTitle(title: String)
    func failure()
}

final class TemperaturePresenter: TemperatureViewPresenterProtocol {
    
    weak var view: TemperatureViewProtocol!
    private let networkService: NetworkWeatherServiceProtocol
    private var weatherData: CurrentWeather!
    private var weatherOfTheDays = [[WeatherList]]()
    
    required init(view: TemperatureViewProtocol, networkLayer: NetworkWeatherServiceProtocol) {
        self.view = view
        self.networkService = networkLayer
        showWeatherList()
    }
    
    func getDataByDay(indexOfDay: Int) -> [WeatherList] {
        let date = Date()
        let formatter = DateFormatter()
        let calendar = Calendar.current
        formatter.dateFormat = "yyyy-MM-dd"
        guard let selectedDay = calendar.date(byAdding: .day, value: indexOfDay, to: date) else { return [WeatherList]() }
        assert(calendar.date(byAdding: .day, value: indexOfDay, to: date) != nil)
        let stringSelectedDay = selectedDay.description.split(separator: " ")[0]
        guard let infoAboutCurrentDay = weatherData.listByDays[stringSelectedDay] else { return [WeatherList]() }
        assert((weatherData.listByDays[stringSelectedDay]) != nil)
        return infoAboutCurrentDay
    }
    
    func getInfoAboutDays() {
        for i in 0...4{
            let dataOfTheDay = getDataByDay(indexOfDay: i)
            let weatherOfTheDay = dataOfTheDay
            weatherOfTheDays.append(weatherOfTheDay)
        }
    }
    func setTitle(title: String) {
        
    }
    
    func showWeatherList() {
        networkService.fetchCurrentWeather(forReqquesType: .city(city: RequestParameters.city)) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let weather):
                    let currentWeather = weather.toCurrentWeather()
                    self.weatherData = currentWeather
                    self.getInfoAboutDays()
                    self.view.setTitle(title: weather.city.name)
                    self.view.succes(weatherOfTheDays: self.weatherOfTheDays)
                case .failure(let error):
                    print(error)
                    self.view.failure()
                }
            }
        }
    }
}
