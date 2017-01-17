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

let tipOfDay = "tipOfDay"

extension MainVC {
    
    func checkForFirstLaunch(){
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        if launchedBefore  {
        } else {
            firstLaunch = true
            print("first launch")
            UserDefaults.standard.set(true, forKey: "launchedBefore")
            UserDefaults.standard.set(0, forKey: tipOfDay)
        }
    }
    
    func segueToIntro(){
        let vc = storyboard?.instantiateViewController(withIdentifier: segueID.introVC) as! IntroVC
        vc.backgroundImage = H.takeScreenshot(view: self.view)
        self.present(vc, animated: false, completion: nil)
    }
    
    func addGestureRecognizers(){
        addTapRecognizerToView()
        addSwipeDownGestureRecognizer()
        addSwipeLeftGestureRecognizer() //goes to ObservationVC
        addSwipeRightGestureRecognizer()
        addSwipeUpGestureRecognizer()
    }
    
    func addSwipeUpGestureRecognizer(){
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(segueToAchievementVC))
        swipe.direction = .up
        self.view.addGestureRecognizer(swipe)
    }
    
    func segueToAchievementVC(){
        performSegue(withIdentifier: segueID.achievementVC, sender: achievedArray)
    }
    
    func addSwipeRightGestureRecognizer(){
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(segueToTipVC))
        swipe.direction = .right
        self.view.addGestureRecognizer(swipe)
    }
    
    func segueToTipVC(){
        performSegue(withIdentifier: segueID.tipVC, sender: nil)
    }
    
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
    
    func calculateLastLog(){
        if prevDayLogs.count == 0 {
            lastLogLbl.text = ""
        }
        let elapsed = today.date?.daysBetween(otherDate: prevDayLogs[0].date!)
        if elapsed! > 1 {
            lastLogLbl.text = "Last log: \(elapsed) days ago"
        } else {
            lastLogLbl.text = "Last log: yesterday"
        }
    }
    
    func segueToObservationVC(){
        performSegue(withIdentifier: segueID.observationVC, sender: self)
    }
    
    func segueToInstructionVC(){
        performSegue(withIdentifier: segueID.instructionsVC, sender: self)
    }
    
    func createSampleObservationsAndComments(){
        let one = Observation(text: "When I eat two eggs in the morning, I'm not hungry till noon (Sample. Swipe left to delete).", rank: 1, context: context)
        let two = Observation(text: "After I jog I have a smaller appetite (Sample).", rank: 1, context: context)
        let _ = ObservationComments(text: "Was not hungry till lunch today (Sample).", observation: one, isPositive: true, context: context)
        let _ = ObservationComments(text: "Yup (Sample).", observation: one, isPositive: true, context: context)
        let _ = ObservationComments(text: "Yup (Sample).", observation: two, isPositive: true, context: context)
        let _ = ObservationComments(text: "Appetite is a lot less (Sample).", observation: two, isPositive: true, context: context)
        let _ = ObservationComments(text: "Was still hungry after I jogged. Haven't had lunch yet (Sample).", observation: two, isPositive: false, context: context)
        delegate.saveContext()
    
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
        performSegue(withIdentifier: segueID.logVC, sender: today)
    }
    
    func hideCellInfo(){
        editBackStackView.isHidden = true
        editBtn.isHidden = true
        backBtn.isHidden = true
        whiteTV.isHidden = true
        cellSelectedLog = nil
    }
    
    func fetchLogs(){
        let request: NSFetchRequest<DayLog> = DayLog.fetchRequest()
        do {prevDayLogs = try context.fetch(request)} catch {fatalError()}
        if prevDayLogs.count == 0 {
            today = DayLog(context: context)
            prevDayLogs.append(today)
        } else {
            prevDayLogs.sort(by: { $0.date!.compare($1.date as! Date) == .orderedDescending })
            //Check if we have already logged weight today
            let date = NSDate()
            if prevDayLogs[0].MMddyy == date.convertToString(format: "MMddyy") {
                //already logged today
                today = prevDayLogs[0]
                prevDayLogs.removeFirst()
                if prevDayLogs.count == 0 {

                    let string = UserDefaults.standard.string(forKey: "setTipOfDay")
                    if string == nil{
                        UserDefaults.standard.set("allSet", forKey: "setTipOfDay")
                        addTipOfDay()
                    }
                }
            } else {
                today = DayLog(context: context)
                if !firstLaunch {
                    addTipOfDayBool = true
                }
                
            }
        }
        delegate.saveContext()
        tableView.reloadData()
    }
    
    func addTipOfDay(){
        let index = UserDefaults.standard.integer(forKey: tipOfDay)
        if index < tipDefaults.count {
            let tip = tipDefaults[index]
            UserDefaults.standard.set((index + 1), forKey: tipOfDay)
            let vc = self.storyboard?.instantiateViewController(withIdentifier: segueID.dayTipVC) as! DayTipVC
            vc.background = H.takeScreenshot(view: self.view)
            vc.tipImage = tip.image
            vc.tipText = tip.text
            self.present(vc, animated: false, completion: nil)
        }
    }
    
}
