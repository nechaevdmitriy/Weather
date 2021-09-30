//
//  Extension+UIView.swift
//  Weather-2.1
//
//  Created by Дмитрий  on 22.09.2021.
//

import UIKit

extension UIView {
    func offAutoresizingMask<T: UIView>(element: T) {
        element.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func offAutoresizingMasks<T: UIView>(elements: [T]) {
        for component in elements {
            component.translatesAutoresizingMaskIntoConstraints = false
        }
    }
}
