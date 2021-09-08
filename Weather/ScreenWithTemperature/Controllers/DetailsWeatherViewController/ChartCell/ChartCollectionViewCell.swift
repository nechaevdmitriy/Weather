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
    private let dates = ["00:00", "03:00", "06:00", "09:00", "12:00", "15:00", "18:00", "21:00"]
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
    var presenter: TemperaturePresenterProtocol!
    
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
        for i in 0...presenter.countOfElementsInCurrentDay - 1 {
            guard presenter.getDataByDayAndHour(indexOfDay: 0, indexOfHour: i) != nil else {
                return
            }
            currentValues.append(Int(presenter.getDataByDayAndHour(indexOfDay: 0, indexOfHour: i)?.main.temp ?? 0))
            feelsLike.append(Int(presenter.getDataByDayAndHour(indexOfDay: 0, indexOfHour: i)?.main.feelsLike ?? 0))
            weatherDescriptions.append(presenter.getDataByDayAndHour(indexOfDay: 0, indexOfHour: i)?.weather[0].weatherDescription ?? "Not Found")
            entries.append(ChartDataEntry(x: Double(i), y: Double(currentValues[i] ?? 0)))
        }
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
        
        for i in 0..<presenter.countOfElementsInCurrentDay {
            hoursLabels.first?.isHidden = true
            gradientImages.first?.isHidden = true
            hoursLabels[i + 1].text = dates[i + 4]
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
        
        if entry.x >= 0 && Int(entry.x) < presenter.countOfElementsInCurrentDay - 1 {
            gradientImages[Int(entry.x + 1)].alpha = 1
            gradientImages[Int(entry.x)].alpha = 0
            gradientImages[Int(entry.x + 2)].alpha = 0
            
        } else if Int(entry.x) == presenter.countOfElementsInCurrentDay - 1 {
            gradientImages[Int(entry.x + 1)].alpha = 1
            gradientImages[Int(entry.x)].alpha = 0
        }
        
        customMarkerView.maximumTemperatureValue.text = Int(entry.y).description
        customMarkerView.minimumTemperatureValue.text = feelsLike[Int(entry.x + 1), default: 0]?.description
        
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
