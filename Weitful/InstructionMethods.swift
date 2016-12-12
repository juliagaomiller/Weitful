//
//  InstructionMethods.swift
//  Weitful
//
//  Created by Julia Miller on 12/8/16.
//  Copyright © 2016 Julia Miller. All rights reserved.
//

import Foundation
import CoreData

extension InstructionsVC {
    
    func loadInstructionEntitiesFromDB(){
        let eatingRequest: NSFetchRequest<Eating> = Eating.fetchRequest()
        do { eatingArray = try context.fetch(eatingRequest)
            eatingArray = eatingArray.sorted(by: {$1.rank > $0.rank})
            
        } catch {fatalError()}
        let exRequest: NSFetchRequest<Exercising> = Exercising.fetchRequest()
        do { exerciseArray = try context.fetch(exRequest)
            exerciseArray = exerciseArray.sorted(by: {$1.rank > $0.rank})
        } catch {fatalError()}
        makeSureThereAreNoErrorsWithEntities()
    }
    
    func makeSureThereAreNoErrorsWithEntities(){
        if eatingArray.count != 7 {
            print(eatingArray.count)
            fatalError()
        }
        if exerciseArray.count != 6 {
            print(exerciseArray.count)
            fatalError()
        }
    }
    
}
