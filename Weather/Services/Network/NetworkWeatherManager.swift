//
//  Temperature.swift
//  Weather
//
//  Created by Дмитрий  on 23.08.2021.
//

import Foundation
import CoreLocation

enum HTTPRequetType {
    case city(city: String)
    case coordinates(latitude: CLLocationDegrees, longitude: CLLocationDegrees)
}

protocol NetworkServiceProtocol {
    func fetchCurrentWeather(complitionHandler: @escaping (Result<CurrentWeatherData, Error>) -> Void)
}

class NetworkWeatherManager: NetworkServiceProtocol {
    
    static var networkManager = NetworkWeatherManager()
    
    var city = "Moscow"
    
    func fetchCurrentWeather(complitionHandler: @escaping (Result<CurrentWeatherData, Error>) -> Void) {
        let urlString = "https://api.openweathermap.org/data/2.5/forecast?q=\(city)&apikey=21a8d636ae57d56ec6fb2ebb46d3e0b4&cnt=40&units=metric&lang=ru"

        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                complitionHandler(.failure(error))
                return
            }
            let decoder = JSONDecoder()
            do {
                let currentWeatherData = try decoder.decode(CurrentWeatherData.self, from: data!)
                guard CurrentWeather(currentWeatherData: currentWeatherData) != nil else { return }
                complitionHandler(.success(currentWeatherData))
                
            } catch {
                complitionHandler(.failure(error))
            }
        }.resume()
    }
}

