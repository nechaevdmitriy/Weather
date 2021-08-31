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
    
    func getData(indexOfDay: Int, indexOfHour: Int) {
        
    }

    init?(currentWeatherData: CurrentWeatherData) {
        list = currentWeatherData.list
        listByDays = Dictionary(grouping: list, by: { $0.dtTxt.split(separator: " ").first })
    }
}
