//
//  NewObservationVC.swift
//  Weitful
//
//  Created by Julia Miller on 12/11/16.
//  Copyright © 2016 Julia Miller. All rights reserved.
//

import UIKit
import CoreData

class NewObservationVC: UIViewController {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var isNegative: UIButton!
    @IBOutlet weak var isPositive: UIButton!
    @IBOutlet weak var clearDoneStack: UIStackView!
    
    let context = delegate.persistentContainer.viewContext
    let defaultIsPositive = true
    let smallFontSize: CGFloat = 40
    let largeFontSize: CGFloat = 90
    
    
    var type: Type!
    var observation: Observation!
    var backgroundColor: UIColor!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    func setUp(){
        
        textView.becomeFirstResponder()
        createObservation()
        toggleSymbols(plus: defaultIsPositive)
    }
    
    func setBackgroundColor(){
        self.view.backgroundColor = observation.color
    }
    
    @IBAction func symbolPressed(btn: UIButton){
        if btn.currentTitle == "+" {plusPressed()}
        else {minusPressed()}
    }
    
    @IBAction func donePressed(_ sender: Any) {
        textView.resignFirstResponder()
        if textView.text != "" {
            observation.text = textView.text
            delegate.saveContext()
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func clearPressed (btn: UIButton){
        textView.text = ""
    }
    
    func createObservation(){
        observation = Observation(text: "", type: type, isPositive: defaultIsPositive, context: context)
    }
    
    func toggleSymbols(plus: Bool){
        let neg: CGFloat!
        let pos: CGFloat!
        if plus {
            observation.isPositive = true
            neg = smallFontSize
            pos = largeFontSize
        } else {
            observation.isPositive = false
            neg = largeFontSize
            pos = smallFontSize
        }
        isNegative.titleLabel?.font = UIFont.systemFont(ofSize: neg)
        isPositive.titleLabel?.font = UIFont.systemFont(ofSize: pos)
        
        self.view.backgroundColor = observation.color
    }
    
    func plusPressed(){
        toggleSymbols(plus: true)
        observation.isPositive = true
        
    }
    
    func minusPressed(){
        toggleSymbols(plus: false)
        observation.isPositive = false
        
    }
    
    
    

}
