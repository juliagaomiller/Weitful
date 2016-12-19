import Foundation
import UIKit

class SwipeDownAC: NSObject, UIViewControllerAnimatedTransitioning {
    
    var isDismissing = false
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1.0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromV = transitionContext.view(forKey: .from),
            let toV = transitionContext.view(forKey: .to) else {fatalError()}
        
        let container = transitionContext.containerView
        let moveAboveScreen = CGAffineTransform(translationX: 0, y: -(container.frame.height))
        
        container.addSubview(toV)
        container.addSubview(fromV)
        
        if !isDismissing {
            toV.transform = moveAboveScreen
            container.bringSubview(toFront: toV)
        } else {
            toV.transform = CGAffineTransform.identity
            container.bringSubview(toFront: fromV)
        }
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.3, options: .curveEaseIn, animations: {
            
            if self.isDismissing {
                fromV.transform = moveAboveScreen
            } else {
                toV.transform = CGAffineTransform.identity
            }
            
        }, completion: { _ in
            transitionContext.completeTransition(true)
            
        })
        
    }
    
}
