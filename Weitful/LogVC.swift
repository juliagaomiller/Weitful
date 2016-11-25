//
//  LogVC.swift
//  Weitful
//
//  Created by Julia Miller on 11/23/16.
//  Copyright © 2016 Julia Miller. All rights reserved.
//

import UIKit

class LogVC: UIViewController {
    
    @IBOutlet weak var displayLbl: UILabel!
    
    @IBOutlet var keypad: Array<UIButton>?
    
    var dayLog: DayLog!
    
    var weightString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if weightString != "" {
          dayLog.weight = weightString
            delegate.saveContext()
        }
    }
    
    func setUp(){
        for b in keypad! {
            b.addTarget(self, action: #selector(updateLabel(sender:)), for: .touchUpInside)
        }
    }
    
    func updateLabel(sender: UIButton){
        guard let info = sender.title(for: .normal) else {
            fatalError()
        }
        if info == "Clear" {
            weightString = ""
            displayLbl.text = "- - lbs"
        } else {
            weightString += info
            displayLbl.text = weightString + " lbs"
            print("weightString is now \(weightString)")
        }
        
        
    }
}
