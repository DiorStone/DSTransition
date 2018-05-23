//
//  Presenter.swift
//
//  The MIT License (MIT)
//  Copyright © 2018 DiorStone

import UIKit

@objc(BocoPresentConfig)
open class PresentConfig: NSObject {
    /// 显示动画
    var transitionAnimation: TransitionAnimation?
    /// 隐藏动画
    var dismissTransitionAnimation: TransitionAnimation?
    
    public override required init() {
        super.init()
    }
}

/// Present配置类
@objc(BocoPresenter)
public class Presenter: NSObject {
    
    public var transitionType: TransitionType? {
        didSet {
            transitionAnimation = transitionType?.animation()
        }
    }
    public var dismissTransitionType: TransitionType? {
        didSet {
            transitionAnimation = transitionType?.animation()
        }
    }
    
    @objc public var configer: PresentConfig?
    /// 显示动画
    @objc public var transitionAnimation: TransitionAnimation?
    
    /// 隐藏动画
    @objc public var dismissTransitionAnimation: TransitionAnimation?
    
    /// 背景色
    @objc public var backgroundColor: UIColor = UIColor.black.withAlphaComponent(0.7)
    
    public override init() {}
    
    public func configer<T: PresentConfig>(_ setting: ((_ config: T) -> Void) = {_ in}){
        self.configer = T()
        setting(self.configer as! T)
    }
}

//MARK: UIViewControllerTransitioningDelegate
extension Presenter: UIViewControllerTransitioningDelegate {
    
    public func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return PresentationController(presentedViewController: presented, presenting: presenting)
    }
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transitionAnimation?.isPositiveAnimation = true
        return transitionAnimation
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transitionAnimation?.isPositiveAnimation = false
        return dismissTransitionAnimation
    }
}
