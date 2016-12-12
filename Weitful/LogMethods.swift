//
//  LogMethods.swift
//  Weitful
//
//  Created by Julia Miller on 11/30/16.
//  Copyright © 2016 Julia Miller. All rights reserved.
//

import Foundation
import UIKit
import CoreData

extension LogVC {
    
    func addSwipeToView(){
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(segueToMain))
        swipe.direction = .right
        self.view.addGestureRecognizer(swipe)
    }
    
    func segueToMain(){
        //calculate weight difference from previous; if weight difference += 3 lbs add alert controller;
        let vc = storyboard?.instantiateViewController(withIdentifier: "MainVC") as! MainVC
        present(vc, animated: false, completion: nil)
    }
    
    func assignActionsToKeypad(){
        for b in keypad! {
            b.addTarget(self, action: #selector(updateLabel(sender:)), for: .touchUpInside)
        }
    }
    
    func updateLabel(sender: UIButton){
        guard let info = sender.title(for: .normal) else {fatalError()}
        if info == "Clear" {
            log.weight = 0
            weightString = ""
        } else {
            weightString += info
            guard let d = Double(weightString) else {fatalError()}
            log.weight = d
        }
        delegate.saveContext()
        updateView()
    }
    
}
