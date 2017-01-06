//
//  MainVC.swift
//  Weitful
//
//  Created by Julia Miller on 11/23/16.
//  Copyright © 2016 Julia Miller. All rights reserved.
//

import UIKit
import CoreData

//Achievements
extension MainVC {
    
    func calculateStreaks(){
        eatingStreak = 0
        exercisingStreak = 0
        loggingStreak = 0
        var array = prevDayLogs
        array.append(today)
        array = array.sorted(by: { $0.date!.compare($1.date as! Date) == .orderedDescending })
        var i = 0
        print("array count: \(array.count)")
        while i < array.count {
            if array[i].eating < 2 && array[i].eating != Int(noData) { //no data = -100
                print("array[i].eating: ", array[i].eating)
                eatingStreak += 1
            }
            if array[i].exercise > 0 {
                exercisingStreak += 1
            }
            var daysPassed: Int!
            let date = array[i].date!
            if i < array.count - 1 {
                let otherDate = array[i+1].date!
                daysPassed = abs(date.daysBetween(otherDate: otherDate))
            } else {
                //there is only one element in the array so the logging streak will be 1
                daysPassed = 2
            }
            
            loggingStreak = (daysPassed > 1) ? 1 : loggingStreak + 1
            i += 1
        }
        print("eating streak: \(eatingStreak), exercising streak: \(exercisingStreak), logging streak:  \(loggingStreak)")

        
    }
    
    //viewwillappear
    func checkIfAnyAchievementsHaveBeenReached(){
        compileWeekEatingAndExercisingData()
        calculateStreaks()
        //also need a special one for exercise 1-5 level for 7 days
        for award in achievementArray{
            let array = (award.type == exercise) ? weekExercisingRatings : weekEatingRatings
            let days = award.numOfDays
            let level = award.intensityLevel
            var count = 0
            for rating in array {
                if rating == level {
                    count += 1
                }
                if count == days {
                    award.achieved = true
                    segueToAchievementVC()
                }
            }
        }
    }
    
    //viewdidload
    func fetchAchievements(){
        achievementArray.removeAll()
        let request: NSFetchRequest<Achievement> = Achievement.fetchRequest()
        request.predicate = NSPredicate(format: "achieved == %@", false as CVarArg)
        do {achievementArray = try context.fetch(request)} catch {fatalError()}
    }

    //check for first launch
    func loadAchievementsIntoCoreData(){
        for x in eatingAchievements {
            _ = Achievement(type: eating, image: x.image, title: x.name, detail: x.description, numOfDays: x.numOfDays, intensityLevel: x.intensityLevel, context: context)
        }
        for x in exercisingAchievements{
            _ = Achievement(type: eating, image: x.image, title: x.name, detail: x.description, numOfDays: x.numOfDays, intensityLevel: x.intensityLevel, context: context)
        }
        delegate.saveContext()
    }
    
    func compileWeekEatingAndExercisingData(){
        weekEatingRatings.removeAll()
        weekExercisingRatings.removeAll()
        for x in prevDayLogs {
            if checkIfSameWeek(now: today.date!, previous: x.date!) {
                if x.eating == Int(noData){break}
                if x.exercise == Int(noData){break}
                weekEatingRatings.append(x.eating)
                weekExercisingRatings.append(x.exercise)
            }
        }
        
        print("Verify that the ratings correlate with what is showing on the build.")
        for x in weekEatingRatings {
            print("eating: \(x)")
        }
        for x in weekExercisingRatings {
            print("exercising: \(x)")
        }
    
    }
    
    func segueToAchievementPage(sender: Achievement){
        performSegue(withIdentifier: segueID.newAchievementVC, sender: sender)
    }
}

let instructionsVCSegue = "InstructionsVCSegue"

//UIViewControllerTransitioningDelegate
class MainVC: UIViewController {
    
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var exerciseLbl: UILabel!
    @IBOutlet weak var eatingLbl: UILabel!
    @IBOutlet weak var progressLbl: UILabel!
    @IBOutlet weak var todayView: UIView!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var lastLogLbl: UILabel!
    @IBOutlet weak var commentTV: UITextView!
    @IBOutlet weak var whiteTV: UITextView!
    @IBOutlet weak var numberStackView: UIStackView!
    @IBOutlet weak var editBackStackView: UIStackView!
    @IBOutlet weak var exerciseImage: UIImageView!
    @IBOutlet weak var eatingImage: UIImageView!
    
    @IBOutlet weak var tableView: UITableView!
    
    let context = delegate.persistentContainer.viewContext
    let offscreenRight = OffScreenRightAC()
    let swipeDownAC = SwipeDownAC()
    let splitAC = SplitAC()
    let swipeLeftAC = SwipeLeftAC()
    
