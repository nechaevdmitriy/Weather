//
//  ChartCollectionViewCell.swift
//  Weather
//
//  Created by Дмитрий  on 06.09.2021.
//
import Charts
import UIKit

class ChartCollectionViewCell: UICollectionViewCell {
    
    static let id = "ChartCollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "ChartCollectionViewCell", bundle: nil)
    }
    
    @IBOutlet weak var gradientImage: UIImageView!
    
    let chart = LineChartView()
    var customMarkerView = CustomMarkerView()
    var currentValues = [Int?]()
    var feelsLike = [Int?]()
    var weatherDescriptions = [String?]()
    var presenter: TemperaturePresenterProtocol!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        chart.delegate = self
    }
    
    
    private func updateData() {
        
        for i in 0...1 {
            
            guard presenter.getDataByDayAndHour(indexOfDay: 0, indexOfHour: i) != nil else {
                return
            }
            
            currentValues.append(Int(presenter.getDataByDayAndHour(indexOfDay: 0, indexOfHour: i)?.main.temp ?? 0))
            feelsLike.append(Int(presenter.getDataByDayAndHour(indexOfDay: 0, indexOfHour: i)?.main.feelsLike ?? 0))
            weatherDescriptions.append(presenter.getDataByDayAndHour(indexOfDay: 0, indexOfHour: i)?.weather[0].weatherDescription ?? "Not Found")
        }
    }
    
    override func layoutSubviews() {
        updateData()
        
        let marker = CircleMarker(color: #colorLiteral(red: 0, green: 0.6453513503, blue: 1, alpha: 1))
        chart.marker = marker
        
        customMarkerView.center.y = marker.offset.y
        
        chart.frame = CGRect(x: 0, y: 0, width: contentView.bounds.width, height: contentView.bounds.height)
        
        chart.rightAxis.enabled = false
        chart.xAxis.enabled = false
        chart.leftAxis.enabled = false
        
        chart.animate(xAxisDuration: 0.4)
        
        let set = LineChartDataSet(entries: [
            ChartDataEntry(x: 0, y: Double((currentValues.first ?? 0) ?? 0)),
            ChartDataEntry(x: 1, y: Double(currentValues[1, default: 0] ?? 0)),
            ChartDataEntry(x: 2, y: Double(currentValues[2, default: 0] ?? 0)),
            ChartDataEntry(x: 3, y: Double(currentValues[3, default: 0] ?? 0)),
            ChartDataEntry(x: 4, y: Double(currentValues[4, default: 0] ?? 0)),
            ChartDataEntry(x: 4, y: 50)
        ])
        
        set.colors = [#colorLiteral(red: 0, green: 0.6453513503, blue: 1, alpha: 1)]
        set.circleColors = [#colorLiteral(red: 0, green: 0.6453513503, blue: 1, alpha: 1)]
        
        set.mode = .cubicBezier
        set.lineWidth = 3
        
        set.drawVerticalHighlightIndicatorEnabled = false
        set.drawHorizontalHighlightIndicatorEnabled = false
        set.circleHoleColor = UIColor(named: "darkBackgroundCellGray")
        
        let data = LineChartData(dataSet: set)
        data.setDrawValues(false)
        
        chart.data = data
        chart.setScaleEnabled(false)
        
        customMarkerView.chartView = chart
        chart.marker = customMarkerView
        
        contentView.addSubview(chart)
        contentView.addSubview(gradientImage)
    }
}

extension Array {
    public subscript(index: Int, default defaultValue: @autoclosure () -> Element) -> Element {
        guard index >= 0, index < endIndex else {
            return defaultValue()
        }
        return self[index]
    }
}

extension ChartCollectionViewCell: ChartViewDelegate {
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        customMarkerView.maximumTemperatureValue.text = Int(entry.y).description
        customMarkerView.minimumTemperatureValue.text = feelsLike[Int(entry.x + 1), default: 0]?.description
        let currentWeather = weatherDescriptions[Int(entry.x + 1), default: "not found"]
        
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
