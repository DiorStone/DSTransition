//
//  TransitionAnimation.swift
//
//  The MIT License (MIT)
//  Copyright © 2018 DiorStone

import UIKit

protocol AnimationControllerable: UIViewControllerAnimatedTransitioning {
    
    /**
     * If the animation should be positive or negative.
     *
     * @note Positive: push / present / fromTop / toRight
     * @note Negative: pop / dismiss / fromBottom / toLeft
     */
    var isPositiveAnimation: Bool { get set }
}

open class TransitionAnimation: NSObject, AnimationControllerable {
    
    var isPositiveAnimation: Bool = false

    // MARK: UIViewControllerAnimatedTransitioning
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.35
    }

    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let context = TransitionContext(originContext: transitionContext, isPositiveAnimation: isPositiveAnimation)
        if isPositiveAnimation {
            context.containerView.addSubview(context.toView!)
        }
        //Animation
        let finalFrameForVC = context.finalFrame
        var initialFrameForVC = context.containerView.frame
        initialFrameForVC.origin.y = finalFrameForVC.height
        
        context.animatingView?.frame = isPositiveAnimation ? initialFrameForVC : finalFrameForVC
        
        UIView.animate(withDuration: 0.35,
                       animations: {
                        context.animatingView?.frame = self.isPositiveAnimation ? finalFrameForVC : initialFrameForVC
        }) { (completed) in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
  
    public func animationEnded(_ transitionCompleted: Bool) {
        
    }
}

public struct TransitionContext {
    
    public let originContext: UIViewControllerContextTransitioning
    public let isPositiveAnimation: Bool
    
    public var containerView: UIView {
        return originContext.containerView
    }
    
    public var initialFrame: CGRect {
        return originContext.initialFrame(for: (isPositiveAnimation ? toViewController : fromViewController)!)
    }

    public var finalFrame: CGRect {
        return originContext.finalFrame(for: (isPositiveAnimation ? toViewController : fromViewController)!)
    }
    
    public var fromViewController: UIViewController? {
        return originContext.viewController(forKey: UITransitionContextViewControllerKey.from)
    }
    
    public var toViewController: UIViewController? {
        return originContext.viewController(forKey: UITransitionContextViewControllerKey.to)
    }
    
    public var fromView: UIView? {
        return originContext.view(forKey: UITransitionContextViewKey.from)
    }
    
    public var toView: UIView? {
        return originContext.view(forKey: UITransitionContextViewKey.to)
    }
    
    public var animatingViewController: UIViewController? {
        return isPositiveAnimation ? toViewController : fromViewController
    }
    
    public var animatingView: UIView? {
        return isPositiveAnimation ? toView : fromView
    }
}
