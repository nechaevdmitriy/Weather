//
//  DarkModeBarButtonItem.swift
//  Weather
//
//  Created by Дмитрий  on 11.10.2021.
//

import UIKit

class DarkModeBarButtonItemButton: UIButton {
    
    var backgroundImage: UIImageView = {
        var imgview = UIImageView()
        imgview.image = #imageLiteral(resourceName: "backgroundItemImage")
        imgview.contentMode = .scaleAspectFit
        return imgview
    }()
    
    var iconImage: UIImageView = {
        var imgview = UIImageView()
        imgview.image = #imageLiteral(resourceName: "Loader 1")
        imgview.contentMode = .scaleAspectFit
        return imgview
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createConstraints()
    }
    
    func createConstraints() {
        offAutoresizingMasks(elements: [backgroundImage, iconImage])
        self.addSubview(backgroundImage)
        self.addSubview(iconImage)
        
        backgroundImage.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        backgroundImage.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        backgroundImage.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        backgroundImage.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        iconImage.topAnchor.constraint(equalTo: backgroundImage.topAnchor, constant: 4).isActive = true
        iconImage.bottomAnchor.constraint(equalTo: backgroundImage.bottomAnchor, constant: -4).isActive = true
        iconImage.leadingAnchor.constraint(equalTo: backgroundImage.leadingAnchor, constant: 4).isActive = true
        iconImage.trailingAnchor.constraint(equalTo: backgroundImage.trailingAnchor, constant: -4).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
