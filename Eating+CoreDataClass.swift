//
//  Eating+CoreDataClass.swift
//  Weitful
//
//  Created by Julia Miller on 12/8/16.
//  Copyright © 2016 Julia Miller. All rights reserved.
//

import Foundation
import CoreData


public class Eating: NSManagedObject {
    
    var rank: Int {
        get { return Int(int32rank) }
        set { int32rank = Int32(newValue) }
    }
    
    convenience init (rank: Int, defaultText: String, context: NSManagedObjectContext){
        let entity = NSEntityDescription.entity(forEntityName: "Eating", in: context)!
        self.init(entity: entity, insertInto: context)
        self.rank = rank
        self.defaultText = defaultText
        self.userText = nil
    }

}
