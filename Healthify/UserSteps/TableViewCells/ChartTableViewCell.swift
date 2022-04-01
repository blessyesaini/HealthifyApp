//
//  ChartTableViewCell.swift
//  Healthify
//
//  Created by Blessy Elizabeth Saini on 26/03/2022.
//

import UIKit
import Charts

struct ChartTableViewCellModel {
    var xValues: [Date]?
    var yValues: [Double]?
}
class ChartTableViewCell: UITableViewCell {

    @IBOutlet weak var lineChartView: LineChartView!
   
    var data: ChartTableViewCellModel? {
        didSet {
            loadData()
        }
    }
    static let reuseIdentifier = "ChartTableViewCell"
    
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    //MARK: - Custom Methods
    
    func loadData() {
        if let xValues = data?.xValues, let yValues = data?.yValues {
            // Set the x values date formatter
            setChart(x: xValues.map({ $0.get(.day)
            }), y: yValues)
        }
    }
    /// Method to display chart data in view
    /// - Parameter dataSet: dataSet contains the required data functions to set the data as per the requirement
    fileprivate func setChartData(_ dataSet: LineChartDataSet) {
        dataSet.setCircleColor(.clear)
        dataSet.drawCirclesEnabled = false
        dataSet.drawValuesEnabled = false
        dataSet.mode = .cubicBezier
        dataSet.cubicIntensity = 0.2
        dataSet.lineWidth = 3
        lineChartView.drawGridBackgroundEnabled = false
        let data = LineChartData(dataSet: dataSet)
        self.lineChartView.drawGridBackgroundEnabled = true
        lineChartView.leftAxis.drawAxisLineEnabled = false
        lineChartView.leftAxis.drawGridLinesEnabled = false
        lineChartView.leftAxis.drawLabelsEnabled = false
        lineChartView.legend.enabled = false
        lineChartView.leftAxis.gridColor = NSUIColor.clear
        lineChartView.xAxis.drawGridLinesEnabled = false
        lineChartView.xAxis.labelTextColor = .white
        lineChartView.rightAxis.labelTextColor = .white
        lineChartView.xAxis.labelPosition = .bottom
        let xAxis = lineChartView.xAxis
        xAxis.labelPosition = .bottom
        lineChartView.backgroundColor = .black
        lineChartView.translatesAutoresizingMaskIntoConstraints = false
        self.lineChartView.gridBackgroundColor = .black
        self.lineChartView.data = data
    }
    
    /// Set the required x and y values to  display in chart
    /// - Parameters:
    ///   - x: x values which represent the days of month
    ///   - y: y vaules which contains the number of steps in the month
    func setChart(x: [Int], y: [Double]) {
        var values = [ChartDataEntry]()
        values.append(ChartDataEntry(x:0, y: 0))
        for i in 0 ..< x.count {
            let value = ChartDataEntry(x:Double(x[Int(i)]), y: Double(y[Int(i)]))
            values.append(value)
           
        }
        let dataSet = LineChartDataSet(entries: values, label: "")
        setChartData(dataSet)
   
        }
 
    
}
