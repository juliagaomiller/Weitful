//
//  Observation+CoreDataClass.swift
//  Weitful
//
//  Created by Julia Miller on 12/15/16.
//  Copyright © 2016 Julia Miller. All rights reserved.
//

import Foundation
import CoreData


public class Observation: NSManagedObject {
    
    var rank: Int {
        get {
            return Int(int32rank)
        }
        set {
            int32rank = Int32(newValue)
        }
    }
    
    convenience init(text: String, rank: Int, context: NSManagedObjectContext){
        let entity = NSEntityDescription.entity(forEntityName: "Observation", in: context)!
        self.init(entity: entity, insertInto: context)
        self.date = NSDate()
        self.text = text
        self.rank = rank
    }
}
