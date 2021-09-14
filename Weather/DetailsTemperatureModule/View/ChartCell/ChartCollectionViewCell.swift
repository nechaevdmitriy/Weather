//
//  ChartCollectionViewCell.swift
//  Weather
//
//  Created by Дмитрий  on 06.09.2021.
//

import Charts
import UIKit

class ChartCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Static properties
    static let id = "ChartCollectionViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "ChartCollectionViewCell", bundle: nil)
    }
    
    //MARK: - Private properties
    private let dates = ["00:00", "03:00", "06:00", "09:00", "12:00", "15:00", "18:00", "21:00", "00:00"]
    private let chart = LineChartView()
    private var customMarkerView = CustomMarkerView()
    private var entries = [ChartDataEntry]()
    
    private var currentValues = [Int?]()
    private var feelsLike = [Int?]()
    private var weatherDescriptions = [String?]()
    
    //MARK: - Public properties
    @IBOutlet weak var gradientImage: UIImageView!
    @IBOutlet var hoursLabels: [UILabel]!
    @IBOutlet var gradientImages: [UIImageView]!
    var presenter: DetailsWeatherViewPresenter!
    
    //MARK: - Override methods
    override func awakeFromNib() {
        super.awakeFromNib()
        chart.delegate = self
    }
    
    override func layoutSubviews() {
        updateData()
        setCharts()
    }
    
    //MARK: - Private funcs
    private func updateData() {
        
        for i in 0..<presenter.countOfElementsInCurrentDay {
            guard presenter.showWeather()?.list[i] != nil else {
                return
            }
            
            currentValues.append(Int(presenter.showWeather()?.list[i].main.temp ?? 0))
            feelsLike.append(Int(presenter.showWeather()?.list[i].main.feelsLike ?? 0))
            weatherDescriptions.append(presenter.showWeather()?.list[i].weather[0].weatherDescription ?? "Not Found")
            entries.append(ChartDataEntry(x: Double(i), y: Double(currentValues[i] ?? 0)))
        }
        entries.append(ChartDataEntry(x: Double(presenter.countOfElementsInCurrentDay - 1), y: 50))
    }
    
    private func configureImages() {
        for i in 0..<5 {
            gradientImages[i].alpha = 0
        }
    }
    
    private func setCharts() {
        let marker = CircleMarker(color: #colorLiteral(red: 0, green: 0.6453513503, blue: 1, alpha: 1))
        let set = LineChartDataSet(entries: entries)
        let data = LineChartData(dataSet: set)
        
        chart.marker = marker
        chart.frame = CGRect(x: 0, y: 0, width: contentView.bounds.width - 40, height: contentView.bounds.height - 40 )
        chart.center = contentView.center
        chart.rightAxis.enabled = false
        chart.xAxis.enabled = false
        chart.leftAxis.enabled = false
        chart.animate(xAxisDuration: 0.4)
        chart.legend.enabled = false
        chart.setScaleEnabled(false)
        chart.dragXEnabled = false
        chart.dragYEnabled = false
        chart.pinchZoomEnabled = false
        chart.data = data
        chart.dragEnabled = false
        chart.scaleXEnabled = false
        chart.scaleYEnabled = false
        
        set.accessibilityElementsHidden = false
        set.colors = [#colorLiteral(red: 0, green: 0.6453513503, blue: 1, alpha: 1)]
        set.circleColors = [#colorLiteral(red: 0, green: 0.6453513503, blue: 1, alpha: 1)]
        set.mode = .cubicBezier
        set.lineWidth = 3
        set.drawVerticalHighlightIndicatorEnabled = false
        set.drawHorizontalHighlightIndicatorEnabled = false
        set.circleHoleColor = UIColor(named: "backgroundApp")
        
        data.setDrawValues(false)
        
        customMarkerView.chartView = chart
        chart.marker = customMarkerView
        
        for i in 0..<5 {
            hoursLabels[i].isHidden = true
            gradientImages[i].isHidden = true
        }
        
        for i in 0..<presenter.countOfElementsInCurrentDay  {
            hoursLabels[i].isHidden = false
            gradientImages[i].isHidden = false
            hoursLabels[i].text = dates[8 - presenter.countOfElementsInCurrentDay + i]
        }
        
        contentView.addSubview(chart)
        contentView.addSubview(gradientImage)
        
        configureImages()
    }
}

//MARK: - Extensions
extension ChartCollectionViewCell: ChartViewDelegate {
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        let currentWeather = weatherDescriptions[Int(entry.x + 1), default: "not found"]
        
        for i in 0..<5 {
            gradientImages[i].alpha = 0
        }
        
        gradientImages[Int(entry.x)].alpha = 1
        
        customMarkerView.maximumTemperatureValue.text = Int(entry.y).description
        customMarkerView.minimumTemperatureValue.text = feelsLike[Int(entry.x), default: 0]?.description
        
        switch currentWeather {
        case "дождь", "небольшой дождь":
            customMarkerView.weatherImage.image = #imageLiteral(resourceName: "Rain")
        case "гроза":
            customMarkerView.weatherImage.image = #imageLiteral(resourceName: "Thunder")
        default:
            customMarkerView.weatherImage.image = #imageLiteral(resourceName: "sun")
        }
    }
}

//MARK: - Global extensions
extension Array {
    public subscript(index: Int, default defaultValue: @autoclosure () -> Element) -> Element {
        guard index >= 0, index < endIndex else {
            return defaultValue()
        }
        return self[index]
    }
}
