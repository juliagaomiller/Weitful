//
//  AchievementVC.swift
//  Weitful
//
//  Created by Julia Miller on 1/4/17.
//  Copyright © 2017 Julia Miller. All rights reserved.
//

import UIKit

class AchievementVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var loggingStreakLbl: UILabel!
    @IBOutlet weak var exercisingStreakLbl: UILabel!
    @IBOutlet weak var eatingStreakLbl: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    var achievedArray: [Achievement] = []
    var notAchievedArray: [Achievement] = []
    var allAchievements: [Achievement] = []
    
    var eatingStreak: Int!
    var exercisingStreak: Int!
    var loggingStreak: Int!
    
    var seeAllAchievements = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if achievedArray.count == 0 {
            tableView.isHidden = true
        } else { tableView.isHidden = false }
        seeAllAchievements = false
        allAchievements = achievedArray + notAchievedArray
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 90
        addSwipeDown()
        loggingStreakLbl.text = "\(loggingStreak!) continuous day(s) of logging."
        eatingStreakLbl.text = "\(eatingStreak!) continuous day(s) of mindful eating"
        exercisingStreakLbl.text = "\(exercisingStreak!) continuous day(s) of exercise"
    }
    
    func addSwipeDown(){
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(dismissVC))
        swipe.direction = .down
        self.view.addGestureRecognizer(swipe)
    }
    
    func dismissVC(){
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension AchievementVC {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if seeAllAchievements {
            return allAchievements.count
        }
        return achievedArray.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if achievedArray.count > 0 && indexPath.row == achievedArray.count && !seeAllAchievements {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SeeAllAchievements")!
            cell.selectionStyle = .default
            return cell
        } else if seeAllAchievements {
            let achievement = allAchievements[indexPath.row]
            if achievement.achieved == false || achievedArray.count == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "AchievementPlaceholderCell") as! AchievementPlaceholderCell
                cell.configure(achievement: achievement)
                cell.selectionStyle = .none
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "AchievementCell") as! AchievementCell
                cell.configure(achievement: achievement)
                cell.selectionStyle = .none
                return cell
            }
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AchievementCell") as! AchievementCell
            cell.configure(achievement: achievedArray[indexPath.row])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        if cell!.reuseIdentifier == "SeeAllAchievements" {
            seeAllAchievements = true
            tableView.reloadData()
        }
        
    }
}