    var achievementArray = [Achievement]()
    var weekEatingRatings = [Int]()
    var weekExercisingRatings = [Int]()
    var loggingStreak: Int = 0
    var eatingStreak: Int = 0
    var exercisingStreak: Int = 0
    
    var prevDayLogs: [DayLog] = []
    var cellSelectedLog: DayLog?
    var newLog: DayLog?
    var today: DayLog!
    var cellColors = [UIColor]()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination
        vc.transitioningDelegate = self
        if segue.identifier == segueID.logVC {
            let logVC = segue.destination as! LogVC
            //logVC.transitioningDelegate = self
            logVC.log = sender as! DayLog
        } else if segue.identifier == segueID.newAchievementVC {
            let vc = segue.destination as! NewAchievementVC
            vc.achievement = sender as! Achievement!
        } else if segue.identifier == segueID.achievementVC {
            let vc = segue.destination as! AchievementVC
            vc.exercisingStreak = self.exercisingStreak
            vc.eatingStreak = self.eatingStreak
            vc.loggingStreak = self.loggingStreak
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setUp()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkForFirstLaunch()
    }
    
    @IBAction func edit(){
        guard let log = cellSelectedLog else {fatalError()}
        performSegue(withIdentifier: segueID.logVC, sender: log)
    }
    
    @IBAction func questionMark(_ sender: Any) {
        let screenshot = H.takeScreenshot(view: self.view)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: segueID.tutorialVC ) as! TutorialVC
        vc.screenshot = screenshot
        vc.VCTitle = segueID.mainVC
        self.present(vc, animated: false, completion: nil)
    }
    
    @IBAction func back(){
        hideCellInfo()
    }
    
    func setUp(){
        tableView.delegate = self
        tableView.dataSource = self
        commentTV.layer.cornerRadius = 7.0
        whiteTV.layer.cornerRadius = 7.0
        fetchLogs()
        fetchAchievements()
        checkIfAnyAchievementsHaveBeenReached()
        addGestureRecognizers()
        updateView()
    }
    
    func updateView(){
        hideCellInfo()
        dateLbl.text = today.dateString
        weightLbl.text = today.weightString
        exerciseLbl.text = today.exerciseString
        eatingLbl.text = today.eatingString
        commentTV.text = today.commentary
        
        if prevDayLogs.count != 0 {
            progressLbl.text = H.calculateProgress(now: today.weight, before: prevDayLogs[0].weight)
            calculateLastLog()
        } else {progressLbl.text = ""}
        
        //add date extension to calculate progress
    }
}

extension MainVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if prevDayLogs.count <= 1 {
            //one for "no previous logs" cell, one for "add previous weight" cell
            return 2
        } else {
            return prevDayLogs.count + 1
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let i = indexPath.row
        let numOfRows = tableView.numberOfRows(inSection: indexPath.section)
        if i == numOfRows - 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddDate")!
            cell.selectionStyle = .none
            return cell
        }
        if prevDayLogs.count < 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Placeholder")!
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LogCell") as! LogCell
            if i == 5 {
                
            }
            if i < prevDayLogs.count - 1 {
                //the tableView is organized so that yesterday is at the top of the prevDayLogs array.
                if i > 0 {
                    cell.configureCell(log: prevDayLogs[i], previous: prevDayLogs[i+1], prevCellColor: cellColors[i-1])
                } else {
                   cell.configureCell(log: prevDayLogs[i], previous: prevDayLogs[i+1], prevCellColor: nil)
                }
            } else {
                //we're on the last cell in the table.
                if i > 0 {
                    cell.configureCell(log: prevDayLogs[i], previous: prevDayLogs[i-1], prevCellColor: cellColors[i-1])
                } else {
                    cell.configureCell(log: prevDayLogs[i], previous: nil, prevCellColor: nil)
                }
                
            }
            if cellColors.count < prevDayLogs.count {
                cellColors.append(cell.backgroundColor!)
            }
            cell.selectionStyle = .default
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        let i = indexPath.row
        if cell?.reuseIdentifier == "LogCell"{
            //show text commentary and buttons
            cellSelectedLog = prevDayLogs[i]
            whiteTV.isHidden = false
            whiteTV.text = cellSelectedLog!.commentary
            editBackStackView.isHidden = false
            editBtn.isHidden = false
            backBtn.isHidden = false
        } else if cell?.reuseIdentifier == "AddDate"{
            newLog = DayLog(context: context)
            var date: NSDate!
            //if no prevDayLogs return todays date
            if prevDayLogs.count == 0 {date = today.date}
            //return date for last log in array
            else {date = prevDayLogs.last?.date}
            let newDate = date.dayBefore
            newLog!.date = newDate
            delegate.saveContext()
            performSegue(withIdentifier: segueID.logVC, sender: newLog)
        }
    }

}
