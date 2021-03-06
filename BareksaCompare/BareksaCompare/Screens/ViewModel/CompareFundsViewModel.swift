//
//  CompareFundsViewModel.swift
//  BareksaCompare
//
//  Created by BCA-GSIT-MACBOOK-5 on 15/06/22.
//

import Foundation
import Charts
import SwiftUI

final class CompareFundsViewModel: NSObject {
    
    private var apiService: APIService!
    var timeFrameIndex = 2
    var timeFrame = ["1W", "1M", "1Y", "3Y", "5Y", "10Y", "All"]
    var tabBar = ["Imbal Hasil", "Dana Kelolaan"]
    var arrayTime: [[String]] = []
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
        fundChartData.removeAll()
        arrayTime.removeAll()
        
        for fundData in compareChartData.data {
            var startIndex = 0
            let dataCount = fundData.value.data.count
            switch(timeFrameIndex) { //asumsi tanggal kalendar bukan hari kerja
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
            var arrTime: [String] = []
            var xPoint = 0.0
            for i in startIndex..<dataCount {
                lineData.append(ChartDataEntry(x: xPoint, y: fundData.value.data[i].growth))
                arrTime.append(formatStringToDate(value: fundData.value.data[i].date))
                xPoint += 1.0
            }
            arrayTime.append(arrTime)
            fundChartData.append(lineData)
        }
    }
    
    func formatStringToDate(value: String) -> String {
        let arrDate = value.components(separatedBy: "-")
        let year = arrDate[0].suffix(2)
        let month = arrDate[1]
        let day = arrDate[2]
        
        switch(timeFrameIndex) {
        case 0:
            return day + " " + formatMonthToString(month)
        case 1:
            return day + " " + formatMonthToString(month)
        case 2:
            return formatMonthToString(month) + " " + year
        case 3:
            return formatMonthToString(month) + " " + year
        case 4:
            return formatMonthToString(month) + " " + year
        case 5:
            return formatMonthToString(month) + " " + year
        default:
            return formatMonthToString(month) + " " + year
        }
    }
    
    func formatMonthToString(_ value: String) -> String {
        switch(value) {
        case "01":
            return "Jan"
        case "02":
            return "Feb"
        case "03":
            return "Mar"
        case "04":
            return "Apr"
        case "05":
            return "Mei"
        case "06":
            return "Jun"
        case "07":
            return "Jul"
        case "08":
            return "Agu"
        case "09":
            return "Sep"
        case "10":
            return "Okt"
        case "11":
            return "Nov"
        case "12":
            return "Des"
        default:
            return ""
        }
    }
}
