//
//  TransitionExtensions.swift
//  Weitful
//
//  Created by Julia Miller on 12/19/16.
//  Copyright © 2016 Julia Miller. All rights reserved.
//

import Foundation
import UIKit

    //var offScreenRight and prepare for segue func are in the original vcs.
extension MainVC: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if presented.title == segueID.observationVC {
            offscreenRight.isDismissing = false
            return offscreenRight
        } else if presented.title == segueID.instructionsVC {
            swipeDownAC.isDismissing = false
            return swipeDownAC
        } else if presented.title == segueID.logVC {
            splitAC.isDismissing = false
            return splitAC
        } else if presented.title == segueID.tipVC {
            swipeLeftAC.isPresenting = true
            return swipeLeftAC
        } else {
            return nil
        }
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if dismissed.title == segueID.observationVC {
            offscreenRight.isDismissing = true
            return offscreenRight
        } else if dismissed.title == segueID.instructionsVC {
            swipeDownAC.isDismissing = true
            return swipeDownAC
        } else if dismissed.title == segueID.logVC {
            splitAC.isDismissing = true
            return splitAC
        } else if dismissed.title == segueID.tipVC {
            swipeLeftAC.isPresenting == false
            return swipeLeftAC
        } else {
            return nil
        }
    }
}

extension ObservationVC: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        offscreenRight.isDismissing = false
        return offscreenRight
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        offscreenRight.isDismissing = true
        return offscreenRight
    }
}
