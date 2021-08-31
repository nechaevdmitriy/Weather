//
//  CurrentWeather.swift
//  Weather
//
//  Created by Дмитрий  on 24.08.2021.
//

import Foundation

struct CurrentWeather {
    var city = String()
    var list = [List]()
    var listByDays = Dictionary<Optional<Substring>, Array<Array<List>.Element>>()
    
    
    func getDatabyDayAndHour(indexOfDay: Int, indexOfHour: Int) -> Array<List>.Element? {
        let date = Date()
        let formatter = DateFormatter()
        let calendar = Calendar.current
        formatter.dateFormat = "yyyy-MM-dd"
        
        
        let selectedDay = calendar.date(byAdding: .day, value: indexOfDay, to: date)
        let stringSelectedDay = selectedDay?.description.split(separator: " ").first
        let infoAboutCurrentDay = listByDays[stringSelectedDay]?[indexOfHour]
        return infoAboutCurrentDay
    }

    init?(currentWeatherData: CurrentWeatherData) {
        city = currentWeatherData.city.name
        list = currentWeatherData.list
        listByDays = Dictionary(grouping: list, by: { $0.dtTxt.split(separator: " ").first })
    }
}
