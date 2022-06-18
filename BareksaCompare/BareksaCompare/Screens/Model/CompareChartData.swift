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
    var data: FundChart
    var totalData: Int
    
    enum CodingKeys: String, CodingKey {
        case code, message, error
        case data = "data"
        case totalData = "total_data"
    }
}

struct FundChart: Decodable {
    var category: String
    var data: [ChartData]
    var error: String
    
    enum CodingKeys: CodingKey {
        case data, error
    }
    
    init(from decoder: Decoder) throws {

        let container = try decoder.container(keyedBy: CodingKeys.self)

        data = try container.decode([ChartData].self, forKey: CodingKeys.data)
        error = try container.decode(String.self, forKey: CodingKeys.error)
        category = container.codingPath.first!.stringValue
    }
}

struct ChartData: Decodable {
    var date: String
    var value: Double
    var growth: Double
    
    enum CodingKeys: String, CodingKey {
        case date, value, growth
    }
}
