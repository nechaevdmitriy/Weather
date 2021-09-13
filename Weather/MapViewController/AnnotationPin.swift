//
//  AnnotationPin.swift
//  Weather
//
//  Created by Дмитрий  on 10.09.2021.
//

import Foundation
import MapKit

class AnnotationPin:  NSObject, MKAnnotation {
    var title: String?
    var subtitle: String?
    var coordinate: CLLocationCoordinate2D
    var pin: AnnotationPin!
    
    init(title: String, subtitle: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
    }
}
