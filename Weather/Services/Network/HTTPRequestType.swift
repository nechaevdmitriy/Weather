//
//  HTTPRequestType.swift
//  Weather
//
//  Created by Дмитрий  on 30.09.2021.
//

import Foundation
import CoreLocation

enum HTTPRequestType {
    case city(city: String)
    case coordinates(latitude: CLLocationDegrees, longitude: CLLocationDegrees)
}
