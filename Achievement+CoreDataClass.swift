//
//  Achievement+CoreDataClass.swift
//  Weitful
//
//  Created by Julia Miller on 1/4/17.
//  Copyright © 2017 Julia Miller. All rights reserved.
//

import Foundation
import CoreData
import UIKit

let exercise = "exercise"
let eating = "eating"


public class Achievement: NSManagedObject {
    
    var numOfTimesAchievedInt: Int {
        get {
            return Int(numOfTimesAchievedString!)!
        }
        set {
            numOfTimesAchievedString = String(newValue)
        }
    }
    
    var numOfDays: Int {
        get {
            return Int(int32numOfDays)
        }
        set {
            int32numOfDays = Int32(newValue)
        }
    }
    
    var intensityLevel: Int {
        get {
            return Int(int32intensityLevel)
        }
        set {
            int32intensityLevel = Int32(newValue)
        }
    }
    
    convenience init(type: String, image: NSData, title: String, detail: String, numOfDays: Int, intensityLevel: Int, context: NSManagedObjectContext){
        let entity = NSEntityDescription.entity(forEntityName: "Achievement", in: context)!
        self.init(entity: entity, insertInto: context)
        self.date = NSDate()
        self.image = image
        self.numOfTimesAchievedInt = 0
        self.achieved = false
        self.type = type
        self.title = title
        self.detail = detail
        self.numOfDays = numOfDays
        self.intensityLevel = intensityLevel
    }
    
}
