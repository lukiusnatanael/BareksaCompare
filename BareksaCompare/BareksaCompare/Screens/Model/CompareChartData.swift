//
//  CompareChartData.swift
//  BareksaCompare
//
//  Created by BCA-GSIT-MACBOOK-5 on 16/06/22.
//

import Foundation

struct CompareChartData: Decodable {
    var code: Int
    var message: String
    var error: String
    var data: [String: FundChart]
    var totalData: Int
    
    enum CodingKeys: String, CodingKey {
        case code, message, error, data
        case totalData = "total_data"
    }
}

struct FundChart: Decodable {
    var data: [ChartData]
    var error: String
}

struct ChartData: Decodable {
    var date: String
    var value: Double
    var growth: Double
}
