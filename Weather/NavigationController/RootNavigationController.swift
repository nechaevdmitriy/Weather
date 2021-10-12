//
//  RootNavigationController.swift
//  Weather
//
//  Created by Дмитрий  on 12.10.2021.
//

import UIKit

class RootNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        setUpNavBar()
    }
    
    private func setUpNavBar() {
        self.navigationBar.barTintColor = UIColor(named: "background")
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.extraBold(size: 18)!]
        self.navigationBar.shadowImage = UIImage()
    }
}
