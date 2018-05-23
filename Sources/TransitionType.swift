//
//  TransitionType.swift
//  DSTransition
//
//  Created by DaiLingchi on 2018/5/23.
//  Copyright © 2018年 DiorStone. All rights reserved.
//

import Foundation

public enum TransitionType {
    
    case crossDissolve
    case coverVertical
    case coverVerticalFromTop
    case coverHorizontalFromRight
    case coverHorizontalFromLeft
    case flipHorizontal
//    case coverFromCorner(Corner)
    case custom(TransitionAnimation)
    
    /// Associates a custom transition type to the class responsible for its animation.
    ///
    /// - Returns: PresentrAnimation subclass which conforms to 'UIViewControllerAnimatedTransitioning' to be used for the animation transition.
    func animation() -> TransitionAnimation {
        return TransitionAnimation()
//        switch self {
//        case .crossDissolve:
//            return CrossDissolveAnimation()
//        case .coverVertical:
//            return CoverVerticalAnimation()
//        case .coverVerticalFromTop:
//            return CoverVerticalFromTopAnimation()
//        case .coverHorizontalFromRight:
//            return CoverHorizontalAnimation(fromRight: true)
//        case .coverHorizontalFromLeft:
//            return CoverHorizontalAnimation(fromRight: false)
//        case .coverFromCorner(let corner):
//            return CoverFromCornerAnimation(corner: corner)
//        case .flipHorizontal:
//            return FlipHorizontalAnimation()
//        case .custom(let animation):
//            return animation
//        }
    }
}
