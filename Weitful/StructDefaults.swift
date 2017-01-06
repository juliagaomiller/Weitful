//
//  InstructionDefaults.swift
//  Weitful
//
//  Created by Julia Miller on 12/8/16.
//  Copyright © 2016 Julia Miller. All rights reserved.
//

import Foundation
import UIKit

struct InstructionDefaults {
    let exercise: [[Int:String]] = [
        [0: "No exercise at all."],
        [1: "Exercised a little (no sweat)"],
        [2: "Exercised a moderate amount (light sweat)"],
        [3: "Exercised a large amount (lots of sweat)"],
        [4: "Am definitely going to be sore for at least 2-3 days."],
        [5: "Went overboard. My body is probably going to be sore for at least a week."]
    ]
    
    let eating: [[Int:String]] = [
        [-3: "Fasted today."],
        [-2: "Ate < 3 meals and was hungry."],
        [-1: "Only ate when I was hungry today which resulted in < 3 meals."],
        [0: "Ate 3 modest meals. Was mindful while eating. Stopped when was no longer hungry."],
        [1: "Ate 3 meals and maybe a little extra."],
        [2: "Overate but not the point of binging. Might have been anxious about something."],
        [3: "Binged. "]
    ]
}

let eatingAchievements: [(image: UIImage, name: String, detail: String, numOfDays: Int, intensityLevel: Int)] =
    [
        (#imageLiteral(resourceName: "theRock") ,"THE ROCK", "3 days this week of +1 eating", 3, 1),
        (#imageLiteral(resourceName: "blackbelt") ,"BLACKBELT", "5 days this week of +1 eating", 5, 1),
        (#imageLiteral(resourceName: "superman") ,"SUPERHUMAN", "7 days this week of +1 eating", 7, 1),
        (#imageLiteral(resourceName: "master") ,"MASTER", "3 days this week of 0 eating", 3, 0),
        (#imageLiteral(resourceName: "spirit") ,"SPIRIT", "5 days this week of 0 eating", 5, 0),
        (#imageLiteral(resourceName: "deity") ,"DEITY", "7 days this week of 0 eating", 7, 0),
        (#imageLiteral(resourceName: "monk") ,"MONK", "1 day of fasting", 1, -3)
]

//have to make sure that "leader" has a special method
let exercisingAchievements: [(image: UIImage, name: String, detail: String, numOfDays: Int, intensityLevel: Int)] =
    [
        (#imageLiteral(resourceName: "ex2") ,"MARATHONER", "3 days this week of +2 exercising", 3,2),
        (#imageLiteral(resourceName: "leader") ,"LEADER", "7 days this week of >0 exercising", 7, 1),
        (#imageLiteral(resourceName: "loveMagnet") ,"LOVE MAGNET", "5 days this week of +2 exercising", 5, 2),
        (#imageLiteral(resourceName: "tornado") ,"TORNADO", "7 days this week of +2 exercising", 7, 2),
        (#imageLiteral(resourceName: "fireball") ,"FIREBALL", "1 day this week of +3 exercising", 1, 3),
        (#imageLiteral(resourceName: "olympian") ,"OLYMPIAN", "2 days this week of +3 exercising", 2, 3),
        (#imageLiteral(resourceName: "godzilla") ,"GODZILLA", "3 days this week of +3 exercising", 3, 3),
]

let tipDefaults: [(dayNumber: Int, text: String)] =
    [
        (30, "WHEY\n"),
        (29, "OUT OF SIGHT OUT OF MIND"),
        (28, "2-3 LBS/WEEK\n"),
        (27, "6 MINUTE INTENSITY\nSix minutes of pure, hard exercise three times a week can be just as effect an an hour of daily moderate activity - Martin Gibala of McMaster University. Okay, that's a little ambitious, but the point is that short periods high intensity exercises help build up your calorie burning muscles much faster than extended periods of moderate intensity exercise."),
        (26,"AWARENESS\nbe aware of that tendency of wanting to completely fall off the wagon and eat that box of cookies whenever your weight goes up and you spent the whole prior working your ass off! Don't become a self-fulfilling prophecy"),
        (25,"FLAVOR REPLACEMENTS\nFood tasting bland now that you've cut out sugar? Try adding cinnamon, vanilla, and spices to your meals to bring out more flavor!"),
        (24,"DRINK WATER BEFORE MEAL\n It's pretty simple. Your stomach has less space and you'll feel full faster."),
        (23,"COFFEE AND TEA\n The caffeine in coffee and tea helps you with weight loss/// "),
        (22,"EATING TIPS\nOne guy lost weight chew 20x, divide meal into three portions and drink water in between, put for down every bite. It helps to remember to do this every once in awhile. Eating slowly gives your stomach the time to inform your brain that it is full."),
        (21,"GOOD NIGHT'S SLEEP\n The results from a study conducted at the University of Chicago showed that 8.5h of sleep/night (versus 5.5h sleep/night) resulted increased fat loss. Also when you have a good night's sleep, you have more energy, clear-headedness, and motivation during the day to make decisions that further you towards your goal."),
        (20,"FIBERS\nSoluble fibers(can be dissolved in liquid) are carbohydrates that we cannot digest but our gut bacteria can. These bacteria in turn reward us by fighting chronic inflammation in our body, key drivers for obesity and disease. In addition, viscous fiber (found in legumes) helps reduce  appetite by slowing down stomach emptying and increasing the time it takes to digest and absorb nutrients."),
        (19,"DRINKING CALORIES\nA surprising number of calories comes what you drink (almond milk, orange juice...). Cutting them out of your diet is also not too hard (compared to cutting out certain foods)."),
        (18,"PROTEIN\nOf all the food types, protein makes you feel full the longest."),
        (17,"FRUITY DANGERS\nOur ancestors, the hunter-gatherers, did not eat fruit 6 days a week, every day of the year. Our bodies didn't evolve to handle so much fruit. And although fruit sugar is unarguably healthier than candy sugar, it's nevertheless eventually going to be converted to fat."),
        (16,"PREPLAN YOUR MEALS\nMany successful dieters plan and eat the same meals over and over again until they reach their goal. Honestly it's not that hard, especially if these are healthy meals that you LIKE. I have the same breakfast everyday and I love it."),
        (15,"FERMENTED FOODS\nDuring the early 1900s, Dr.Weston Price studied near-disease free indigenous communities around the world. He found that one common element was fermented foods. Fermented foods contain high levels of heathy gut bacteria which help fortify your immune system. Fermented foods: plain yogurt, cheese, kimchi, sauerkraut, kombucha tea...And yes, alchohol is obtained through fermentation, but it's a different kind of fermentation. So no, alchoholic drink do not have these same properties."),
        (14,"PROBIOTICS\nProbiotics help your healthy bacteria grow and thrive. They will thank you for that by neutralizing toxins that you have ingested and by keeping bad bacteria out of your body"),
        (13,"60-90 SECONDS\nSimply explain, doing some quick muscle exercises before you eat makes them temporarily more receptive to the nutrients you will be ingesting. This results in more of potential energy from your food becoming stored in your muscle cells instead of your fat cells."),
        (12,"HIGH PROTEIN BREAKFAST\nHigh protein breakfasts (e.g. 2-3 eggs) help you lose weight because the protein makes you feel full for the majority of the day. It's a great start to the day."),
        (11,"BINGE DAYS\nSetting a day once a week to eat whatever you want may actually HELP with weight loss. How? It goes back to the same principle: if your body is consistently losing weight, it may think that it is slowly starving and in response, slow down your metabolism. Eating a whole bunch of food at once reassures your body that it is not, in fact, starving."),
        (10,"SLOW-CARB DIET\n Check it out. Many success stories and easier to stick to than Paleo."),
        (9,"GAIN MUSCLE TO SLIM DOWN\nBuilding up muscle may cause weight gain at first, but in the long run it will speed up weight loss because  muscle burns more calories, giving you a faster metabolism."),
        (8,"DIFFERENT TYPES OF MEASUREMENTS\n Sometimes, your weight may not be a reliable way to gauge your progress (e.g. muscle gain, just ate breakfast, about to have period = + water intake = temporary weight gain) Other ways of assessing yourself include measuring body circumferences, taking photos, and bodyfat percentage measurements."),
        (7,"LOSING WEIGHT TOO FAST\nBe careful when losing weight too fast (>3 lbs/wk). Your body may think that it is starving, which will slow down your metabolism and spike your hunger levels."),
        (6,"20 LB THRESHOLD\nDid you know? On a 1-10 attractiveness scale, 20lbs of body recomposition (e.g lose 15lbs of fat, gain 15lbs of muscle) appears to be the critical threshold for going from a 6 to a 9 or 10... - The 4 Hour Body"),
        (5,"RECOMP\nDesigning the best physique isn't just about losing weight. Body 'recomposition' = combination of losing weight in fat and gaining weight in muscle."),
        (4,"What gets measured gets managed – Peter Drucker"),
        (3,"THE 2 Cs\n Correlation does NOT imply causation...Keep that in mind when looking at your numbers."),
        (2,"WHAT YOU EAT\nWhen it comes to losing weight, what you EAT is twice as important as how much you exercise. By paying attention to portion sizes and the types of food you eat, you can lose weight without even exercising"),
        (1,"IT'S A QUESTION OF MOTIVATION\nLosing weight isn't rocket science, calories in < calories out. So why is it so damn hard!? The answer, not enough motivated. Now say, what if, if you were not able to achieve your (accomplishable) weight goal by your deadline, you would lose all the money you currently have. Would you be motivated now? Sometimes we just need the right motivator."),
        (0,"MAGIC NUMBER 5\nAccording to data from the Nike+ team and its 1.2 million users, the number of times you need to log data in order to get hooked is only five times.")
        
        //quote for the entire app – DISPASSIONATE SELF ASSESSMENT\nAt the individual level Swaraj is vitally connected with the capacity for dispassionate self-assessment, ceaseless self-purification & growing self-reliance... It is Swaraj when we learn to rule ourselves – Mahatma Ghandi
]

