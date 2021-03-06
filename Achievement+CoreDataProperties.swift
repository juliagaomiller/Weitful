//
//  Achievement+CoreDataProperties.swift
//  Weitful
//
//  Created by Julia Miller on 1/8/17.
//  Copyright © 2017 Julia Miller. All rights reserved.
//

import Foundation
import CoreData


extension Achievement {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Achievement> {
        return NSFetchRequest<Achievement>(entityName: "Achievement");
    }

    @NSManaged public var achieved: Bool
    @NSManaged public var date: NSDate?
    @NSManaged public var detail: String?
    @NSManaged public var image: NSData?
    @NSManaged public var int32intensityLevel: Int32
    @NSManaged public var int32numOfDays: Int32
    @NSManaged public var numOfTimesAchievedString: String?
    @NSManaged public var title: String?
    @NSManaged public var type: String?

}
