//
//  ReflectVC.swift
//  Weitful
//
//  Created by Julia Miller on 11/23/16.
//  Copyright © 2016 Julia Miller. All rights reserved.
//

import UIKit

class ReflectVC: UIViewController {
    
    @IBOutlet weak var exerciseSlider: UISlider!
    @IBOutlet weak var exerciseLbl: UILabel!
    @IBOutlet weak var eatingSlider: UISlider!
    @IBOutlet weak var eatingLbl: UILabel!
    
    var sliderValue: Int!
    var dayLog: DayLog!

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        dayLog.exercise = exerciseLbl.text
        dayLog.eating = eatingLbl.text
        delegate.saveContext()
    }
    
    @IBAction func slider(slider:UISlider){
        if slider.accessibilityIdentifier == "ex"{
            exerciseLbl.text = String(Int(exerciseSlider.value))
        } else {
            eatingLbl.text = String(Int(eatingSlider.value))
        }
    }
    
    func setup(){
        if dayLog.exercise != "- -"{
            //print(dayLog.exercise!)
            exerciseSlider.value = Float(dayLog.exercise!)!
            eatingSlider.value = Float(dayLog.exercise!)!
        } else {
            exerciseSlider.value = 0
            eatingSlider.value = 0
        }
        exerciseLbl.text = String(Int(exerciseSlider.value))
        eatingLbl.text = String(Int(eatingSlider.value))
    }
}
