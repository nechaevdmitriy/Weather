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
    let networkService: NetworkweatherServiceProtocol
    var weatherData: CurrentWeather?
    
    var weatherOfTheDays = [[WeatherByDay]]()
    
    private var weatherOfTheFirstDay = [WeatherByDay]()
    private var weatherOfTheTwoDay = [WeatherByDay]()
    private var weatherOfTheThreeDay = [WeatherByDay]()
    private var weatherOfTheFourDay = [WeatherByDay]()
    private var weatherOfTheFiveDay = [WeatherByDay]()
    
    required init(view: TemperatureViewProtocol, networkLayer: NetworkweatherServiceProtocol) {
        self.view = view
        self.networkService = networkLayer
        showWeatherList()
    }
    
    private func getDataByDay(indexOfDay: Int) -> [Array<WeatherList>.Element]?{
        let date = Date()
        let formatter = DateFormatter()
        let calendar = Calendar.current
        formatter.dateFormat = "yyyy-MM-dd"
        let selectedDay = calendar.date(byAdding: .day, value: indexOfDay, to: date)
        let stringSelectedDay = selectedDay?.description.split(separator: " ").first
        let infoAboutCurrentDay = weatherData?.listByDays[stringSelectedDay]
        return infoAboutCurrentDay
    }
    
    private func getInfoAboutDays() {
        for i in 0...4{
        guard let dataOfTheDay = getDataByDay(indexOfDay: i) else {return}
            switch i {
            case 0:
                weatherOfTheFirstDay = dataOfTheDay
                weatherOfTheDays.append(weatherOfTheFirstDay)
            case 1:
                weatherOfTheTwoDay = dataOfTheDay
                weatherOfTheDays.append(weatherOfTheTwoDay)
            case 2:
                weatherOfTheThreeDay = dataOfTheDay
                weatherOfTheDays.append(weatherOfTheThreeDay)
            case 3:
                weatherOfTheFourDay = dataOfTheDay
                weatherOfTheDays.append(weatherOfTheFourDay)
            case 4:
                weatherOfTheFiveDay = dataOfTheDay
                weatherOfTheDays.append(weatherOfTheFiveDay)
            default:
                break
            }
        }
    }
    
    private func showWeatherList() {
        networkService.fetchCurrentWeather(forReqquesType: .city(city: NetworkWeatherManager.networkManager.city)) { [weak self] result in
            guard self != nil else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let weather):
                    guard let currentWeather = CurrentWeather(currentWeatherData: weather) else { return }
                    self?.weatherData = currentWeather
                    self?.getInfoAboutDays()
                    self?.view?.collectionViewScreen.dataSource.weatherOfTheDays = self?.weatherOfTheDays
                    self?.view?.succes()
                case .failure(let error):
                    print(error)
                    self?.view?.failure()
                }
            }
        }
    }
}
