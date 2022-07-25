//
//  DateFormet.swift
//  EVTCustomer
//
//  Created by Apple on 26/08/21.
//

import UIKit


class DateFormet: NSObject {
    
    static let monthDateYearFormat  = "MMM dd, yyyy"
    static let yearMonthDate = "yyyy-MM-dd"

    
    static func formattedDateFromString(dateString: String, withFormat outFormat: String, inFormat: String = DateFormet.yearMonthDate) -> String? {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = inFormat
        
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = outFormat
            return dateFormatter.string(from: date)
        }
        return nil
    }
}

