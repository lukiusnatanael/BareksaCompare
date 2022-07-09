//
//  APIService.swift
//  BareksaCompare
//
//  Created by BCA-GSIT-MACBOOK-5 on 16/06/22.
//

import Foundation

class APIService: NSObject {
    
    private let chartURL = URL(string: "https://ae1cdb19-2532-46fa-9b8f-cce01702bb1e.mock.pstmn.io/takehometest/apps/compare/chart?productCodes=KI002MMCDANCAS00&productCodes=TP002EQCEQTCRS00&productCodes=NI002EQCDANSIE00")!
    
    private let fundsURL = URL(string: "https://ae1cdb19-2532-46fa-9b8f-cce01702bb1e.mock.pstmn.io/takehometest/apps/compare/detail?productCodes=KI002MMCDANCAS00&productCodes=TP002EQCEQTCRS00&productCodes=NI002EQCDANSIE00")!
    
    func apiToGetChartData(completion : @escaping (CompareChartData) -> ()) {
        
        URLSession.shared.dataTask(with: chartURL) { (data, urlResponse, error) in
            if let data = data {
                
                let jsonDecoder = JSONDecoder()
                
                let chartData = try! jsonDecoder.decode(CompareChartData.self, from: data)
                completion(chartData)
            }
        }.resume()
        
    }
    
    func apiToGetFundsData(completion : @escaping (CompareFundsData) -> ()) {
        
        URLSession.shared.dataTask(with: fundsURL) { (data, urlResponse, error) in
            if let data = data {
                
                let jsonDecoder = JSONDecoder()
                
                let fundsData = try! jsonDecoder.decode(CompareFundsData.self, from: data)
                completion(fundsData)
            }
        }.resume()
        
    }
    
}
