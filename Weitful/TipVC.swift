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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 60
        addSwipeLeft()
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

extension TipVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tipDefaults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let i = indexPath.row
        let tuple = tipDefaults[i]
        let cell = tableView.dequeueReusableCell(withIdentifier: "TipCell") as! TipCell
        cell.configureCell(num: tuple.dayNumber, text: tuple.text)
        return cell
    }
}
