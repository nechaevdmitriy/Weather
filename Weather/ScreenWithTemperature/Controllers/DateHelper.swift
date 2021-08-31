//
//  DateHelper.swift
//  Weather
//
//  Created by Дмитрий  on 31.08.2021.
//

import Foundation

class HelperDate {

static func changeDateFormat(dateString: String, fromFormat: String, toFormat: String) ->String {
    let inputDateFormatter = DateFormatter()
    inputDateFormatter.dateFormat = fromFormat
    let date = inputDateFormatter.date(from: dateString)

    let outputDateFormatter = DateFormatter()
    outputDateFormatter.locale = Locale(identifier: "ru_Ru")
    outputDateFormatter.dateFormat = toFormat
    return outputDateFormatter.string(from: date!)
}
}