//
//  Observation+CoreDataClass.swift
//  Weitful
//
//  Created by Julia Miller on 12/12/16.
//  Copyright © 2016 Julia Miller. All rights reserved.
//

import Foundation
import CoreData
import UIKit

public class Observation: NSManagedObject {
    
    var rank: Int {
        get {return Int(int32rank)}
        set {int32rank = Int32(newValue)}
    }
    
    var type: Type {
        get {
            guard let t = Type(rawValue: privateType!)
                else {fatalError()}
            return t
        }
        set {
            privateType = newValue.rawValue
        }
    }
    
    var color: UIColor {
        get {
            switch(self.type, self.isPositive){
            case (.neither, true): return Color.lightYellow
            case (.neither, false): return Color.darkYellow
            case (.eating, true): return Color.lightBrown
            case (.eating, false): return Color.darkBrown
            case (.exercise, true): return Color.lightBlue
            case (.exercise, false): return Color.darkBlue
                //            default: fatalError()
            }
        }
    }
    
    convenience init (text: String, type: Type, isPositive: Bool, context: NSManagedObjectContext){
        let entity = NSEntityDescription.entity(forEntityName: "Observation", in: context)!
        self.init(entity: entity, insertInto: context)
        self.date = NSDate()
        self.int32rank = 0 //placeholder
        self.privateType = "EATING" //placeholder
        self.text = text
        self.type = type
        self.isPositive = isPositive
    }
    
}
