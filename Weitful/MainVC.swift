//
//  MainVC.swift
//  Weitful
//
//  Created by Julia Miller on 11/23/16.
//  Copyright © 2016 Julia Miller. All rights reserved.
//

import UIKit
import CoreData

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
    
    var notAchievedArray = [Achievement]()
    var achievedArray = [Achievement]()
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
    
    var firstLaunch = false
    var exerciseAlreadySetToday = false
    var eatingAlreadySetToday = false
    var addTipOfDayBool = false
    
    private var foregroundNotification: NSObjectProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //update when app enters foreground
        foregroundNotification = NotificationCenter.default.addObserver(forName: NSNotification.Name.UIApplicationWillEnterForeground, object: nil, queue: OperationQueue.main) {
            [unowned self] notification in
            self.setUp()
            // do whatever you want when the app is brought back to the foreground
        }
        checkForFirstLaunch()
    }
    
    deinit {
        // make sure to remove the observer when this view controller is dismissed/deallocated
        NotificationCenter.default.removeObserver(foregroundNotification)
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
            vc.backgroundImage = H.takeScreenshot(view: self.view)
            vc.achievement = sender as! Achievement!
        } else if segue.identifier == segueID.achievementVC {
            let vc = segue.destination as! AchievementVC
            vc.achievedArray = self.achievedArray
            vc.notAchievedArray = self.notAchievedArray
            vc.exercisingStreak = self.exercisingStreak
            vc.eatingStreak = self.eatingStreak
            vc.loggingStreak = self.loggingStreak
        } else if segue.identifier == segueID.tipVC {
            let vc = segue.destination as! TipVC
            let index = UserDefaults.standard.integer(forKey: tipOfDay)
            var unlocked: [(dayNumber: Int, image: UIImage, text: String)] = []
            for i in 0...(index-1) {
                let tip = tipDefaults[i]
                unlocked.append(tip)
            }
            vc.unlockedTips = unlocked
        } else if segue.identifier == segueID.statisticVC {
            let vc = segue.destination as! StatisticVC
            var logs = prevDayLogs
            logs.append(today)
            vc.allLogs = logs
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if firstLaunch {
            createInstructionEntities()
            createSampleObservationsAndComments()
            loadAchievementsIntoCoreData()
        }
        setUp()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if firstLaunch {
            firstLaunch = false
            segueToIntro()
        }
        if addTipOfDayBool {
            addTipOfDay()
            compileWeekEatingAndExercisingData()
            addTipOfDayBool = false
        }
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
    
    @IBAction func statistics(){
        performSegue(withIdentifier: segueID.statisticVC, sender: nil)
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
        exerciseAlreadySetToday = (today.exercise == Int(noData)) ? false : true
        eatingAlreadySetToday = (today.eating == Int(noData)) ? false : true
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
        if prevDayLogs.count == 0 {
            //one for "Placeholder" cell, one for "AddDate" cell
            return 2
        } else {
            return prevDayLogs.count + 1
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let i = indexPath.row
        let numOfRows = tableView.numberOfRows(inSection: indexPath.section)
        //Last cell is "AddDate" cell
        if i == numOfRows - 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddDate")!
            cell.selectionStyle = .none
            return cell
        }
        //There are no prevDayLogs. We're on the first day of using our app.
        if prevDayLogs.count == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Placeholder")!
            cell.selectionStyle = .none
            return cell
        } else {
            //prevDayLogs has logs in it.
            let cell = tableView.dequeueReusableCell(withIdentifier: "LogCell") as! LogCell
            if i == 0 {
                //this is first cell
                if prevDayLogs.count == 1 {
                    cell.configureCell(log: prevDayLogs[i], dayAfter: nil, dayBefore: nil, prevCellColor: nil)
                } else {
                    cell.configureCell(log: prevDayLogs[i], dayAfter: nil, dayBefore: prevDayLogs[i+1], prevCellColor: nil)
                    cellColors.append(cell.backgroundColor!)
                }
                return cell
            }
            else if i == numOfRows - 2 {
                //this is last log
                cell.configureCell(log: prevDayLogs[i], dayAfter: prevDayLogs[i-1], dayBefore: nil, prevCellColor: cellColors[i-1])
            } else {
               cell.configureCell(log: prevDayLogs[i], dayAfter: prevDayLogs[i-1], dayBefore: prevDayLogs[i+1], prevCellColor: cellColors[i-1])
            }
            cellColors.append(cell.backgroundColor!)
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
        while i < array.count {
            if array[i].eating < 2 && array[i].eating != Int(noData) { //no data = -100
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
            if array[i].weightString != "- - lbs" {
                loggingStreak = (daysPassed > 1) ? 1 : loggingStreak + 1
            }
            
            i += 1
        }
    }
    func checkIfAnyAchievementsHaveBeenReached(){
        compileWeekEatingAndExercisingData()
        calculateStreaks()
        //also need a special one for exercise 1-5 level for 7 days
        //print("achieved array count: ", achievedArray.count)
        for award in notAchievedArray {
            if award.title == "LEADER" { //special case for 7 days of >= 1 exercise
                if weekExercisingRatings.count == 7 {
                    var count = 0
                    for rating in weekExercisingRatings {
                        count  = (rating > 0) ? count + 1: count + 0
                    }
                    if count == 7 {
                        award.achieved = true
                        award.date = NSDate()
                        award.numOfTimesAchievedInt += 1
                        segueToNewAchievementVC(sender: award)
                    }
                }
            }
            let weekRatings = (award.type == exercise) ? weekExercisingRatings : weekEatingRatings
            
            let targetDays = award.numOfDays
            let awardRating = award.intensityLevel
            var dayCount = 0
            for rating in weekRatings {
                if weekRatings == weekExercisingRatings {
                    let alreadySet = (weekRatings == weekExercisingRatings) ? exerciseAlreadySetToday : eatingAlreadySetToday
                    //make sure that it's not the same day that has been changedr
                    dayCount = (rating == awardRating && alreadySet == false) ? dayCount + 1 : dayCount + 0
                }
                if rating == awardRating  {dayCount += 1}
                if dayCount == targetDays {
                    print("achievement acquired! ", award.title!, award.detail!)
                    award.achieved = true
                    award.date = NSDate()
                    award.numOfTimesAchievedInt += 1
                    segueToNewAchievementVC(sender: award)
                }
            }
        }
    }
    
    
    //viewdidload
    func fetchAchievements(){
        notAchievedArray.removeAll()
        achievedArray.removeAll()
        let request: NSFetchRequest<Achievement> = Achievement.fetchRequest()
        var tempArray: [Achievement] = []
        do {tempArray = try context.fetch(request) } catch {fatalError()}
        for award in tempArray {
            if award.achieved {
                achievedArray.append(award)
            } else { notAchievedArray.append(award)}
        }
    }
    
    //check for first launch
    func loadAchievementsIntoCoreData(){
        for x in eatingAchievements {
            let image = UIImagePNGRepresentation(x.image) as NSData?
            _ = Achievement(type: eating, image: image!, title: x.name, detail: x.detail, numOfDays: x.numOfDays, intensityLevel: x.intensityLevel, context: context)
        }
        for x in exercisingAchievements{
            let image = UIImagePNGRepresentation(x.image) as NSData?
            _ = Achievement(type: exercise, image: image!, title: x.name, detail: x.detail, numOfDays: x.numOfDays, intensityLevel: x.intensityLevel, context: context)
        }
        delegate.saveContext()
    }
    
    func compileWeekEatingAndExercisingData(){
        
        weekEatingRatings.removeAll()
        weekExercisingRatings.removeAll()
        weekEatingRatings.append(today.eating)
        weekExercisingRatings.append(today.exercise)
        
        for x in prevDayLogs {
            if checkIfSameWeek(now: today.date!, dayAfter: x.date!) {
                if x.eating == Int(noData){break}
                if x.exercise == Int(noData){break}
                weekEatingRatings.append(x.eating)
                weekExercisingRatings.append(x.exercise)
            }
            //we just started a new week.
            if addTipOfDayBool {
                if !checkIfSameWeek(now: prevDayLogs[0].date!, dayAfter: today.date!){
                    print("just started a new week")
                    for x in achievedArray {
                        x.achieved = false
                    }
                }
            }
        }
    }
    
    func segueToNewAchievementVC(sender: Achievement){
        performSegue(withIdentifier: segueID.newAchievementVC, sender: sender)
    }
}

