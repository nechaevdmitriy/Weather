//
//  Extension+UIView.swift
//  Weather-2.1
//
//  Created by Дмитрий  on 22.09.2021.
//

import UIKit

extension UIView {
    func offAutoresizingMask(element: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func offAutoresizingMasks(elements: [UIView]) {
        for component in elements {
            component.translatesAutoresizingMaskIntoConstraints = false
        }
    }
}
