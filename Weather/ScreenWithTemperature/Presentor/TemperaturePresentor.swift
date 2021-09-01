//
//  TemperaturePresentor.swift
//  Weather
//
//  Created by Дмитрий on 31.08.2021.

import Foundation

protocol TemperaturePresentorProtocol: AnyObject {
    init(view: TemperatureViewProtocol, networkService: NetworkServiceProtocol)
    func getLists()
    var city: String? {get set}
    var lists: [List]? { get set }
    var listByDays: Dictionary<Optional<Substring>, Array<Array<List>.Element>>? {get set}
    func getDatabyDayAndHour(indexOfDay: Int, indexOfHour: Int) -> Array<List>.Element?
}

class temperaturePresentor: TemperaturePresentorProtocol {
    
    var city: String?
    var lists: [List]?
    
    weak var view: TemperatureViewProtocol?
    let networkService: NetworkServiceProtocol
    var listByDays: Dictionary<Optional<Substring>, Array<Array<List>.Element>>?
    
    func getDatabyDayAndHour(indexOfDay: Int, indexOfHour: Int) -> Array<List>.Element? {
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
        getLists()
    }
    
    func getLists() {
        networkService.fetchCurrentWeather { [weak self] CurrentWeather in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.city = CurrentWeather.city
                self.lists = CurrentWeather.list
                self.listByDays = CurrentWeather.listByDays
            }
        }
    }
}
