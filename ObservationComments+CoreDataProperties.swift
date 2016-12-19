//
//  ObservationComments+CoreDataProperties.swift
//  Weitful
//
//  Created by Julia Miller on 12/15/16.
//  Copyright © 2016 Julia Miller. All rights reserved.
//

import Foundation
import CoreData


extension ObservationComments {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ObservationComments> {
        return NSFetchRequest<ObservationComments>(entityName: "ObservationComments");
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var isPositive: Bool
    @NSManaged public var text: String?
    @NSManaged public var observation: Observation?

}
