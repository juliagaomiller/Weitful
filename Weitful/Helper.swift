//
//  Helper.swift
//  Weitful
//
//  Created by Julia Miller on 11/30/16.
//  Copyright © 2016 Julia Miller. All rights reserved.
//

import Foundation
import UIKit


enum Type: String {
    case neither = "NEITHER"
    case exercise = "EXERCISE"
    case eating = "EATING"
}

struct segueID {
    static let newObservationVC = "NewObservationVC"
    static let observationVC = "ObservationVC"
    static let instructionsVC = "InstructionsVC"
}

struct Color {
    static let darkBrown = UIColor(red:0.69, green:0.53, blue:0.32, alpha:1.0)
    static let lightBrown = UIColor(red:0.84, green:0.73, blue:0.60, alpha:1.0)
    static let darkBlue = UIColor(red:0.48, green:0.66, blue:0.85, alpha:1.0)
    static let lightBlue = UIColor(red:0.76, green:0.82, blue:0.89, alpha:1.0)
    static let darkYellow = UIColor(red:0.93, green:0.84, blue:0.44, alpha:1.0)
    static let lightYellow = UIColor(red:0.95, green:0.94, blue:0.67, alpha:1.0)
}

class H {
    static func calculateProgress(now: Double, before: Double)->String{
        if now == 0 || before == 0 {
            return ""
        }
        var difference = now - before
        difference = (round(10*difference)/10)
        var string = ""
        if difference > 0 {
            string = "+"
        }
        string = string + String(difference)
        print(string)
        return string
    }
}
