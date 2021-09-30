//
//  Extension+UIFont.swift
//  Weather
//
//  Created by Дмитрий  on 29.09.2021.
//

import UIKit

extension UIFont {
    
    static func semiBold(size: CGFloat) -> UIFont? {
        let font = UIFont.init(name: "Manrope-SemiBold", size: size)
        return font
    }
    
    static func extraBold(size: CGFloat) -> UIFont? {
        let font = UIFont.init(name: "Manrope-ExtraBold", size: size)
        return font
    }
    
    static func medium(size: CGFloat) -> UIFont? {
        let font = UIFont.init(name: "Manrope-Medium", size: size)
        return font
    }
    
}
