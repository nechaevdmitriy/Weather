//
//  UIImageViewExtension.swift
//  Weather
//
//  Created by Дмитрий  on 11.10.2021.
//

import UIKit

extension UIImageView {
  func setImageColor(color: UIColor) {
    let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
    self.image = templateImage
    self.tintColor = color
  }
}
