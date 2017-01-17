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
        (#imageLiteral(resourceName: "munch"), "EX-COUCH POTATO", "1 day this week of +1 exercise", 1, 1),
        (#imageLiteral(resourceName: "leader") ,"LEADER", "7 days this week of >0 exercising", 7, 1),
        (#imageLiteral(resourceName: "loveMagnet") ,"LOVE MAGNET", "5 days this week of +2 exercising", 5, 2),
        (#imageLiteral(resourceName: "tornado") ,"TORNADO", "7 days this week of +2 exercising", 7, 2),
        (#imageLiteral(resourceName: "fireball") ,"FIREBALL", "1 day this week of +3 exercising", 1, 3),
        (#imageLiteral(resourceName: "olympian") ,"OLYMPIAN", "2 days this week of +3 exercising", 2, 3),
        (#imageLiteral(resourceName: "godzilla") ,"GODZILLA", "3 days this week of +3 exercising", 3, 3),
]

let tipDefaults: [(dayNumber: Int, image: UIImage, text: String)] =
    
    [
        (0,#imageLiteral(resourceName: "tip0"),"MAGIC NUMBER 5\nAccording to data from the Nike+ team and its 1.2 million users, the number of times you need to log data in order to get hooked is only FIVE times."),
        (1,#imageLiteral(resourceName: "tip1"),"IT'S A QUESTION OF MOTIVATION\nLosing weight isn't rocket science, calories in < calories out. So why is it so damn hard!? The answer, not enough motivation. Now say, what if you were given an ultimatum: If you were not able to achieve your weight goal by your deadline, you would lose all your money. Would you be motivated now? Sometimes we just need the right motivator. Online programs such as stickK.com and Coach.me help with this incentive deficit. Check them out!"),
        (2,#imageLiteral(resourceName: "tip2"),"HIGH PROTEIN BREAKFAST\nHigh protein breakfasts (e.g. 2-3 eggs) help with weight loss because the protein makes your stomach feel fuller for a good portion of the day. Great start to the day!"),
        (3,#imageLiteral(resourceName: "notes"),"PREPLAN YOUR MEALS\nMany successful dieters plan and eat the same meals over and over again until they reach their goal. Honestly it's not that hard, especially if these are healthy meals that you LIKE. I have the same breakfast everyday and love it!"),
        (4,#imageLiteral(resourceName: "tip4"),"What gets measured gets managed – Peter Drucker"),
        (5,#imageLiteral(resourceName: "tip5"),"GAIN MUSCLE TO SLIM DOWN\nBuilding up muscle may cause a little weight gain at first, but in the long run it does a great job helping speed up weight loss. This is because stronger muscles burn more calories."),
        (6,#imageLiteral(resourceName: "tip6"),"SAME TIME EACH DAY\nYour weight varies wildly throughout the day. What I like to do is to weigh myself every morning the moment I wake up so that breakfast and water intake don't skew the scales."),
        (7,#imageLiteral(resourceName: "tip7"),"LOSING WEIGHT TOO FAST\nBe careful when losing weight too fast (>3 lbs/wk). Your body may think that it is starving, which will slow down your metabolism and spike your hunger levels."),
        (8,#imageLiteral(resourceName: "tip8"),"DIFFERENT TYPES OF MEASUREMENTS\n Sometimes, your weight may not be a reliable way to gauge your progress (e.g. muscle gain, just ate breakfast, about to have period = + water intake = temporary weight gain) Other ways of assessing yourself include measuring body circumferences, taking photos, and bodyfat percentage measurements."),
        (9,#imageLiteral(resourceName: "tip9"),"MUSCULAR WOMEN\nMany women fear that if they do strength training, they will get large, bulky muscles (hypertrophy). The truth is that getting bulky muscles is surprising difficult for women. You need a LOT of protein and testosterone (note: men produce 10x more testosterone then women). What strength training WILL do is make women stronger, leaner and help with burning significantly more calories."),
        (10,#imageLiteral(resourceName: "tip10"),"SLOW-CARB DIET\n Check it out. Many success stories and easier to stick to than Paleo. I'm also coming out with app some time in the future specifically geared towards the slow-carb diet."),
        (11,#imageLiteral(resourceName: "tip11"),"BINGE DAYS\nSetting a day once a week to eat whatever you want may actually HELP with weight loss. How? It goes back to the principle mention earlier: you're body may freak out and think it's starving if it's consistently losing weight."),
        (12,#imageLiteral(resourceName: "tip12"),"WHAT YOU EAT\nWhen it comes to losing weight, what you EAT is twice as important as how much you exercise. In other words, making small changes your diet can have a much more significant impact than simply more exercise. By paying attention to portion sizes and the types of food you eat, you can even lose weight WITHOUT exercising"),
        (13,#imageLiteral(resourceName: "tip13"),"60-90 SECONDS\nSimply explained, doing some quick muscle exercises before you eat make your muscles temporarily more receptive to potential chemical energy. These leads to more of your food nutrients going to your muscle cells, versus your fat cells."),
        (14,#imageLiteral(resourceName: "tip14"),"PROBIOTICS\nProbiotics help your healthy bacteria grow and thrive. They thank you by neutralizing toxins  you have ingested and by kicking bad bacteria out of your body."),
        (15,#imageLiteral(resourceName: "tip15"),"FERMENTED FOODS\nDuring the early 1900s, Dr.Weston Price studied near-disease free indigenous communities around the world. He found that one common element was fermented foods. Fermented foods contain high levels of heathy gut bacteria which help fortify your immune system. Fermented foods: plain yogurt, cheese, kimchi, sauerkraut, kombucha tea..."),
        (16,#imageLiteral(resourceName: "tip16"),"THE 2 Cs\n Correlation does not necessarily imply causation...For instance, high or low homeless population and crime rate in the same locations tend to be positively correlated. That does not mean that one causes the other. Keep that in mind when looking at your numbers and YOUR LIFE. Life lesson: don't jump to conclusions to fast."),
        (17,#imageLiteral(resourceName: "tip17"),"EATING FRUIT & VEGGIES MYTH\nOur ancestors, the hunter-gatherers, did not eat fruit 6 days a week, every day of the year. Our bodies didn't evolve to handle so much fruit. And although fruit sugar is unarguably healthier than artificial sugar, it's all the same going to be converted to fat."),
        (18,#imageLiteral(resourceName: "tip18"),"PROTEIN\nOf all the food types, protein makes you feel full the longest. Whey, the watery part of milk that is separated from curd (used to make cheese) is a favorite among fitness professionals for increasing fat loss and muscle growth."),
        (19,#imageLiteral(resourceName: "tip19"),"DRINKING CALORIES\nA surprising number of calories come from what you drink (almond milk, orange juice...). Cutting them out of your diet should not be too hard."),
        (20,#imageLiteral(resourceName: "tip20"),"FIBERS\nSoluble fibers(can be dissolved in liquid) are carbohydrates that we cannot digest but our gut bacteria can. These bacteria reward our hospitality by fighting chronic inflammation in the body, key drivers for obesity and disease. In addition, viscous fiber (found in legumes) help reduce appetite by slowing down stomach emptying and increasing the time it takes to digest and absorb nutrients."),
        (21,#imageLiteral(resourceName: "tip21"),"GOOD NIGHT'S SLEEP\n The results from a study conducted at the University of Chicago showed that 8.5h of sleep/night (versus 5.5h sleep/night) resulted in increased fat loss. Also when you have a good night's sleep, you have more energy, clear-headedness, and motivation the next day!"),
        (22,#imageLiteral(resourceName: "tip22"),"EATING TIPS\nI've heard a story of one guy who lost weight by simply chewing each mouthful 20 times. Other strategies include: dividing a meal into three portions and drinking a cup of water between portions. Another strategy is putting down your utensil after each bite. Eating slowly gives your stomach  time to send the 'I'm full' message to your brain."),
        (23,#imageLiteral(resourceName: "tip23"),"COFFEE AND TEA\n The caffeine in coffee and tea helps you with weight loss by giving an energy boost to your metabolism as well more energy to exercise!"),
        (24,#imageLiteral(resourceName: "tip24"),"DRINK WATER BEFORE MEAL\n It's pretty simple. Your stomach has less space and you'll feel full faster."),
        (25,#imageLiteral(resourceName: "tip25"),"FLAVOR REPLACEMENTS\nFood tasting bland now that you've cut out sugar? Try adding cinnamon, vanilla, and spices to your meals to bring out more flavor!"),
        (26,#imageLiteral(resourceName: "tip26"),"AWARENESS\nBe aware of the tendency to want to just give up and eat that box of cookies whenever you 'fail' to meet your goal. Don't become a self-fulfilling prophecy"),
        (27,#imageLiteral(resourceName: "ex3"), "6 MINUTE INTENSITY\nSIX minutes of INTENSE exercise 3x/week can be just as effective as an HOUR of  activity EVERYDAY- Martin Gibala of McMaster University. Okay, that's a little ambitious, but the point is that short periods of high intensity exercises can actually be more effective than hours and hours of moderate and light exericise. Feel free to test it out yourself."),
        (28,#imageLiteral(resourceName: "tip28"), "FOUR HOUR BODY\nI owe a lot of these tips to the Four Hour Body by Tim Ferriss. Love it. His advice is much more detailed and research backed. Check it out!"),
        (29,#imageLiteral(resourceName: "tip29"), "OUT OF SIGHT OUT OF MIND\nWillpower is a depletable resource. It's a lot more effective to create an environment where your trigger foods are out of sight and reach. This will help reduce your cravings a lot."),
        (30,#imageLiteral(resourceName: "tip30"),"BEWARE OF RESTRICTING AND OVEREXERCISING\nBe careful, skipping a meal and overexercising might actually be counterproductive because it can result in you eating more later as a 'reward' for being so disciplined. Test it out yourself to see if that's what happens."),
        (31,#imageLiteral(resourceName: "tip31"), "20 LB THRESHOLD\nDid you know? On a 1-10 attractiveness scale, 20lbs of body recomposition (e.g lose 15lbs of fat, gain 15lbs of muscle) appears to be the critical threshold for going from a 6 to a 9 or 10... - The 4 Hour Body"),
        (32,#imageLiteral(resourceName: "tip32"), "RECOMP\nDesigning the best physique isn't just about losing weight. Body 'recomposition' = combination of losing weight in fat and gaining weight in muscle."),
        (33, #imageLiteral(resourceName: "tip33"), "If you liked this app, a rating would be much appreciated!"),
]

