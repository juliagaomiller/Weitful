//
//  TipVC.swift
//  Weitful
//
//  Created by Julia Miller on 12/23/16.
//  Copyright © 2016 Julia Miller. All rights reserved.
//

import UIKit

class TipVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var unlockedTips: [(dayNumber: Int, image: UIImage, text: String)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200
        tableView.allowsSelection = false
        //        tableView.rowHeight = 200
        addSwipeLeft()
        tableView.reloadData()
    }
    
    @IBAction func questionMark(_ sender: Any) {
        let screenshot = H.takeScreenshot(view: self.view)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: segueID.tutorialVC ) as! TutorialVC
        vc.screenshot = screenshot
        vc.VCTitle = segueID.tipVC
        self.present(vc, animated: false, completion: nil)
    }
    
    func addSwipeLeft(){
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipe.direction = .left
        self.view.addGestureRecognizer(swipe)
    }
    
    func handleSwipe(){
        self.dismiss(animated: true, completion: nil)
    }

    
}

extension TipVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                return unlockedTips.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var i = indexPath.row
        i = ( i == 0) ? unlockedTips.count - 1: unlockedTips.count - i - 1
        print(i)
        let tuple = unlockedTips[i]
        let cell = tableView.dequeueReusableCell(withIdentifier: "TipCell") as! TipCell
        cell.configureCell(num: tuple.dayNumber, image: tuple.image, text: tuple.text)
        cell.selectionStyle = .none
        return cell
        
    }
    
    
}
