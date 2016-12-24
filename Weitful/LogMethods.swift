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
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeRight.direction = .right
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeRight)
        self.view.addGestureRecognizer(swipeLeft)
    }
    
    func handleSwipe(){
        self.dismiss(animated: true, completion: nil)
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
