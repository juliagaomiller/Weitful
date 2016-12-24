//
//  SwipeLeft.swift
//  Weitful
//
//  Created by Julia Miller on 12/24/16.
//  Copyright © 2016 Julia Miller. All rights reserved.
//

import UIKit

class SwipeLeftAC: NSObject, UIViewControllerAnimatedTransitioning {
    
    var isPresenting = true
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromV = transitionContext.view(forKey: .from),
            let toV = transitionContext.view(forKey: .to) else {fatalError()}
        
        let container = transitionContext.containerView
        
        let moveOffscreenLeft = CGAffineTransform(translationX: -(container.frame.width), y: 0)
        let moveOffscreenRight = CGAffineTransform(translationX: container.frame.width, y: 0)
        
        container.addSubview(fromV)
        container.addSubview(toV)
        
        if isPresenting {
            toV.transform = moveOffScreenLeft
        } else {
            toV.transform = moveOffscreenRight
        }
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            toV.transform = CGAffineTransform.identity
            if self.isPresenting {
                fromV.transform = moveOffscreenRight
            } else {
                fromV.transform = moveOffscreenLeft
            }
        }, completion: { _ in
            transitionContext.completeTransition(true)
        })
    }
}
