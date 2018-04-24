//
//  UIScrollView+SK.swift
//  
//
//  Created by Anton Doudarev on 4/2/18.
//

import Foundation
import UIKit

internal func swizzleSelector(_ cls: AnyClass!, originalSelector : Selector, swizzledSelector : Selector) {
    
    let originalMethod = class_getInstanceMethod(cls, originalSelector)
    let swizzledMethod = class_getInstanceMethod(cls, swizzledSelector)
    
    let didAddMethod = class_addMethod(cls, originalSelector, method_getImplementation(swizzledMethod!), method_getTypeEncoding(swizzledMethod!))
    
    if didAddMethod {
        class_replaceMethod(cls, swizzledSelector, method_getImplementation(originalMethod!), method_getTypeEncoding(originalMethod!))
    } else {
        method_exchangeImplementations(originalMethod!, swizzledMethod!);
    }
}

var executedSwizzle = false

extension UIScrollView {
    
    struct Static {
        static var token: Int = 0
    }
    
    final public class func swizzleSetValue()
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
    @objc internal func swizzledSetContentOffset(_ contentOffset : CGPoint, animated: Bool) {
        updateViews()
        swizzledSetContentOffset(contentOffset, animated: animated)
    }
    
    
    @objc internal func swizzledSetContentOffset(_ contentOffset: CGPoint) {
        updateViews()
        swizzledSetContentOffset(contentOffset) // not recursive
    }
    
    func updateViews() {
        
        for view in subviews {
            
            let viewFrame =  self.convert(view.bounds, from: view)
            
            guard let animatableObject = view as? SKAnimatableType,
                viewFrame.intersects(self.bounds) else {
                    continue
            }
            
            let relativeCenter = self.convert(view.center, to: UIScreen.main.coordinateSpace)
            
            if let progress = verticalProgress(at: relativeCenter,
                                               to : self.bounds.height)
            {
                animatableObject.progressAnimator?.interpolateAnimation(forProgress: progress)
            }
            
            switch animatableObject.animatorDirection {
            case .vertical:
                
                if let progress = verticalProgress(at: relativeCenter,
                                                   to : self.bounds.height)
                {
                    animatableObject.progressAnimator?.interpolateAnimation(forProgress: progress)
                }
                
            case .horizontal:
                
                if let progress = horizontalProgress(at: relativeCenter,
                                                     to : self.bounds.height)
                {
                    animatableObject.progressAnimator?.interpolateAnimation(forProgress: progress)
                }
                
            case .multiDirectional:
                
                if let progress = multiDirectionProgress(at: relativeCenter,
                                                         to : self.bounds.size)
                {
                    animatableObject.progressAnimator?.interpolateAnimation(forProgress: progress)
                }
            }
        }
    }
    
    @objc var swizzledContentOffset: CGPoint {
        get {
            return swizzledContentOffset // not recursive, false warning
        }
    }
}

extension UIScrollView {
    
    internal func verticalProgress(at relativeCenter : CGPoint,
                                   to screenWidth: CGFloat) -> SKScrollProgress? {
        
        let relativePercent : CGFloat = relativeProgress(at: relativeCenter.y, to: screenWidth)!
        let centerThreshHold : CGFloat = 0.0005
        if relativePercent < -centerThreshHold {
            return .verticalAboveCenter(progress : (1.0 + relativePercent))
        } else if relativePercent > centerThreshHold {
            return .verticalBelowCenter(progress : (1.0 - relativePercent))
        } else if relativePercent > -centerThreshHold && relativePercent < centerThreshHold {
            return .verticalCenter
        }
        
        return nil
    }
    
    internal func horizontalProgress(at relativeCenter : CGPoint,
                                     to screenHeight: CGFloat) -> SKScrollProgress? {
        
        let relativePercent : CGFloat = relativeProgress(at: relativeCenter.x, to: screenHeight)!
        let centerThreshHold : CGFloat = 0.0005
        if relativePercent < -centerThreshHold {
            return .horizontalLeftCenter(progress :  (1.0 + relativePercent))
        } else if relativePercent > centerThreshHold {
            return .horizontalRightCenter(progress : (1.0 - relativePercent))
        } else if relativePercent > -centerThreshHold && relativePercent < centerThreshHold {
            return .horizontalCenter
        }
        
        return nil
    }
    
    internal func multiDirectionProgress(at relativeCenter : CGPoint,
                                         to screenSize: CGSize,
                                         inverted : Bool = false) -> SKScrollProgress? {
        
        guard let horizontalProgress = horizontalProgress(at: relativeCenter, to: screenSize.width),
            let verticalProgress = verticalProgress(at: relativeCenter, to: screenSize.height) else {
                return nil
        }
        
        return SKScrollProgress.directionalProgress(horizontal: horizontalProgress, vertical: verticalProgress)
    }
    
    internal func relativeProgress(at progressValue : CGFloat,
                                   to screenWidth: CGFloat) -> CGFloat? {
        
        let relativePercent = (progressValue - (screenWidth / 2.0)) / screenWidth
        
        if relativePercent == 0.0 { return  0.0 }
        if relativePercent <= -1.0 { return -1.0 }
        if relativePercent >=  1.0 { return  1.0 }
        
        return relativePercent
    }
}
