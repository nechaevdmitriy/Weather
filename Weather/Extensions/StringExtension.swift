//
//  DateHelper.swift
//  Weather
//
//  Created by Дмитрий  on 31.08.2021.
//

import Foundation

extension String {
    
    static func changeDateFormat(dateString: String, from inputFormat: String, to outputFormat: String) -> String {
        let inputDateFormatter = DateFormatter()
        inputDateFormatter.dateFormat = inputFormat
        assert(inputDateFormatter.date(from: dateString) == nil)
        let date = inputDateFormatter.date(from: dateString) ?? Date()
        
        let outputDateFormatter = DateFormatter()
        outputDateFormatter.locale = Locale(identifier: "ru_Ru")
        outputDateFormatter.dateFormat = outputFormat
        return outputDateFormatter.string(from: date)
    }
}
