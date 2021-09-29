//
//  NetworkLayer.swift
//  Weather-2.0
//
//  Created by Дмитрий  on 22.09.2021.
//

import Foundation
import CoreLocation

enum HTTPRequestType {
    case city(city: String)
    case coordinates(latitude: CLLocationDegrees, longitude: CLLocationDegrees)
}

protocol NetworkweatherServiceProtocol {
    func fetchCurrentWeather(forReqquesType requesType: HTTPRequestType, complitionHandler: @escaping (Result<CurrentWeatherData, Error>) -> Void)
}

class NetworkWeatherManager: NetworkweatherServiceProtocol {
    
    static var networkManager = NetworkWeatherManager()
    
    var city = "London"
    var latitude = ""
    var longitude = ""
    
    func fetchCurrentWeather(forReqquesType requesType: HTTPRequestType, complitionHandler: @escaping (Result<CurrentWeatherData, Error>) -> Void) {
        
        var urlString = " "
        
        switch requesType {
        case .city(city: let city):
            urlString = "https://api.openweathermap.org/data/2.5/forecast?q=\(city.encodeUrl)&appid=6fbf251bda906b2794f2c3495a036ab3&cnt=40&units=metric&lang=ru"
            
        case .coordinates(latitude: let latitude, longitude: let longitude):
            urlString = "https://api.openweathermap.org/data/2.5/forecast?lat=\(latitude)&lon=\(longitude)&appid=6fbf251bda906b2794f2c3495a036ab3&cnt=5&units=metric&lang=ru"
        }
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                complitionHandler(.failure(error))
                return
            }
            let decoder = JSONDecoder()
            do {
                let currentWeatherData = try decoder.decode(CurrentWeatherData.self, from: data!)
                complitionHandler(.success(currentWeatherData))
                
            } catch {
                complitionHandler(.failure(error))
            }
        }.resume()
    }
}
