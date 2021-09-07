//
//  CircleMarker.swift
//  Weather
//
//  Created by Дмитрий  on 07.09.2021.
//
import Charts
import Foundation

class CircleMarker: MarkerImage {
    
    var color: UIColor
    var radius: CGFloat = 4
    
    init(color: UIColor) {
        self.color = color
        super.init()
    }
    
    override func draw(context: CGContext, point: CGPoint) {
        let circleRect = CGRect(x: point.x - radius, y: point.y - radius, width: radius * 2, height: radius * 2)
        
        context.setFillColor(color.cgColor)
        context.fillEllipse(in: circleRect)
        context.restoreGState()
    }
}
