//
//  CompareFundsViewModel.swift
//  BareksaCompare
//
//  Created by BCA-GSIT-MACBOOK-5 on 15/06/22.
//

import Foundation

final class CompareFundsViewModel: NSObject {
    
    private var apiService: APIService!
    var timeFrame = ["1W", "1M", "1Y", "3Y", "5Y", "10Y", "All"]
    var tabBar = ["Imbal Hasil", "Dana Kelolaan"]
    private(set) var compareChartData: CompareChartData! {
        didSet {
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
    
}
