//
//  Temperature.swift
//  Weather
//
//  Created by Дмитрий  on 23.08.2021.
//

import UIKit

class NetworkWeatherManager {
    
    static var networkManager = NetworkWeatherManager()
    
    var city = "Moscow"
    
    func fetchCurrentWeather(complitionHandler: @escaping (CurrentWeather) -> Void) {
        
        let urlString = "https://api.openweathermap.org/data/2.5/forecast?q=\(city)&apikey=21a8d636ae57d56ec6fb2ebb46d3e0b4&cnt=40&units=metric&lang=ru"
        
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if let data = data {
                if let currentWeather = self.parseJSON(withData: data) {
                complitionHandler(currentWeather)
                }
            }
        }
        task.resume()
    }
    
    func parseJSON(withData data: Data) -> CurrentWeather? {
        let decoder = JSONDecoder()
        do {
            let currentWeatherData = try decoder.decode(CurrentWeatherData.self, from: data)
            guard let currentData = CurrentWeather(currentWeatherData: currentWeatherData) else { return nil }
            return currentData
            
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
    }
    
    private init() {}
}



