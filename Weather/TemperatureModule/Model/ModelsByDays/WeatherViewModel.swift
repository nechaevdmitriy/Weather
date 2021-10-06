//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Дмитрий  on 05.10.2021.
//

import Foundation

enum WeatherViewModel {
    case firstDay(value: WeatherOfTheFirstDay)
    case otherDay(value: WeatherOfTheOtherDays)
}
