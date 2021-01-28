//
//  progressCell.swift
//  Wave
//
//  Created by Shyam Kumar on 1/27/21.
//

import UIKit
import Charts

class progressCell: UITableViewCell {
    @IBOutlet weak var lineChartView: LineChartView!
    @IBOutlet weak var backView: UIView!
    
    override func awakeFromNib() {
        lineChartView.isUserInteractionEnabled = false
        
        setData()
        
        lineChartView.xAxis.drawGridLinesEnabled = false
        lineChartView.xAxis.drawAxisLineEnabled = false
        lineChartView.chartDescription?.enabled = false
        lineChartView.xAxis.drawLabelsEnabled = false
        lineChartView.rightAxis.enabled = false
        lineChartView.leftAxis.enabled = false
        lineChartView.drawBordersEnabled = false
        lineChartView.legend.form = .none
        lineChartView.marker = nil
        
        backView.layer.cornerRadius = 5
        backView.backgroundColor = .white
        backView.layer.shadowColor = UIColor.black.cgColor
        backView.layer.shadowOpacity = 0.2
        backView.layer.shadowOffset = .zero
        backView.layer.shadowRadius = 1
    }
    
    let yValues = [
        ChartDataEntry(x: 0, y: 0),
        ChartDataEntry(x: 1, y: 1),
        ChartDataEntry(x: 2, y: 4),
        ChartDataEntry(x: 3, y: 9),
        ChartDataEntry(x: 4, y: 2),
        ChartDataEntry(x: 5, y: 3)
    ]
    
    func setData() {
        let set1 = LineChartDataSet(entries: yValues)
        set1.mode = .cubicBezier
        set1.drawCirclesEnabled = false
        set1.label = ""
        set1.colors = [Colors.green]
        
        let data = LineChartData(dataSet: set1)
        data.setDrawValues(false)
        
        lineChartView.data = data
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
