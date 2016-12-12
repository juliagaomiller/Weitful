//
//  MainMethods.swift
//  Weitful
//
//  Created by Julia Miller on 11/30/16.
//  Copyright © 2016 Julia Miller. All rights reserved.
//

import Foundation
import UIKit
import CoreData

extension MainVC {
    
    func addSwipeDownGestureRecognizer(){
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(segueToInstructionVC))
        swipeDown.direction = .down
        self.view.addGestureRecognizer(swipeDown)
    }
    
    func addSwipeLeftGestureRecognizer(){
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(segueToObservationVC))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
    }
    
    func segueToObservationVC(){
        performSegue(withIdentifier: segueID.observationVC, sender: self)
    }
    
    func segueToInstructionVC(){
        performSegue(withIdentifier: segueID.instructionsVC, sender: self)
    }
    
    func checkForFirstLaunch(){
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        if launchedBefore  {
            //"Not first launch."
        } else {
            //"First launch, setting UserDefault."
            createInstructionEntities()
            UserDefaults.standard.set(true, forKey: "launchedBefore")
        }
    }
    
    func createInstructionEntities(){
        let eatingArrayOfDict = InstructionDefaults().eating
        for eating in eatingArrayOfDict {
            for (int, string) in eating {
                let _ = Eating(rank: int, defaultText: string, context: context)
            }
        }
        let exercisingArrayOfDict = InstructionDefaults().exercise
        for exercising in exercisingArrayOfDict {
            for (int, string) in exercising {
                let _ = Exercising(rank: int, defaultText: string, context: context)
            }
        }
        delegate.saveContext()
    }
    
    func addTapRecognizerToView(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(viewPressed(sender:)))
        todayView.addGestureRecognizer(tap)
    }
    
    func viewPressed(sender: UIView!){
        segueToLogVC(log: today)
    }
    
    func hideCellInfo(){
        editBtn.isHidden = true
        backBtn.isHidden = true
        showTextView.isHidden = true
        cellSelectedLog = nil
    }
    
    func segueToLogVC(log: DayLog){
        let vc = storyboard?.instantiateViewController(withIdentifier: "LogVC") as! LogVC
        vc.log = log
//        present(vc, animated: false, completion: nil)
        present(vc, animated: false, completion: nil)
    }
    
    func fetchLogs(){
        let request: NSFetchRequest<DayLog> = DayLog.fetchRequest()
        do {prevDayLogs = try context.fetch(request)} catch {fatalError()}
        if prevDayLogs.count == 0 {
            today = DayLog(context: context)
            prevDayLogs.append(today)
        } else {
            print(prevDayLogs.count)
            prevDayLogs.sort(by: { $0.date!.compare($1.date as! Date) == .orderedDescending })
            let date = NSDate()

            //Check if we have already logged weight today
            if prevDayLogs[0].MMddyy == date.convertToString(format: "MMddyy") {
                today = prevDayLogs[0]
                prevDayLogs.removeFirst()
            } else {today = DayLog(context: context)}
        }
        print(prevDayLogs.count)
        delegate.saveContext()
        tableView.reloadData()
    }
    
}
