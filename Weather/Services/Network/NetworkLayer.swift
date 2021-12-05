//
//  NetworkLayer.swift
//  Weather-2.0
//
//  Created by Дмитрий  on 22.09.2021.
//

import Foundation
import Alamofire

protocol NetworkWeatherServiceProtocol {
    func fetchCurrentWeather(complitionHandler: @escaping (RequesResult) -> Void)
}

enum RequesResult {
    case succes(value: CurrentWeatherData)
    case failure(error: Error)
}

final class NetworkWeatherManager: NetworkWeatherServiceProtocol {
    
    func fetchCurrentWeather(complitionHandler: @escaping (RequesResult) -> Void) {
        guard let urlString = createURL() else { return }
        let request = URLRequest(url: urlString)
        AF.request(request).validate().responseDecodable(of: CurrentWeatherData.self) { dataResponse in
            
            switch dataResponse.result {
            case .success(let data):
                UserDefaults.standard.set(try? PropertyListEncoder().encode(data), forKey: "weather")
                complitionHandler(RequesResult.succes(value: data))
            case .failure(let error):
                if let data = UserDefaults.standard.value(forKey:"weather") as? Data {
                    if let weatherData = try? PropertyListDecoder().decode(CurrentWeatherData.self, from: data) {
                        complitionHandler(RequesResult.succes(value: weatherData))
                    }
                } else {
                    complitionHandler(RequesResult.failure(error: error))
                }
            }
        }
    }
}

private func createURL() -> URL? {
    let city = "Санкт-Петербург"
    let urlString = "https://api.openweathermap.org/data/2.5/forecast?q=\(city.encodeUrl)&appid=6fbf251bda906b2794f2c3495a036ab3&cnt=40&units=metric&lang=ru"
    
    guard let url = URL(string: urlString) else { return nil }
    return url
}

