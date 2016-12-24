//
//  SplitAC.swift
//  Weitful
//
//  Created by Julia Miller on 12/22/16.
//  Copyright © 2016 Julia Miller. All rights reserved.
//

import UIKit

class SplitAC: NSObject, UIViewControllerAnimatedTransitioning {
    
    var isDismissing = false
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromV = transitionContext.view(forKey: .from),
            let toV = transitionContext.view(forKey: .to) else {fatalError()}
        let container = transitionContext.containerView
        
        let moveOffscreenLeft = CGAffineTransform(translationX: -(container.frame.width/2), y: 0)
        let moveOffscreenRight = CGAffineTransform(translationX: container.frame.width, y: 0)
        
        var rightSide: UIView!
        var leftSide: UIView!
        
        let halfSize = toV.frame.size.width/2
        let height = toV.frame.size.height
        
        let leftFrame = CGRect(x: 0, y: 0, width: halfSize, height: height)
        let rightFrame = CGRect(x: halfSize, y: 0, width: halfSize, height: height)
        let noInsets = UIEdgeInsets(top: 0,left: 0,bottom: 0,right: 0)
        
        if isDismissing {
            leftSide = toV.resizableSnapshotView(from: leftFrame, afterScreenUpdates: true, withCapInsets: noInsets)
            rightSide = toV.resizableSnapshotView(from: rightFrame, afterScreenUpdates: true, withCapInsets: noInsets)
            container.addSubview(fromV)
            container.addSubview(rightSide)
            container.addSubview(leftSide)
            container.sendSubview(toBack: fromV)
            rightSide.transform = moveOffscreenRight
            leftSide.transform = moveOffscreenLeft
        } else {
            leftSide = fromV.resizableSnapshotView(from: leftFrame, afterScreenUpdates: false, withCapInsets: noInsets)
            rightSide = fromV.resizableSnapshotView(from: rightFrame, afterScreenUpdates: false, withCapInsets: noInsets)
            container.addSubview(toV)
            container.addSubview(rightSide)
            rightSide.transform = CGAffineTransform(translationX: halfSize, y: 0)
            container.addSubview(leftSide)
            container.sendSubview(toBack: toV)
            fromV.removeFromSuperview()
        }
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            if self.isDismissing {
                rightSide.transform = CGAffineTransform(translationX: halfSize, y: 0)
                leftSide.transform = CGAffineTransform.identity
            } else {
                rightSide.transform = moveOffscreenRight
                leftSide.transform = moveOffscreenLeft
                
            }
        }, completion: { _ in
            transitionContext.completeTransition(true)
        })
    }
}
