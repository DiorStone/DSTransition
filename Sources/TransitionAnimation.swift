//
//  TransitionAnimation.swift
//
//  The MIT License (MIT)
//  Copyright © 2018 DiorStone

import UIKit

open class TransitionAnimation: NSObject {
    
    open func transform(containerFrame: CGRect, finalFrame: CGRect) -> CGRect {
        var initialFrame = finalFrame
        initialFrame.origin.y = containerFrame.height
        return initialFrame
    }
    
    open func beforeAnimation(using transitionContext: TransitionContext) {
        let finalFrameForVC = transitionContext.finalFrame
        let initialFrameForVC = transform(containerFrame: transitionContext.containerView.frame, finalFrame: finalFrameForVC)
        
        transitionContext.animatingView?.frame = transitionContext.isPresenting ? initialFrameForVC : finalFrameForVC
    }
    
    open func performAnimation(using transitionContext: TransitionContext) {
        let finalFrameForVC = transitionContext.finalFrame
        let initialFrameForVC = transform(containerFrame: transitionContext.containerView.frame, finalFrame: finalFrameForVC)
        
        transitionContext.animatingView?.frame = transitionContext.isPresenting ? finalFrameForVC : initialFrameForVC
    }
    
    open func afterAnimation(using transitionContext: TransitionContext) {}

}

// MARK: UIViewControllerAnimatedTransitioning

extension TransitionAnimation: UIViewControllerAnimatedTransitioning {
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.35
    }

    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let context = TransitionContext(originContext: transitionContext)
        if context.isPresenting {
            context.containerView.addSubview(context.toView!)
        }
        //Animation
        beforeAnimation(using: context)
        UIView.animate(withDuration: 0.35,
                       animations: {
            self.performAnimation(using: context)
        }) { (completed) in
            self.afterAnimation(using: context)
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
  
    public func animationEnded(_ transitionCompleted: Bool) {
        
    }
}

public struct TransitionContext {
    
    public let originContext: UIViewControllerContextTransitioning
    
    public var containerView: UIView {
        return originContext.containerView
    }
    
    public var initialFrame: CGRect {
        return originContext.initialFrame(for: (isPresenting ? toViewController : fromViewController)!)
    }

    public var finalFrame: CGRect {
        return originContext.finalFrame(for: (isPresenting ? toViewController : fromViewController)!)
    }
    
    public var isPresenting: Bool {
        return (toViewController?.presentingViewController == fromViewController)
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
        return isPresenting ? toViewController : fromViewController
    }
    
    public var animatingView: UIView? {
        return isPresenting ? toView : fromView
    }
}
