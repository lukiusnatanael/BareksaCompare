//
//  LineChartFormatter.swift
//  BareksaCompare
//
//  Created by BCA-GSIT-MACBOOK-5 on 10/07/22.
//

import UIKit
import Foundation
import Charts

extension LineChartView {
    
    private class LineChartFormatter: NSObject, IAxisValueFormatter {
        var labels: [String] = []
                
        func stringForValue(_ value: Double, axis: AxisBase?) -> String {
            return labels[Int(value)]
        }
        
        init(labels: [String]) {
            super.init()
            self.labels = labels
        }
    }
    
    func setLineChartData(xValues: [[String]], dataEntries: [[ChartDataEntry]], label: String) {
            
        var arrayDataSet: [LineChartDataSet] = []
        for i in 0..<dataEntries.count {
            let chartDataSet = LineChartDataSet(entries: dataEntries[i], label: "")
            chartDataSet.drawCirclesEnabled = false
            chartDataSet.mode = .cubicBezier
            chartDataSet.lineWidth = 2
            if i%3 == 0 {
                chartDataSet.setColor(.greenLine)
            } else if i%3 == 1 {
                chartDataSet.setColor(.purpleLine)
            } else {
                chartDataSet.setColor(.navyLine)
            }
            chartDataSet.drawHorizontalHighlightIndicatorEnabled = false
            chartDataSet.drawVerticalHighlightIndicatorEnabled = true
            chartDataSet.highlightColor = .black10
            chartDataSet.valueTextColor = .clear
            arrayDataSet.append(chartDataSet)
        }
        
        let chartData = LineChartData(dataSets: arrayDataSet)
        
        let chartFormatter = LineChartFormatter(labels: xValues.first ?? [])
        let xAxis = XAxis()
        xAxis.valueFormatter = chartFormatter
        self.xAxis.valueFormatter = xAxis.valueFormatter
        
        self.data = chartData
    }

}
