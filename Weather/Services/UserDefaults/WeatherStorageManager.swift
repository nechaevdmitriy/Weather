//
//  WeatherStorageManager.swift
//  Weather
//
//  Created by Дмитрий  on 12.12.2021.
//

import Foundation

enum UserDefaultsResult {
    case succes (data: CurrentWeatherData)
    case failure
}

protocol WeatherStorageManagerDelegate {
    func setData(data: CurrentWeatherData)
    func getData(complitionHandler: (UserDefaultsResult) -> ())
}

final class WeatherStorageManager: WeatherStorageManagerDelegate {
    func setData(data: CurrentWeatherData) {
        UserDefaults.standard.set(try? PropertyListEncoder().encode(data), forKey: "weather")
    }
    
    func getData(complitionHandler: (UserDefaultsResult) -> ()) {
        if let data = UserDefaults.standard.value(forKey:"weather") as? Data {
            if let weatherData = try? PropertyListDecoder().decode(CurrentWeatherData.self, from: data) {
                complitionHandler(UserDefaultsResult.succes(data: weatherData))
            }
        } else {
            complitionHandler(UserDefaultsResult.failure)
        }
    }
}
