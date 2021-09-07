//
//  File.swift
//  Weather
//
//  Created by Дмитрий  on 07.09.2021.
//

import Foundation
import Charts

class CustomMarkerView: MarkerView {
    
    @IBOutlet var markerview: UIView!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var minimumTemperatureValue: UILabel!
    @IBOutlet weak var maximumTemperatureValue: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initUI()
    }
    
    private func initUI() {
        Bundle.main.loadNibNamed("ChartPopupView", owner: self, options: nil)
        addSubview(markerview)
        
        minimumTemperatureValue.font = UIFont(name: "Manrope-ExtraBold", size: 16)
        maximumTemperatureValue.font = UIFont(name: "Manrope-ExtraBold", size: 16)
        
        self.frame = CGRect (x: 0, y: 0, width: 76, height: 76)
        self.offset = CGPoint(x: -(self.frame.width/2), y: -self.frame.height)
        markerview.frame = CGRect (x: 0, y: 0, width: 76, height: 76)
        
        markerview.layer.cornerRadius = 8
        markerview.layer.shadowColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
        markerview.layer.shadowOpacity = 0.16
        markerview.layer.shadowOffset = .zero
        markerview.layer.shadowRadius = 10
    }
}

