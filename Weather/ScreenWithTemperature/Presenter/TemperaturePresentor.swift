//
//  TemperaturePresentor.swift
//  Weather
//
//  Created by Дмитрий on 31.08.2021.

import UIKit

protocol TemperaturePresenterProtocol: AnyObject {
    init(view: TemperatureViewProtocol, networkService: NetworkServiceProtocol)
    func getLists()
    var currentWeather: CurrentWeatherData? { get set }
    var city: String? { get set }
    func getDataByDayAndHour(indexOfDay: Int, indexOfHour: Int) -> Array<List>.Element?
}

class TemperaturePresenter: TemperaturePresenterProtocol {

    var city: String?
    var currentWeather: CurrentWeatherData?
    var listByDays: Dictionary<Optional<Substring>, Array<Array<List>.Element>>?
    weak var view: TemperatureViewProtocol?
    let networkService: NetworkServiceProtocol
    var list = [List]()
    
    func getLists() {
        networkService.fetchCurrentWeather { [weak self] CurrentWeather in
            guard self != nil else { return }
            DispatchQueue.main.async {
                switch CurrentWeather {
                case .success(let currentWeather):
                    self?.currentWeather = currentWeather
                    self?.city = currentWeather.city.name
                    self?.list = currentWeather.list
                    self?.listByDays = Dictionary(grouping: self?.list ?? [List](), by: { $0.dtTxt.split(separator: " ").first })
                    self?.view?.succes()
                case .failure(let error):
                    print(error)
                }
            }
        }
    }

    func getDataByDayAndHour(indexOfDay: Int, indexOfHour: Int) -> Array<List>.Element? {
        let date = Date()
        let formatter = DateFormatter()
        let calendar = Calendar.current
        formatter.dateFormat = "yyyy-MM-dd"
        let selectedDay = calendar.date(byAdding: .day, value: indexOfDay, to: date)
        let stringSelectedDay = selectedDay?.description.split(separator: " ").first
        let infoAboutCurrentDay = listByDays?[stringSelectedDay]?[indexOfHour]
        return infoAboutCurrentDay
    }
    
    required init(view: TemperatureViewProtocol, networkService: NetworkServiceProtocol) {
        self.view = view
        self.networkService = networkService
        self.getLists()
    }
}
