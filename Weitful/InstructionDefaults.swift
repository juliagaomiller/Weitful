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
        [1: "Did some low intensity exercise (no sweat) for <1h. Anything 1h+ is a 2."],
        [2: "Did some moderate intensity exercise (light sweat) 0.5-1h. Anything 1h+ is a 3."],
        [3: "Did 0.75-2h of high intensity exercise (heavy sweat) or 3h+ of low intensity."],
        [4: "Did a LOT of exercise today. Maybe even the whole day. Am definitely going to be sore for at least 2-3 days."],
        [5: "Went totally overboard with the exercise today. My body is probably going to be sore for at least a week."]
    ]
    
    let eating: [[Int:String]] = [
        [-3: "Fasted today."],
        [-2: "Ate < 3 meals and was hungry."],
        [-1: "Only ate when I was hungry today which resulted in < 3 meals."],
        [0: "Ate 3 meals. Stayed mindful. Put utensil down after every bite. Stopped when was no longer hungry."],
        [1: "Ate 3 meals and maybe a few snacks. Did not stay completely mindful."],
        [2: "Snacked a little too much. Was not mindful most of the day. Might have been anxious about something."],
        [3: "Binged. Let go of self control. "]
    ]
    
}

