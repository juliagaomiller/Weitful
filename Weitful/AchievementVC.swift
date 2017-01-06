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
    
    var achievementArray: [Achievement] = []
    var eatingStreak: Int!
    var exercisingStreak: Int!
    var loggingStreak: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        addSwipeDown()
        loggingStreakLbl.text = "\(loggingStreak!) continuous day(s) of logging."
        eatingStreakLbl.text = "\(eatingStreak!) continuous day(s) of >= +1 exercise"
        exercisingStreakLbl.text = "\(exercisingStreak!) continuous day(s) of <= +1 eating"
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
        return achievementArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let achievement = achievementArray[indexPath.row]
        if achievement.achieved == false {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AchievementPlaceholderCell") as! AchievementPlaceholderCell
            cell.configure(achievement: achievement)
            print("created an achievement placeholder cell")
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AchievementCell") as! AchievementCell
            cell.configure(achievement: achievement)
            print("created an achievement cell")
            return cell
        }
    }
}


