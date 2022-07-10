//
//  LineChartPercentFormatter.swift
//  BareksaCompare
//
//  Created by BCA-GSIT-MACBOOK-5 on 10/07/22.
//

import UIKit
import Foundation
import Charts

@objc(LineChartPercentFormatter)
public class LineChartPercentFormatter: NSObject, IAxisValueFormatter{

    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {

        return String(format: "%.0f %%", value)
    }
    
}
