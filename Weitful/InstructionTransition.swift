//
//  InstructionTransition.swift
//  Weitful
//
//  Created by Julia Miller on 12/8/16.
//  Copyright © 2016 Julia Miller. All rights reserved.
//

import Foundation
import UIKit

//@objc protocol InstructionTransitionDelegate {
//    func dismiss()
//}

class InstructionTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    var duration = 0.5
    var isPresenting = false
    
    var snapShot: UIView?
    
//    var delegate: InstructionTransitionDelegate?
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromV = transitionContext.view(forKey: .from),
        let toV = transitionContext.view(forKey: .to) else {fatalError()}
        
        let container = transitionContext.containerView
        let moveDown = CGAffineTransform(translationX: 0, y: container.frame.height)
        let moveUp = CGAffineTransform(translationX: 0, y: -(container.frame.height))
        
        if isPresenting {
            toV.transform = moveUp
            container.addSubview(toV)
        }
        
        UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.3, options: .curveEaseIn, animations: {
            if self.isPresenting {
                fromV.transform = moveDown
                toV.transform = CGAffineTransform.identity
            } else {
                fromV.transform = CGAffineTransform.identity
                fromV.transform = moveUp
            }
        }, completion: {
            finished in
            transitionContext.completeTransition(true)
        })
    }
    
//    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        isPresenting = false
//        return self
//    }
//    
//    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        isPresenting = true
//        return self
//    }
    
}
