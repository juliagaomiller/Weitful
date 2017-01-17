//
//  TutorialVC.swift
//  Weitful
//
//  Created by Julia Miller on 12/29/16.
//  Copyright © 2016 Julia Miller. All rights reserved.
//

import UIKit
import CoreData

var help: [[String: String]] =
    [[segueID.mainVC: "Tap on the top half of the screen to log your weight. Swipe right to log down your observations. Swipe left to look at my tips. Swipe up to look at your achievements and streaks. Swipe down to look at the exercise and eating ratings. Tap on the statistics button in the upper left to see your weekly and monthly ratings. Tap anywhere on the screen to close this page."],
     [segueID.logVC: "Swipe left or right to save the log and go back to the menu.  The white number represents your exercise rating. The black number represents your eating rating. Use the number pad to log your weight."],
     [segueID.tipVC: "Here I will send you tips that I find interesting."],
     [segueID.observationVC: "Here you can write down your observations. To add postive or negative comments, tap on the cell. To delete, swipe the cell to the left. You can edit the observation in the comments table."],
     [segueID.commentsVC: "You can edit the observation by tapping on it. Add comments when there is a situation where the comments are proven true or false. E.g. Observation: If I jog first thing in the morning, I'm not hungry until 11am. Comment: 11am, just started feeling a little bit hungry."],
     [segueID.instructionsVC: "Tap on the eating/exercise button at the bottom of the page to toggle between the two instructions. Tap Back to go back to the main menu."]
]

class TutorialVC: UIViewController {
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var greyView: UIView!
    
    @IBOutlet weak var resetBtn: UIButton!
    @IBOutlet weak var resetView: UIView!
    @IBOutlet weak var watchIntroBtn: UIButton!
    @IBOutlet weak var sendFeedbackLbl: UILabel!
    
    let context = delegate.persistentContainer.viewContext
    
    var screenshot: UIImage!
    var VCTitle: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resetView.isHidden = true
        if VCTitle == segueID.mainVC {
            resetBtn.isHidden = false
            watchIntroBtn.isHidden = false
            sendFeedbackLbl.isHidden = false
        } else {
            resetBtn.isHidden = true
            watchIntroBtn.isHidden = true
            sendFeedbackLbl.isHidden = true
        }
        let tap = UITapGestureRecognizer(target: self, action: #selector(back))
        greyView.addGestureRecognizer(tap)
        backgroundImageView.image = screenshot
        for dict in help {
            for (title, text) in dict {
                if title == VCTitle {
                    textView.text = text
                }
            }
            
        }
        
    }
    
    @IBAction func reset(sender: UIButton){
        if sender == resetBtn {
            resetView.isHidden = false
        } else {
            removeAllDayLogEntities()
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    @IBAction func cancel(){
        resetView.isHidden = true
    }
    
    @IBAction func watchIntro(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: segueID.mainVC)
        self.present(vc!, animated: false, completion: nil)
    }
    
    
    
    func removeAllDayLogEntities() {
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "DayLog")
        let request = NSBatchDeleteRequest(fetchRequest: fetch)
        do {
          _ = try context.execute(request)
        } catch {fatalError()}
        
        delegate.saveContext()
    }
    
    func back(){
        self.dismiss(animated: false, completion: nil)
    }
    
}
