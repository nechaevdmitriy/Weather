//
//  Extension + TemperatureViewController.swift
//  Weather
//
//  Created by Дмитрий  on 21.10.2021.
//

import UIKit

extension TemperatureViewController {
    func createBottomImage() -> UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "bottomBlur")
        imageView.alpha = 0.8
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        return imageView
    }
}
