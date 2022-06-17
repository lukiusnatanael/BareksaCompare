//
//  CompareFundsData.swift
//  BareksaCompare
//
//  Created by BCA-GSIT-MACBOOK-5 on 16/06/22.
//

import Foundation

struct CompareFundsData: Decodable {
    var code: Int
    var message: String
    var error: String
    var data: [FundData]
    
    enum CodingKeys: String, CodingKey {
        case code, message, error, data
    }
}

struct FundData: Decodable {
    var code: String
    var name: String
    var details: FundDetail
    
    enum CodingKeys: String, CodingKey {
        case code, name, details
    }
}

struct FundDetail: Decodable {
    var category: String
    var categoryId: Int
    var currency: String
    var custody: String
    var inceptionDate: String
    var imageAvatar: String
    var imageName: String
    var minBalance: Double
    var minRedemption: Double
    var minSubscription: Double
    var nav: Double
    var returnCurYear: Double
    var returnOneDay: Double
    var returnOneWeek: Double
    var returnOneMonth: Double
    var returnThreeMonth: Double
    var returnSixMonth: Double
    var returnOneYear: Double
    var returnTwoYear: Double
    var returnThreeYear: Double
    var returnFourYear: Double
    var returnFiveYear: Double
    var returnInceptionGrowth: Double
    var totalUnit: Double
    var type: String
    var typeId: Int
    
    enum CodingKeys: String, CodingKey {
        case category, currency, custody, nav, type
        case categoryId = "category_id"
        case inceptionDate = "inception_date"
        case imageAvatar = "im_avatar"
        case imageName = "im_name"
        case minBalance = "min_balance"
        case minRedemption = "min_redemption"
        case minSubscription = "min_subscription"
        case returnCurYear = "return_cur_year"
        case returnOneDay = "return_one_day"
        case returnOneWeek = "return_one_week"
        case returnOneMonth = "return_one_month"
        case returnThreeMonth = "return_three_month"
        case returnSixMonth = "return_six_month"
        case returnOneYear = "return_one_year"
        case returnTwoYear = "return_two_year"
        case returnThreeYear = "return_three_year"
        case returnFourYear = "return_four_year"
        case returnFiveYear = "return_five_year"
        case returnInceptionGrowth = "return_inception_growth"
        case totalUnit = "total_unit"
        case typeId = "type_id"
    }
    
    func getReturnString() -> String {
        if self.type == "Pasar Uang" {
            return String(format: "%.2f", self.returnOneYear) + "% / thn"
        } else if self.type == "Pendapatan Tetap" || self.type == "Campuran" {
            return String(format: "%.2f", self.returnThreeYear) + "% / 3 thn"
        } else if self.type == "Saham" {
            return String(format: "%.2f", self.returnFiveYear) + "% / 5 thn"
        } else {
            return ""
        }
    }
    
    func getAumString() -> String {
        let aumValue = self.totalUnit * self.nav
        return String(format: "%.2f %@", getAmountDecimal(value: aumValue), getAmountPostfix(value: aumValue))
    }
    
    func getMinSubscriptionString() -> String {
        return String(format: "%.0f %@", getAmountDecimal(value: self.minSubscription), getAmountPostfix(value: self.minSubscription))
    }
    
    func getTermString() -> String {
        if self.type == "Pasar Uang" {
            return "1 Tahun"
        } else if self.type == "Pendapatan Tetap" || self.type == "Campuran" {
            return "3 Tahun"
        } else if self.type == "Saham" {
            return "5 Tahun"
        } else {
            return ""
        }
    }
    
    func getRiskString() -> String {
        if self.type == "Pasar Uang" {
            return "Rendah"
        } else if self.type == "Pendapatan Tetap" || self.type == "Campuran" {
            return "Sedang"
        } else if self.type == "Saham" {
            return "Tinggi"
        } else {
            return ""
        }
    }
    
    func getInceptionDate() -> String {
        let dateArray = self.inceptionDate.split(separator: "-")
        return dateArray[2] + " " + convertMonthToString(value: String(dateArray[1])) + " " + dateArray[0]
    }
    
    private func getAmountDecimal(value: Double) -> Double {
        if value >= 0 && value < 1000 {
            return value
        } else if value >= 1000 && value < 1000000 {
            return value / 1000
        } else if value >= 1000000 && value < 1000000000 {
            return value / 1000000
        } else if value >= 1000000000 && value < 1000000000000 {
            return value / 1000000000
        } else if value >= 1000000000000 {
            return value / 1000000000000
        } else {
            return value
        }
    }
    
    private func getAmountPostfix(value: Double) -> String {
        if value >= 0 && value < 1000 {
            return ""
        } else if value >= 1000 && value < 1000000 {
            return "Ribu"
        } else if value >= 1000000 && value < 1000000000 {
            return "Juta"
        } else if value >= 1000000000 && value < 1000000000000 {
            return "Miliar"
        } else if value >= 1000000000000 {
            return "Triliun"
        } else {
            return ""
        }
    }
    
    private func convertMonthToString(value: String) -> String {
        switch value {
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
