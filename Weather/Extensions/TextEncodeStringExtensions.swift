//
//  TextEncodeHelper.swift
//  Weather
//
//  Created by Дмитрий  on 22.09.2021.
//

import Foundation

extension String{
    var encodeUrl : String {
        return self.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
    }
    
    var decodeUrl : String {
        return self.removingPercentEncoding!
    }
}
