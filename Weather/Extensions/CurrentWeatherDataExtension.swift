//
//  CurrentWeatherDataExtension.swift
//  Weather
//
//  Created by Дмитрий  on 07.10.2021.
//

extension CurrentWeatherData {
    func toCurrentWeather() -> CurrentWeather {
        let listByDays = Dictionary(grouping: self.list, by: { $0.dtTxt.split(separator: " ")[0].description })
        return CurrentWeather(weatherData: self, city: self.city.name, list: self.list, listByDays: listByDays)
    }
}
