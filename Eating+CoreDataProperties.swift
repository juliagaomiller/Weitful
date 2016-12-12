//
//  Eating+CoreDataProperties.swift
//  Weitful
//
//  Created by Julia Miller on 12/8/16.
//  Copyright © 2016 Julia Miller. All rights reserved.
//

import Foundation
import CoreData


extension Eating {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Eating> {
        return NSFetchRequest<Eating>(entityName: "Eating");
    }

    @NSManaged public var int32rank: Int32
    @NSManaged public var defaultText: String?
    @NSManaged public var userText: String?

}
