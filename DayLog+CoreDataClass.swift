//
//  DayLog+CoreDataClass.swift
//  Weitful
//
//  Created by Julia Miller on 11/25/16.
//  Copyright © 2016 Julia Miller. All rights reserved.
//

import Foundation
import CoreData

@objc(DayLog)
public class DayLog: NSManagedObject {
    
    var eatingInt: Int? {
        get { return Int(eating!) }
        set { eating = String(newValue!)}
    }
    
    var exerciseInt: Int? {
        get { return Int(exercise!) }
        set { exercise = String(newValue!)}
    }
    
    var MMdd: String {
        get { return date!.convertToString(format: "MM/dd")}
    }
    
    var MMddyy: String {
        get { return date!.convertToString(format: "MMddyy")}
    }
    
    
    convenience init (weight: String, exercise: String, eating: String, context: NSManagedObjectContext){
        let entity = NSEntityDescription.entity(forEntityName: "DayLog", in: context)!
        self.init(entity: entity, insertInto: context)
        self.date = NSDate()
        self.weight = weight
        self.exercise = exercise
        self.eating = eating

    }

}
