//
//  Temperature.swift
//  Weather
//
//  Created by Дмитрий  on 23.08.2021.
//

import UIKit

class NetworkWeatherManager {
    
    static var networkManager = NetworkWeatherManager()
    
    func fetchCurrentWeather(forCity city: String) {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&apikey=21a8d636ae57d56ec6fb2ebb46d3e0b4"
        
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if let data = data {
                print(data)
                //self.parseJSON(withData: data)
            }
        }
        task.resume()
    }
    
    func parseJSON(withData data: Data) {
        let decoder = JSONDecoder()
        do {
            let currentWeatherData = try decoder.decode(CurrentWeatherData.self, from: data)
            print(currentWeatherData.main.temp)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    private init() {}
}



