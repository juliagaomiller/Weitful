//
//  OffScreenRightAC.swift
//  Weitful
//
//  Created by Julia Miller on 12/19/16.
//  Copyright © 2016 Julia Miller. All rights reserved.
//

import Foundation
import UIKit

class OffScreenRightAC: NSObject, UIViewControllerAnimatedTransitioning {
    
    var isDismissing = false
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromV = transitionContext.view(forKey: .from),
            let toV = transitionContext.view(forKey: .to) else {fatalError()}
        
        let container = transitionContext.containerView
        
        let moveOffscreenLeft = CGAffineTransform(translationX: -(container.frame.width), y: 0)
        let moveOffscreenRight = CGAffineTransform(translationX: container.frame.width, y: 0)
        
        container.addSubview(fromV)
        container.addSubview(toV)
        
        if isDismissing {
            print("isDismissing")
            toV.transform = moveOffscreenLeft
        } else {
            print("isPresenting")
            toV.transform = moveOffscreenRight
        }

        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            toV.transform = CGAffineTransform.identity
            if self.isDismissing {
                fromV.transform = moveOffscreenRight
            } else {
                fromV.transform = moveOffscreenLeft
            }
        }, completion: { _ in
            transitionContext.completeTransition(true)
        })
    }
    
}
