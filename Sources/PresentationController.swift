//
//  PresentationController.swift
//
//  The MIT License (MIT)
//  Copyright © 2018 DiorStone

import UIKit

/// 用于自定义presentation controller
class PresentationController: UIPresentationController {
    
    var presentType: PresentationType = .alert
    
    let contextFrameForPresentation: CGRect? = nil
    
    fileprivate lazy var backgroundView: UIView = {
        let view = UIView()
        return view
    }()
    
    fileprivate var containerFrame: CGRect {
        return contextFrameForPresentation ?? containerView?.bounds ?? CGRect()
    }
    
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        
        setupBackground(UIColor.black, backgroundOpacity: 0.7)
    }
}


fileprivate extension PresentationController {

    func setupBackground(_ backgroundColor: UIColor, backgroundOpacity: Float) {
//        let tap = UITapGestureRecognizer(target: self, action: #selector(chromeViewTapped))
//        chromeView.addGestureRecognizer(tap)

        backgroundView.backgroundColor = backgroundColor.withAlphaComponent(CGFloat(backgroundOpacity))
    }
    
    // MARK: Sizing, Position
    func getWidthFromType(_ parentSize: CGSize) -> Float {
        guard let size = presentType.size() else {
            if case .dynamic = presentType {
                return Float(presentedViewController.view.systemLayoutSizeFitting(UILayoutFittingCompressedSize).width)
            }
            return 0
        }
        return size.width.calculateWidth(parentSize)
    }
    
    func getHeightFromType(_ parentSize: CGSize) -> Float {
        guard let size = presentType.size() else {
            if case .dynamic = presentType {
                return Float(presentedViewController.view.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height)
            }
            return 0
        }
        return size.width.calculateHeight(parentSize)
    }
    
    func getCenterPointFromType() -> CGPoint? {
        let containerBounds = containerFrame
        let position = presentType.position()
        return position.calculateCenterPoint(containerBounds)
    }
    
    func getOriginFromType() -> CGPoint? {
        let position = presentType.position()
        return position.calculateOrigin()
    }
    
    func calculateOrigin(_ center: CGPoint, size: CGSize) -> CGPoint {
        let x: CGFloat = center.x - size.width / 2
        let y: CGFloat = center.y - size.height / 2
        return CGPoint(x: x, y: y)
    }
}

// MARK: UIPresentationController
extension PresentationController {
    
    override var frameOfPresentedViewInContainerView: CGRect {
        var presentedViewFrame = CGRect.zero
        let containerBounds = containerFrame
        let size = self.size(forChildContentContainer: presentedViewController, withParentContainerSize: containerBounds.size)
        
        let origin: CGPoint
        if let center = getCenterPointFromType() {
            origin = calculateOrigin(center, size: size)
        } else {
            origin = getOriginFromType() ?? CGPoint(x: 0, y: 0)
        }
        presentedViewFrame.size = size
        presentedViewFrame.origin = origin
        
        return presentedViewFrame
    }
    
    override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        let width = getWidthFromType(parentSize)
        let height = getHeightFromType(parentSize)
        return CGSize(width: CGFloat(width), height: CGFloat(height))
    }
    
    override func containerViewWillLayoutSubviews() {
        backgroundView.frame = containerFrame
        presentedView!.frame = frameOfPresentedViewInContainerView
    }
    
    // MARK: Animation
    override func presentationTransitionWillBegin() {
        guard let containerView = containerView else {
            return
        }
        backgroundView.frame = containerView.bounds
        containerView.insertSubview(backgroundView, at: 0)
        
        backgroundView.alpha = 0
        guard let coordinator = presentedViewController.transitionCoordinator else {
            backgroundView.alpha = 1.0
            return
        }
        coordinator.animate(alongsideTransition: { (context) in
            self.backgroundView.alpha = 1.0
        }, completion: nil)
    }
    
    override func dismissalTransitionWillBegin() {
        guard let coordinator = presentedViewController.transitionCoordinator else {
            backgroundView.alpha = 0.0
            return
        }
        
        coordinator.animate(alongsideTransition: { context in
            self.backgroundView.alpha = 0.0
        }, completion: nil)
    }
}
