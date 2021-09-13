//
//  MKPinAnnotationView.swift
//  Weather
//
//  Created by Дмитрий  on 13.09.2021.
//
import MapKit
import UIKit

class MKPinAnnotationView: MKAnnotationView {

    let weatherImage: UIImageView = {
        let imageview = UIImageView(frame: .zero)
        imageview.image = #imageLiteral(resourceName: "sun")
        return imageview
    }()
    
    let temperatureLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "00"
        return label
    }()
    
    let feelsLikeLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "00"
        return label
    }()
    
    private func setUpUI() {
        weatherImage.translatesAutoresizingMaskIntoConstraints = false
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        feelsLikeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        weatherImage.contentMode = .scaleAspectFit
        feelsLikeLabel.textAlignment = .right
        
        temperatureLabel.font = UIFont(name: "Manrope-ExtraBold", size: 16)
        feelsLikeLabel.font = UIFont(name: "Manrope-ExtraBold", size: 16)
        
        temperatureLabel.adjustsFontSizeToFitWidth = true
        temperatureLabel.minimumScaleFactor = 0.5
        
        self.addSubview(weatherImage)
        self.addSubview(temperatureLabel)
        self.addSubview(feelsLikeLabel)
        
        NSLayoutConstraint.activate([
            weatherImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 4),
            weatherImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            weatherImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            weatherImage.heightAnchor.constraint(equalToConstant: 40),
            
            temperatureLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 4),
            temperatureLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            temperatureLabel.topAnchor.constraint(equalTo: weatherImage.bottomAnchor, constant: -12),
            
            feelsLikeLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            feelsLikeLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 4),
            feelsLikeLabel.leadingAnchor.constraint(equalTo: temperatureLabel.trailingAnchor, constant: 4),
            feelsLikeLabel.topAnchor.constraint(equalTo: weatherImage.bottomAnchor, constant: -12)
        ])
    }
    
    override init(annotation annotationMy: MKAnnotation?, reuseIdentifier reuseIdentifierMy: String?) {
        super.init(annotation: annotationMy, reuseIdentifier: reuseIdentifierMy)
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
