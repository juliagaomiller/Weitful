//
//  DayLog+CoreDataProperties.swift
//  Weitful
//
//  Created by Julia Miller on 11/25/16.
//  Copyright © 2016 Julia Miller. All rights reserved.
//

import Foundation
import CoreData


extension DayLog {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DayLog> {
        return NSFetchRequest<DayLog>(entityName: "DayLog");
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var eating: String?
    @NSManaged public var exercise: String?
    @NSManaged public var weight: String?

}
