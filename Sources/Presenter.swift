//
//  Presenter.swift
//
//  The MIT License (MIT)
//  Copyright © 2018 DiorStone

import UIKit


public class Presenter: NSObject {
    
    public var presentAnimation: TransitionAnimation = TransitionAnimation()
    public var dismissAnimation: TransitionAnimation = TransitionAnimation()
    
    public override init() {}
    
    public func presentViewController(presentingViewController presentingVC: UIViewController,
                                      presentedViewController presentedVC: UIViewController,
                                      animated: Bool = true,
                                      completion: (() -> Void)? = nil) {
        presentedVC.transitioningDelegate = self
        presentedVC.modalPresentationStyle = .custom
        presentingVC.present(presentedVC, animated: animated, completion: completion)
    }
}

extension Presenter: UIViewControllerTransitioningDelegate {
    
    public func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return PresentationController(presentedViewController: presented, presenting: presenting)
    }
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return presentAnimation
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return dismissAnimation
    }
}
