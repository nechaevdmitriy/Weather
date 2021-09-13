//
//  TemperaturePresentor.swift
//  Weather
//
//  Created by Дмитрий on 31.08.2021.

import Foundation
import CoreLocation

protocol TemperaturePresenterProtocol: AnyObject {
    init(view: TemperatureViewProtocol, networkService: NetworkServiceProtocol, requesType: HTTPRequetType)
    func getLists(requesType: HTTPRequetType)
    var currentWeather: CurrentWeatherData? { get set }
    var city: String? { get set }
    func getDataByDayAndHour(indexOfDay: Int, indexOfHour: Int) -> Array<WeatherList>.Element?
    var countOfElementsInCurrentDay: Int {get set}
}

class TemperaturePresenter: TemperaturePresenterProtocol {
    var city: String?
    var currentWeather: CurrentWeatherData?
    var listByDays: Dictionary<Optional<Substring>, Array<Array<WeatherList>.Element>>?
    var countOfElementsInCurrentDay = Int()
    
    weak var view: TemperatureViewProtocol?
    let networkService: NetworkServiceProtocol
    var list = [WeatherList]()
    
    func getLists(requesType: HTTPRequetType) {
        switch requesType {
        case .city(city: let city):
            networkService.fetchCurrentWeather(forReqquesType: .city(city: city)) { [weak self] CurrentWeather in
                guard self != nil else { return }
                
                DispatchQueue.main.async {
                    switch CurrentWeather {
                    case .success(let currentWeather):
                        self?.currentWeather = currentWeather
                        self?.city = currentWeather.city.name
                        self?.list = currentWeather.list
                        self?.listByDays = Dictionary(grouping: self?.list ?? [WeatherList](), by: { $0.dtTxt.split(separator: " ").first })
                        self?.view?.succes()
                    case .failure(let error):
                        print(error)
                    }
                }
            }
            
        case .coordinates(latitude: let latitude, longitude: let longitude):
            networkService.fetchCurrentWeather(forReqquesType: .coordinates(latitude: latitude, longitude: longitude)) { [weak self] CurrentWeather in
                guard self != nil else { return }
                DispatchQueue.main.async {
                    switch CurrentWeather {
                    case .success(let currentWeather):
                        self?.currentWeather = currentWeather
                        self?.city = currentWeather.city.name
                        self?.list = currentWeather.list
                        self?.listByDays = Dictionary(grouping: self?.list ?? [WeatherList](), by: { $0.dtTxt.split(separator: " ").first })
                        self?.view?.succes()
                    case .failure(let error):
                        print(error)
                    }
                }
            }
        }
    }

    func getDataByDayAndHour(indexOfDay: Int, indexOfHour: Int) -> Array<WeatherList>.Element? {
        
        let date = Date()
        let formatter = DateFormatter()
        let calendar = Calendar.current
        formatter.dateFormat = "yyyy-MM-dd"
        let selectedDay = calendar.date(byAdding: .day, value: indexOfDay, to: date)
        let stringSelectedDay = selectedDay?.description.split(separator: " ").first
        
        countOfElementsInCurrentDay = listByDays?[stringSelectedDay]?.count ?? 0
        
        let infoAboutCurrentDay = listByDays?[stringSelectedDay]?[indexOfHour]
        return infoAboutCurrentDay
    }
    
    required init(view: TemperatureViewProtocol, networkService: NetworkServiceProtocol, requesType: HTTPRequetType) {
        self.view = view
        self.networkService = networkService
        
        switch requesType {
        case .city(city: let city):
            self.getLists(requesType: .city(city: city))
        case .coordinates(latitude: let latitude, longitude: let longitude):
            self.getLists(requesType: .coordinates(latitude: latitude, longitude: longitude))
        }
    }
}
