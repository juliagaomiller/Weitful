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
    
}

