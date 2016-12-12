//
//  DayLog+CoreDataProperties.swift
//  Weitful
//
//  Created by Julia Miller on 11/30/16.
//  Copyright © 2016 Julia Miller. All rights reserved.
//

import Foundation
import CoreData


extension DayLog {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DayLog> {
        return NSFetchRequest<DayLog>(entityName: "DayLog");
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var int32eating: Int32
    @NSManaged public var int32exercise: Int32
    @NSManaged public var weight: Double
    @NSManaged public var commentary: String?

}
