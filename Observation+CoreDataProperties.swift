//
//  Observation+CoreDataProperties.swift
//  Weitful
//
//  Created by Julia Miller on 12/12/16.
//  Copyright © 2016 Julia Miller. All rights reserved.
//

import Foundation
import CoreData


extension Observation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Observation> {
        return NSFetchRequest<Observation>(entityName: "Observation");
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var isPositive: Bool
    @NSManaged public var privateType: String?
    @NSManaged public var text: String?
    @NSManaged public var int32rank: Int32

}
