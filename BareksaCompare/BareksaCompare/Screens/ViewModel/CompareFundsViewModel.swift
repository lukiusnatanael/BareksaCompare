//
//  CompareFundsViewModel.swift
//  BareksaCompare
//
//  Created by BCA-GSIT-MACBOOK-5 on 15/06/22.
//

import Foundation
import Charts

final class CompareFundsViewModel: NSObject {
    
    private var apiService: APIService!
    var timeFrameIndex = 2
    var timeFrame = ["1W", "1M", "1Y", "3Y", "5Y", "10Y", "All"]
    var tabBar = ["Imbal Hasil", "Dana Kelolaan"]
    var fundChartData: [[ChartDataEntry]] = []
    var lineChartData: LineChartData = LineChartData()
    
    private(set) var compareChartData: CompareChartData! {
        didSet {
            self.setupChartData()
            self.bindCompareChartDataToController()
        }
    }
    
    private(set) var compareFundsData: CompareFundsData! {
        didSet {
            self.bindCompareFundsDataToController()
        }
    }
    
    var bindCompareChartDataToController : (() -> ()) = {}
    var bindCompareFundsDataToController : (() -> ()) = {}
    
    
    override init() {
        super.init()
        self.apiService = APIService()
//      TODO: Still Failed to Mapping Model with dynamic keys
        doRequestChartData()
        doRequestFundsData()
    }
    
    func doRequestChartData() {
        self.apiService.apiToGetChartData { (chartData) in
            self.compareChartData = chartData
        }
    }
    
    func doRequestFundsData() {
        self.apiService.apiToGetFundsData { (fundsData) in
            self.compareFundsData = fundsData
        }
    }
    
    func setupChartData() {
        prepareDataEntry()
        prepareLineChartData()
    }
    
    private func prepareDataEntry() {
        fundChartData.removeAll()
        for fundData in compareChartData.data {
            var startIndex = 0
            let dataCount = fundData.value.data.count
            switch(timeFrameIndex) {
            case 0:
                startIndex = dataCount > 7 ? dataCount - 7 : 0
            case 1:
                startIndex = dataCount > 30 ? dataCount - 30 : 0
            case 2:
                startIndex = dataCount > 365 ? dataCount - 365 : 0
            case 3:
                startIndex = dataCount > (365 * 3) ? dataCount - (365 * 3) : 0
            case 4:
                startIndex = dataCount > (365 * 5) ? dataCount - (365 * 5) : 0
            case 5:
                startIndex = dataCount > (365 * 10) ? dataCount - (365 * 10) : 0
            default:
                startIndex = 0
            }
            
            var lineData: [ChartDataEntry] = []
            var xPoint = 0.0
            for i in startIndex..<dataCount {
                lineData.append(ChartDataEntry(x: xPoint, y: fundData.value.data[i].growth))
                xPoint += 1.0
            }
            fundChartData.append(lineData)
        }
    }
    
    private func prepareLineChartData() {
        lineChartData = LineChartData()
        var arrayDataSet: [LineChartDataSet] = []
        for i in 0..<fundChartData.count {
            let setFund = LineChartDataSet(entries: fundChartData[i], label: "")
            setFund.drawCirclesEnabled = false
            setFund.mode = .cubicBezier
            setFund.lineWidth = 2
            if i%3 == 0 {
                setFund.setColor(.greenLine)
            } else if i%3 == 1 {
                setFund.setColor(.purpleLine)
            } else {
                setFund.setColor(.navyLine)
            }
            setFund.drawHorizontalHighlightIndicatorEnabled = false
            setFund.drawVerticalHighlightIndicatorEnabled = true
            setFund.highlightColor = .black60
            arrayDataSet.append(setFund)
        }
        
        lineChartData = LineChartData(dataSets: arrayDataSet)
        lineChartData.setDrawValues(false)
    }
    
}
