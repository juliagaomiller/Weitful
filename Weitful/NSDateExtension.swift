//
//  Extensions.swift
//  Weitful
//
//  Created by Julia Miller on 11/24/16.
//  Copyright © 2016 Julia Miller. All rights reserved.
//

import Foundation

extension NSDate {
    
    func convertToString(format: String)->String{
        let formatter = DateFormatter()
        formatter.dateFormat = format
        let day = formatter.string(from: self as Date)
        return day
    }
    
    func returnDayOfWeek(abbreviated: Bool)->String {
        let weekdaysAbr = ["Su", "M", "T", "W", "Th", "F", "S"]
        let weekdays = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
        let cal = Calendar.current
        let index = cal.component(.weekday, from: self as Date)
        if abbreviated {return weekdaysAbr[index-1]}
        else {return weekdays[index-1]}
    }
    
    var dayBefore:NSDate {
        let oneDay: Double = 60 * 60 * 24
        return self.addingTimeInterval(-(Double(oneDay)))
    }
    
}

