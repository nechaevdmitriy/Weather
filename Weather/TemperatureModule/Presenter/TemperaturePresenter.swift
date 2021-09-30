//
//  TemperaturePresenter.swift
//  Weather-2.0
//
//  Created by Дмитрий  on 22.09.2021.
//

import Foundation

protocol TemperatureViewProtocol: AnyObject {
    var collectionViewScreen: TemperatureScreenViewProtocol! { get set }
    func succes()
    func failure()
}

final class TemperaturePresenter: TemperatureViewPresenterProtocol {
    
    weak var view: TemperatureViewProtocol?
    let networkService: NetworkWeatherServiceProtocol
    var weatherData: CurrentWeather?
    
    var weatherOfTheDays = [[WeatherList]]()
    
    required init(view: TemperatureViewProtocol, networkLayer: NetworkWeatherServiceProtocol) {
        self.view = view
        self.networkService = networkLayer
        showWeatherList()
    }
    
    private func getDataByDay(indexOfDay: Int) -> [WeatherList] {
        let date = Date()
        let formatter = DateFormatter()
        let calendar = Calendar.current
        formatter.dateFormat = "yyyy-MM-dd"
        guard let selectedDay = calendar.date(byAdding: .day, value: indexOfDay, to: date) else { return [WeatherList]() }
        assert(calendar.date(byAdding: .day, value: indexOfDay, to: date) == nil)
        let stringSelectedDay = selectedDay.description.split(separator: " ")[0]
        guard let infoAboutCurrentDay = weatherData?.listByDays[stringSelectedDay] else { return [WeatherList]() }
        assert((weatherData?.listByDays[stringSelectedDay]) == nil)
        return infoAboutCurrentDay
    }
    
    private func getInfoAboutDays() {
        for i in 0...4{
        let dataOfTheDay = getDataByDay(indexOfDay: i)
                let weatherOfTheDay = dataOfTheDay
                weatherOfTheDays.append(weatherOfTheDay)
        }
    }
    
    private func showWeatherList() {
        networkService.fetchCurrentWeather(forReqquesType: .city(city: NetworkWeatherManager.networkManager.city)) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let weather):
                    guard let currentWeather = CurrentWeather(currentWeatherData: weather) else { return }
                    self.weatherData = currentWeather
                    self.getInfoAboutDays()
                    self.view?.succes()
                case .failure(let error):
                    print(error)
                    self.view?.failure()
                }
            }
        }
    }
}
