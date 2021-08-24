//
//  Temperature.swift
//  Weather
//
//  Created by Дмитрий  on 23.08.2021.
//

import UIKit

class NetworkWeatherManager {
    
    static var networkManager = NetworkWeatherManager()
    
    func fetchCurrentWeather(forCity city: String, index: Int, complitionHandler: @escaping (CurrentWeather) -> Void) {
        let urlString = "https://api.openweathermap.org/data/2.5/forecast?q=\(city)&apikey=21a8d636ae57d56ec6fb2ebb46d3e0b4&cnt=5"
        
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if let data = data {
                print(data)
                if let currentWeather = self.parseJSON(withData: data, index: index) {
                complitionHandler(currentWeather)
                }
            }
        }
        task.resume()
    }
    
    func parseJSON(withData data: Data, index: Int) -> CurrentWeather? {
        let decoder = JSONDecoder()
        do {
            let currentWeatherData = try decoder.decode(CurrentWeatherData.self, from: data)
            guard let currentData = CurrentWeather(currentWeatherData: currentWeatherData, index: index) else {return nil}
            return currentData
            
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
    }
    
    private init() {}
}



