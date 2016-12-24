//
//  InstructionDefaults.swift
//  Weitful
//
//  Created by Julia Miller on 12/8/16.
//  Copyright © 2016 Julia Miller. All rights reserved.
//

import Foundation

struct InstructionDefaults {
    let exercise: [[Int:String]] = [
        [0: "No exercise at all."],
        [1: "Did some low intensity exercise (no sweat)"],
        [2: "Did some moderate intensity exercise (light sweat)"],
        [3: "Did some high intensity exercise (heavy sweat)"],
        [4: "Am definitely going to be sore for at least 2-3 days."],
        [5: "Went overboard. My body is probably going to be sore for at least a week."]
    ]
    
    let eating: [[Int:String]] = [
        [-3: "Fasted today."],
        [-2: "Ate < 3 meals and was hungry."],
        [-1: "Only ate when I was hungry today which resulted in < 3 meals."],
        [0: "Ate 3 meals, no sweets or snacks. Was mindful while eating. Stopped when was no longer hungry."],
        [1: "Ate 3 meals and maybe a few additional sweets/snack"],
        [2: "Overate but not the point of binging. Might have been anxious about something."],
        [3: "Binged. "]
    ]
}

let tipDefaults: [[Int: String]] = {
    [[0: "Tip here"],
    [1: "Tip here"],
    [2: "Tip here"],
    [3: "Tip here"],
    [4: "Tip here"],
    [5: "Tip here"],
    [6: "Tip here"],
    [7: "Tip here"],
    [8: "Tip here"],
    [10: "Tip here"]]
}

