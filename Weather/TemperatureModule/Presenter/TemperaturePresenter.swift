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
    func tapOnTheCell()
}

final class TemperaturePresenter: TemperatureViewPresenterProtocol {
    
    weak var view: TemperatureViewProtocol!
    private let networkService: NetworkWeatherServiceProtocol
    private var weatherData: CurrentWeather!
    private var weatherOfTheDays = [WeatherDataProtocol]()
    private var router: RouterProtocol!
    
    required init(networkLayer: NetworkWeatherServiceProtocol, router: RouterProtocol) {
        self.networkService = networkLayer
        self.router = router
    }
    
    func tapOnTheCell() {
        guard let model = weatherOfTheDays.first as? WeatherOfTheFirstDay else { return }
        router.showDetail(model: model)
    }

    func getInfoByFirstDay() {
        var dateOfDay = WeatherOfTheFirstDay()

        let info: [WeatherList] = {
            var list = getDataByDay(indexOfDay: 0)
            if list.isEmpty { list = getDataByDay(indexOfDay: 1) }
            return list
        }()

        let stringSelectedDay = getDayString(indexOfDay: 0)
        dateOfDay.time = "Сегодня, " + String.changeDateFormat(dateString: stringSelectedDay, from: "yyy-MM-dd", to: "d MMMM, E")
        dateOfDay.temperature = Int(info[0].main.temp).description + "°"
        dateOfDay.weatherDescription = info[0].weather[0].weatherDescription
        dateOfDay.weatherImage = info[0].weather[0].icon
        dateOfDay.humidity = info[0].main.humidity.description + " %"
        dateOfDay.rainfall = info[0].main.tempKf.description
        dateOfDay.windDescription = Int(info[0].wind.speed).description + " м/с"
        weatherOfTheDays.insert(dateOfDay, at: 0)
    }
    
    private func createWeatherOfSecondDay(numberOfDay: Int) -> WeatherOfTheOtherDays {
        var dateOfDay = WeatherOfTheOtherDays()
        let info = getDataByDay(indexOfDay: numberOfDay)
        let stringSelectedDay = getDayString(indexOfDay: numberOfDay)
        dateOfDay.time = String.changeDateFormat(dateString: stringSelectedDay, from: "yyy-MM-dd", to: "d MMMM,")
        dateOfDay.day = String.changeDateFormat(dateString: stringSelectedDay, from: "yyy-MM-dd", to: "E")
        dateOfDay.feelsLike = Int(info[numberOfDay].main.feelsLike).description + "°"
        dateOfDay.temperature = Int(info[5].main.temp).description + "°"
        dateOfDay.weatherImage = info[5].weather[0].icon
        dateOfDay.weatherByHours = getWeatherByHours(numberOfDay: numberOfDay)
        return dateOfDay
    }
    
    private func getWeatherByHours(numberOfDay: Int) -> [WeatherByHours] {
        var days = [WeatherByHours]()
        let info = getDataByDay(indexOfDay: numberOfDay)
        let countOfHoursInDay = 6
        
        for indexOfTheHour in 0..<countOfHoursInDay {
            let weatherByHour = info[indexOfTheHour + 2]
            var model = WeatherByHours()
            let dtTxt = weatherByHour.dtTxt.split(separator: " ")[1].description.split(separator: ":")[0].description + ":00"
            model.hour = dtTxt
            model.temp = Int(weatherByHour.main.temp).description + "°"
            model.weatherImage = weatherByHour.weather[0].icon
            days.insert(model, at: indexOfTheHour)
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
        networkService.fetchCurrentWeather() { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .succes(value: let value):
                self.weatherData = value.toCurrentWeather()
                self.getInfoByFirstDay()
                self.setUpWeatherOfTheSecondDays()
                self.view.succes(days: self.weatherOfTheDays, title: (value.city.name))
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
