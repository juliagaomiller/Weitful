//
//  Exercising+CoreDataProperties.swift
//  Weitful
//
//  Created by Julia Miller on 12/8/16.
//  Copyright © 2016 Julia Miller. All rights reserved.
//

import Foundation
import CoreData


extension Exercising {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Exercising> {
        return NSFetchRequest<Exercising>(entityName: "Exercising");
    }

    @NSManaged public var userText: String?
    @NSManaged public var defaultText: String?
    @NSManaged public var int32rank: Int32

}
