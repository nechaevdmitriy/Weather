//
//  TemperaturePresenter.swift
//  Weather-2.0
//
//  Created by Дмитрий  on 22.09.2021.
//

import Foundation

protocol TemperatureViewProtocol: AnyObject {
    func succes(days: [WeatherDataProtocol], title: String)
    func failure()
}

final class TemperaturePresenter: TemperatureViewPresenterProtocol {
    
    weak var view: TemperatureViewProtocol!
    private let networkService: NetworkWeatherServiceProtocol
    private var weatherData: CurrentWeather!
    private var weatherOfTheDays = [WeatherDataProtocol]()
    
    required init(networkLayer: NetworkWeatherServiceProtocol) {
        self.networkService = networkLayer
    }
    
    func getInfoByFirstDay() {
        var dateOfDay = WeatherOfTheFirstDay()
        let info = getDataByDay(indexOfDay: 0)
        let stringSelectedDay = getDayString(indexOfDay: 0)
        dateOfDay.time = "Сегодня, " + String.changeDateFormat(dateString: stringSelectedDay, from: "yyy-MM-dd", to: "d MMMM, E")
        dateOfDay.temperature = Int(info[0].main.temp).description + "°"
        dateOfDay.weatherDescription = info[0].weather[0].weatherDescription
        dateOfDay.weatherImage = info[0].weather[0].icon
        weatherOfTheDays.insert(dateOfDay, at: 0)
    }
    
    private func createWeatherOfSecondDay(numberOfDay: Int) -> WeatherOfTheOtherDays {
        var dateOfDay = WeatherOfTheOtherDays()
        let info = getDataByDay(indexOfDay: numberOfDay)
        let stringSelectedDay = getDayString(indexOfDay: numberOfDay)
        dateOfDay.time = String.changeDateFormat(dateString: stringSelectedDay, from: "yyy-MM-dd", to: "d MMMM,")
        dateOfDay.day = String.changeDateFormat(dateString: stringSelectedDay, from: "yyy-MM-dd", to: "E")
        dateOfDay.feelsLike = Int(info[numberOfDay].main.feelsLike).description + "°"
        dateOfDay.temperature = Int(info[0].main.temp).description + "°"
        dateOfDay.weatherImage = info[0].weather[0].icon
        dateOfDay.weatherByHours = getWeatherByHours(numberOfDay: numberOfDay)
        return dateOfDay
    }
    
    private func getWeatherByHours(numberOfDay: Int) -> [WeatherByHours] {
        var days = [WeatherByHours]()
        let info = getDataByDay(indexOfDay: numberOfDay)
        let countOfHoursInDay = 8
        
        for indexOfTheDay in 0...(countOfHoursInDay - 1) {
            let weatherByHour = info[indexOfTheDay]
            var model = WeatherByHours()
            let dtTxt = weatherByHour.dtTxt.split(separator: " ")[1].description.split(separator: ":")[0].description + ":00"
            model.hour = dtTxt
            model.temp = Int(weatherByHour.main.temp).description + "°"
            model.weatherImage = weatherByHour.weather[0].icon
            days.append(model)
        }
        return days
    }
    
    private func getDataByDay(indexOfDay: Int) -> [WeatherList] {
        let stringSelectedDay = getDayString(indexOfDay: indexOfDay)
        guard let infoAboutCurrentDay = weatherData.listByDays[stringSelectedDay] else { return [WeatherList]() }
        return infoAboutCurrentDay
    }
    
    private func getDayString(indexOfDay: Int) -> String {
        let date = Date()
        let calendar = Calendar.current
        guard let selectedDay = calendar.date(byAdding: .day, value: indexOfDay, to: date) else { return "" }
        assert(calendar.date(byAdding: .day, value: indexOfDay, to: date) != nil, "Calendar not found")
        guard let selectedDay = selectedDay.description.split(separator: " ").first?.description else { return ""}
        let stringSelectedDay = selectedDay
        return stringSelectedDay
    }
    
    func showWeatherList() {
        networkService.fetchCurrentWeather(forReqquesType: .city(city: RequestParameters.city)) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .succes(value: let value):
                DispatchQueue.main.async {
                    self.weatherData = value.toCurrentWeather()
                    self.getInfoByFirstDay()
                    self.setUpWeatherOfTheSecondDays()
                    self.view.succes(days: self.weatherOfTheDays, title: (value.city.name))
                }
            case .failure(error: let error):
                print(error.localizedDescription)
                self.view.failure()
            }
        }
    }
    
    private func setUpWeatherOfTheSecondDays() {
        var infoOfTheSecondDay = WeatherOfTheOtherDays()
        var infoOfTheThirdDay = WeatherOfTheOtherDays()
        var infoOfTheFourDay = WeatherOfTheOtherDays()
        var infoOfTheFiveDay = WeatherOfTheOtherDays()
        
        infoOfTheSecondDay = createWeatherOfSecondDay(numberOfDay: 1)
        weatherOfTheDays.insert(infoOfTheSecondDay, at: 1)
        infoOfTheThirdDay = createWeatherOfSecondDay(numberOfDay: 2)
        weatherOfTheDays.insert(infoOfTheThirdDay, at: 2)
        infoOfTheFourDay = createWeatherOfSecondDay(numberOfDay: 3)
        weatherOfTheDays.insert(infoOfTheFourDay, at: 3)
        infoOfTheFiveDay = createWeatherOfSecondDay(numberOfDay: 4)
        weatherOfTheDays.insert(infoOfTheFiveDay, at: 4)
    }
}
