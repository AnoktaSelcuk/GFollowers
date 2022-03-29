    //
//  Date + Ext.swift
//  GFollowers
//
//  Created by Alperen Selçuk on 20.12.2021.
//  Copyright © 2021 Alperen Selçuk. All rights reserved.
//

import Foundation

extension Date {
    
    func convertToMonthYearFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        return dateFormatter.string(from: self)
    }
}
