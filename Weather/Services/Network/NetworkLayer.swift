//
//  NetworkLayer.swift
//  Weather-2.0
//
//  Created by Дмитрий  on 22.09.2021.
//

import Foundation
import Alamofire

protocol NetworkWeatherServiceProtocol {
    func fetchCurrentWeather(forReqquesType requesType: HTTPRequestType, complitionHandler: @escaping (RequesResult) -> Void)
}

enum RequesResult {
    case succes(value: CurrentWeatherData)
    case failure(error: Error)
}

final class NetworkWeatherManager: NetworkWeatherServiceProtocol {
    
    func fetchCurrentWeather(forReqquesType requesType: HTTPRequestType, complitionHandler: @escaping (RequesResult) -> Void) {
        guard let urlString = createURL(requesType: requesType) else { return }
        AF.request(urlString).validate().responseDecodable(of: CurrentWeatherData.self) { dataResponse in
            switch dataResponse.result {
            case .success(_):
                guard let data = dataResponse.value else { return }
                complitionHandler(RequesResult.succes(value: data))
            case .failure(let error):
                complitionHandler(RequesResult.failure(error: error))
            }
        }
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
