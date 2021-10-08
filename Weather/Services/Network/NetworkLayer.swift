//
//  NetworkLayer.swift
//  Weather-2.0
//
//  Created by Дмитрий  on 22.09.2021.
//

import Foundation
import CoreLocation

protocol NetworkWeatherServiceProtocol {
    func fetchCurrentWeather(forReqquesType requesType: HTTPRequestType, complitionHandler: @escaping (Result<CurrentWeatherData, Error>) -> Void)
}

class NetworkWeatherManager: NetworkWeatherServiceProtocol {
    
    func fetchCurrentWeather(forReqquesType requesType: HTTPRequestType, complitionHandler: @escaping (Result<CurrentWeatherData, Error>) -> Void) {
        guard let url = createURL(requesType: requesType) else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                complitionHandler(.failure(error))
                return
            }
            do {
                let currentWeatherData = try JSONDecoder().decode(CurrentWeatherData.self, from: data!)
                complitionHandler(.success(currentWeatherData))
            } catch {
                complitionHandler(.failure(error))
            }
        }.resume()
    }
    
    private func createURL(requesType: HTTPRequestType) -> URL? {
        
        let url = "https://api.openweathermap.org/data/2.5/forecast?"
        let parametres = "&appid=6fbf251bda906b2794f2c3495a036ab3&cnt=40&units=metric&lang=ru"
        var urlString = ""
        
        switch requesType {
        case .city(city: let city):
            urlString = url + "q=\(city.encodeUrl)" + parametres
            
        case .coordinates(latitude: let latitude, longitude: let longitude):
            urlString = url + "lat=\(latitude)&lon=\(longitude)" + parametres
        }
        
        guard let url = URL(string: urlString) else { return nil }
        return url
    }
}
