//
//  TemperaturePresenter.swift
//  Weather-2.0
//
//  Created by Дмитрий  on 22.09.2021.
//

import Foundation

protocol TemperatureViewProtocol: AnyObject {
    func succes(firstDay: WeatherOfTheFirstDay, secondDays: [WeatherOfTheOtherDays])
    func setTitle(title: String)
    func failure()
}

final class TemperaturePresenter: TemperatureViewPresenterProtocol {
    
    weak var view: TemperatureViewProtocol!
    private let networkService: NetworkWeatherServiceProtocol
    private var weatherData: CurrentWeather!
    
    private var weatherOfTheDays = [WeatherViewModel.self]
    
    required init(networkLayer: NetworkWeatherServiceProtocol) {
        self.networkService = networkLayer
    }
    
    func getInfoByFirstDay() {
        var dateOfDay = WeatherOfTheFirstDay()
        let info = getDataByDay(indexOfDay: 0)
        let stringSelectedDay = getDayString(indexOfDay: 0)
        dateOfDay.todayDate = "Сегодня, " + String.changeDateFormat(dateString: stringSelectedDay, from: "yyy-MM-dd", to: "d MMMM, E")
        dateOfDay.currentTemp = Int(info[0].main.temp).description + "°"
        dateOfDay.weatherDescription = info[0].weather[0].weatherDescription
        dateOfDay.weatherImage = info[0].weather[0].icon
    }
    
    private func createModelOfSecondDay(numberOfDay: Int) -> WeatherOfTheOtherDays {
        var dateOfDay = WeatherOfTheOtherDays()
        let info = getDataByDay(indexOfDay: numberOfDay)
        let stringSelectedDay = getDayString(indexOfDay: numberOfDay)
        dateOfDay.date = String.changeDateFormat(dateString: stringSelectedDay, from: "yyy-MM-dd", to: "d MMMM")
        dateOfDay.day = String.changeDateFormat(dateString: stringSelectedDay, from: "yyy-MM-dd", to: "E")
        dateOfDay.feelsLike = Int(info[numberOfDay].main.feelsLike).description + "°"
        dateOfDay.temp = Int(info[numberOfDay].main.temp).description + "°"
        dateOfDay.weatherImage = info[numberOfDay].weather[0].icon
        return dateOfDay
    }
    
    private func setUpWeatherOfTheSecondDays() {
        var infoOfTheSecondDay = WeatherOfTheOtherDays()
        var infoOfTheThirdDay = WeatherOfTheOtherDays()
        var infoOfTheFourDay = WeatherOfTheOtherDays()
        var infoOfTheFiveDay = WeatherOfTheOtherDays()
        
        infoOfTheSecondDay = createModelOfSecondDay(numberOfDay: 1)
        weatherOfTheDays.append(<#T##newElement: WeatherViewModel.Type##WeatherViewModel.Type#>)
        infoOfTheThirdDay = createModelOfSecondDay(numberOfDay: 2)
        weatherOfTheDays.append(infoOfTheThirdDay)
        infoOfTheFourDay = createModelOfSecondDay(numberOfDay: 3)
        weatherOfTheDays.append(infoOfTheFourDay)
        infoOfTheFiveDay = createModelOfSecondDay(numberOfDay: 4)
        weatherOfTheDays.append(infoOfTheFiveDay)
    }
    
    private func getDayString(indexOfDay: Int) -> String {
        let date = Date()
        let formatter = DateFormatter()
        let calendar = Calendar.current
        formatter.dateFormat = "yyyy-MM-dd"
        guard let selectedDay = calendar.date(byAdding: .day, value: indexOfDay, to: date) else { return "" }
        assert(calendar.date(byAdding: .day, value: indexOfDay, to: date) != nil, "Calendar not found")
        guard let selectedDay = selectedDay.description.split(separator: " ").first?.description else { return ""}
        let stringSelectedDay = selectedDay
        return stringSelectedDay
    }
    
    func getDataByDay(indexOfDay: Int) -> [WeatherList] {
        let stringSelectedDay = getDayString(indexOfDay: indexOfDay)
        guard let infoAboutCurrentDay = weatherData.listByDays[stringSelectedDay] else { return [WeatherList]() }
        return infoAboutCurrentDay
    }
    
    func showWeatherList() {
        networkService.fetchCurrentWeather(forReqquesType: .city(city: RequestParameters.city)) { [weak self] result in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                switch result {
                case .success(let weather):
                    self.weatherData = weather.toCurrentWeather()
                    self.view.setTitle(title: weather.city.name)
                    self.getInfoByFirstDay()
                    self.setUpWeatherOfTheSecondDays()
                    self.view.succes(firstDay: self.infoOfTheFirstDay, secondDays: self.weatherOfTheSecondDays)
                case .failure(let error):
                    print(error)
                    self.view.failure()
                }
            }
        }
    }
}
