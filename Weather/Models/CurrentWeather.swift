//
//  CurrentWeather.swift
//  Weather
//
//  Created by Дмитрий  on 24.08.2021.
//

import Foundation

struct CurrentWeather {
    var list = [List]()
    var listByDays = Dictionary<Optional<Substring>, Array<Array<List>.Element>>()
    
    func getDatabyDayAndHour(indexOfDay: Int, indexOfHour: Int) -> Array<List>.Element? {
        let date = Date()
        let selectedDay = Calendar.current.date(byAdding: .day, value: indexOfDay, to: date) ?? Date()
        let stringSelectedDay = "\(selectedDay)".split(separator: " ").first
        let infoAboutCurrentDay = listByDays[stringSelectedDay]?[indexOfHour]
        return infoAboutCurrentDay
    }

    init?(currentWeatherData: CurrentWeatherData) {
        list = currentWeatherData.list
        listByDays = Dictionary(grouping: list, by: { $0.dtTxt.split(separator: " ").first })
    }
}
