//
//  PresentationController.swift
//
//  The MIT License (MIT)
//  Copyright © 2018 DiorStone

import UIKit

class PresentationController: UIPresentationController {
    
    let contextFrameForPresentation: CGRect? = nil
    
    fileprivate var containerFrame: CGRect {
        return contextFrameForPresentation ?? containerView?.bounds ?? CGRect()
    }
    
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
    }
}

// MARK: UIPresentationController
extension PresentationController {
    
    override var frameOfPresentedViewInContainerView: CGRect {
        var presentedViewFrame = CGRect.zero
        let containerBounds = containerFrame
        let size = self.size(forChildContentContainer: presentedViewController, withParentContainerSize: containerBounds.size)
        
        return super.frameOfPresentedViewInContainerView
    }
    
    override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        return parentSize
    }
    
    override func containerViewWillLayoutSubviews() {
        
    }
    
    // MARK: Animation
    override func presentationTransitionWillBegin() {
        guard let containerView = containerView else {
            return
        }
    }
    
    override func dismissalTransitionWillBegin() {
        
    }
}
