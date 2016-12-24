
//
//  ObservationComments+CoreDataClass.swift
//  Weitful
//
//  Created by Julia Miller on 12/14/16.
//  Copyright © 2016 Julia Miller. All rights reserved.
//

import Foundation
import CoreData


public class ObservationComments: NSManagedObject {
    
    var timeString: String {
        get {
            let string = date?.convertToString(format: "h:mm a")
            return string!
        }
    }
    
    var dateString: String {
        get {
            let string = date?.convertToString(format: "MM/dd")
            return string!
        }
    }
    
    //var days ago
    
    convenience init(text: String, observation: Observation, isPositive: Bool, context: NSManagedObjectContext){
        let entity = NSEntityDescription.entity(forEntityName: "ObservationComments", in: context)!
        self.init(entity: entity, insertInto: context)
        self.date = NSDate()
        self.text = text
        self.observation = observation
        self.isPositive = isPositive
    }
    
}
