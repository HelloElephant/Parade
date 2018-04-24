//
//  UIScrollView+PDAnimation.swift
//  PDAnimator-Demo
//
//  Created by Anton Doudarev on 4/2/18.
//  Copyright © 2018 ELEPHANT. All rights reserved.
//

import Foundation
import UIKit

/// This swizzles methods on a specific class.
/// Note: Don't got get the call the swizzled method
/// to ensure the original selector gets called
///
/// - Parameters:
///   - cls: slass to swizzle methods in
///   - originalSelector: the original method
///   - swizzledSelector: the swizzled method
func swizzleSelector(_ cls: AnyClass!, originalSelector : Selector, swizzledSelector : Selector)
{
    let originalMethod = class_getInstanceMethod(cls, originalSelector)
    let swizzledMethod = class_getInstanceMethod(cls, swizzledSelector)
    
    method_exchangeImplementations(originalMethod!, swizzledMethod!);
}


// MARK: - UIScrollViewv - ContentOffset Swizzle
extension UIScrollView {
    
    /// Call this method to initialize the contentOffset highjacking
    final public class func initializeParade()
    {
        swizzleSelector(self,
                        originalSelector: #selector(UIScrollView.setContentOffset(_:animated:)),
                        swizzledSelector: #selector(UIScrollView.swizzledSetContentOffset(_:animated:)))
        
        swizzleSelector(self,
                        originalSelector: #selector(getter : UIScrollView.contentOffset),
                        swizzledSelector: #selector(getter : UIScrollView.swizzledContentOffset))
        
        swizzleSelector(self,
                        originalSelector: #selector(setter: UIScrollView.contentOffset),
                        swizzledSelector: #selector(UIScrollView.swizzledSetContentOffset(_:)))
    }

    /// The swizzled contentOffset property
    @objc public var swizzledContentOffset: CGPoint
        {
        get {
            return self.swizzledContentOffset // not recursive, false warning
        }
    }

    /// The swizzed ContentOffset method (2 input parameters)
    @objc public func swizzledSetContentOffset(_ contentOffset : CGPoint, animated: Bool)
    {
        swizzledSetContentOffset(contentOffset, animated: animated)
        updateViews()
    }
    
    /// The swizzed ContentOffset method (1 input setter)
    @objc public func swizzledSetContentOffset(_ contentOffset: CGPoint)
    {
        swizzledSetContentOffset(contentOffset) // not recursive
        updateViews()
    }
}

extension UIScrollView {
    
    /// This is called by the swizzled method
    func updateViews()
    {
        var views : [UIView] = [UIView]()
        
        if let collectionSelf = self as? UICollectionView
        {
            views = collectionSelf.visibleCells
        }
        else if let collectionSelf = self as? UITableView
        {
            views = collectionSelf.visibleCells
        }
        else {
            views = subviews
        }
        
        for view in views {
            
            guard let animatableObject = view as? PDAnimatableType else {
                continue
            }
            
            var progressAnimator : PDAnimator? = view.cachedProgressAnimator
            
            if progressAnimator == nil  {
                view.cachedProgressAnimator = animatableObject.configuredAnimator()
                progressAnimator = view.cachedProgressAnimator!
            }
            
            let relativeCenter = self.convert(view.center, to: UIScreen.main.coordinateSpace)
            
            switch progressAnimator!.animationDirection {
                
            case .vertical:
                
                if let progress = verticalProgress(at: relativeCenter,
                                                   to : self.bounds.height) {
                    progressAnimator!.interpolateViewAnimation(forProgress: progress)
                }
                
            case .horizontal:
                
                if let progress = horizontalProgress(at: relativeCenter,
                                                     to : self.bounds.width) {
                    progressAnimator!.interpolateViewAnimation(forProgress: progress)
                }
            }
        }
    }
}


let centerThreshHold : CGFloat = 0.0005

extension UIScrollView {
    
    internal func verticalProgress(at relativeCenter : CGPoint,
                                   to viewportHeight: CGFloat) -> PDScrollProgressType?
    {
        let relativePercent : CGFloat = relativeProgress(at: relativeCenter.y, to: viewportHeight)!

        if relativePercent < -centerThreshHold
        {
            return .verticalAboveCenter(progress : (1.0 + relativePercent))
        }
        else if relativePercent > centerThreshHold
        {
            return .verticalBelowCenter(progress : (1.0 - relativePercent))
        }
        
        return .verticalCenter
    }
    
    internal func horizontalProgress(at relativeCenter : CGPoint,
                                     to viewportWidth: CGFloat) -> PDScrollProgressType?
    {
        let relativePercent : CGFloat = relativeProgress(at: relativeCenter.x, to: viewportWidth)!
       
        if relativePercent < -centerThreshHold
        {
            return .horizontalLeftCenter(progress :  (1.0 + relativePercent))
        }
        else if relativePercent > centerThreshHold
        {
            return .horizontalRightCenter(progress : (1.0 - relativePercent))
        }

        return .horizontalCenter
    }
    
    internal func relativeProgress(at progressValue : CGFloat,
                                   to relativeValue: CGFloat) -> CGFloat? {
        
        let relativePercent = (progressValue - (relativeValue / 2.0)) / relativeValue
        
        if relativePercent == 0.0 { return  0.0 }
        if relativePercent <= -1.0 { return -1.0 }
        if relativePercent >=  1.0 { return  1.0 }
  
        return relativePercent
    }
}

