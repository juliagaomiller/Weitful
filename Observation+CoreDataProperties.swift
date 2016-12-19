//
//  Observation+CoreDataProperties.swift
//  Weitful
//
//  Created by Julia Miller on 12/15/16.
//  Copyright © 2016 Julia Miller. All rights reserved.
//

import Foundation
import CoreData


extension Observation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Observation> {
        return NSFetchRequest<Observation>(entityName: "Observation");
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var int32rank: Int32
    @NSManaged public var text: String?
    @NSManaged public var comments: NSSet?

}

// MARK: Generated accessors for comments
extension Observation {

    @objc(addCommentsObject:)
    @NSManaged public func addToComments(_ value: ObservationComments)

    @objc(removeCommentsObject:)
    @NSManaged public func removeFromComments(_ value: ObservationComments)

    @objc(addComments:)
    @NSManaged public func addToComments(_ values: NSSet)

    @objc(removeComments:)
    @NSManaged public func removeFromComments(_ values: NSSet)

}
