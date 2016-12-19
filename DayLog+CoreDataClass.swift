//
//  DayLog+CoreDataClass.swift
//  Weitful
//
//  Created by Julia Miller on 11/30/16.
//  Copyright © 2016 Julia Miller. All rights reserved.
//

import Foundation
import CoreData

@objc(DayLog)
public class DayLog: NSManagedObject {
    
    let noData = Int32(-100)
    
    var dateString: String {
        get {
            guard let string = date?.convertToString(format: "MMMM dd, yyyy") else {fatalError()}
            let dayOfWeek = date!.returnDayOfWeek(abbreviated: true)
            let newString = string + " (\(dayOfWeek))"
            return newString
        }
    }
    
    var exercise: Int {
        get {
            return Int(int32exercise)
        }
        set {
            int32exercise = Int32(newValue)
        }
    }
    
    var eating: Int {
        get {
            return Int(int32eating)
        }
        set {
            int32eating = Int32(newValue)
        }
    }
    
    var eatingStringWithPlusSign: String {
        if int32eating == noData {return "~"}
        if eating <= 0 {
            return String(eating)
        } else { return "+ \(eating)"}
    }
    
    var exerciseStringWithPlusSign: String {
        if int32eating == noData {return "~"}
        if exercise <= 0 {
            return String(exercise)
        } else { return "+ \(exercise)"}
    }
    
    
    var eatingString: String {
        if int32eating == noData {
            return "~"
        } else {return String(int32eating)}

    }
    
    var exerciseString: String {
        if int32exercise == noData {
            return "~"
        } else {return String(int32exercise)}
    }
    
    var weightString: String {
        if Int(weight) == Int(noData) {
            return "- - lbs"
        } else {return String(weight) + " lbs"}
    }
    
    var MMdd: String {
        get { return date!.convertToString(format: "MM/dd")}
    }
    
    var MMddyy: String {
        get { return date!.convertToString(format: "MMddyy")}
    }
    
    
    convenience init (context: NSManagedObjectContext){
        let entity = NSEntityDescription.entity(forEntityName: "DayLog", in: context)!
        self.init(entity: entity, insertInto: context)
        self.date = NSDate()
        self.weight = Double(noData)
        self.int32eating = noData
        self.int32exercise = noData
        self.commentary = ""
    }
    
}
