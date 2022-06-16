//
//  CompareFundsViewModel.swift
//  BareksaCompare
//
//  Created by BCA-GSIT-MACBOOK-5 on 15/06/22.
//

import Foundation

final class CompareFundsViewModel: NSObject {
    
    private var apiService: APIService!
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
