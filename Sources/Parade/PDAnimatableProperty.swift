//
//  PDAnimatableProperty.swift
//  PDAnimator
//
//  Created by Anton Doudarev on 4/3/18.
//  Copyright © 2018 ELEPHANT. All rights reserved.
//

import Foundation
import UIKit

internal enum PDPropertyType : Int {
    case viewValue, layerValue
}

internal enum PDValueType : Int {
    case cgFloat, cgPoint, cgSize, cgRect, cgTransform, cgColor, uiColor, caTransform3d
}

/**
 *  This is a property state that tracks the key, value, easing, and range
 **/
public class PDAnimatableProperty
{
    
    /// The KVC property key
    internal var propertyKey     : String?
    
    
    /// The value for the property
    internal var propertyValue   : Any? {
        didSet
        {
            configureValueType()
        }
    }

    
    /// The Range to interpolate between
    internal var propertyRange   : ClosedRange<CGFloat> = 0.0...1.0
    
    
    /// The value type of the property, to ensure we are not
    //  attempting to guess what type it is while interpolating
    internal var valueType       : PDValueType = .cgFloat
    

    /// The type of value this appliesto, views or layers
    internal var propertyType    : PDPropertyType = .viewValue
    
    
    /// The easing to apply to the interpolation progress
    internal var propertyEasing  : PDEasing = .linear
    

    /// This method interpolates to a target value from the
    /// peroperty value defined in this instance
    ///
    /// - Parameters:
    ///   - view: the view to apply the progress value to
    ///   - value: the value that this property state is interpolating to
    ///   - progress: the progress to apply between this states values, and the to value
    func adjustProgress(forView view: UIView, toValue value : Any?, progress: CGFloat)
    {
        if let propertyKey = propertyKey, let finalValue = value
        {
            var rangeProgress : CGFloat =  PDAnimatableProperty.adjustedRangeProgress(range : propertyRange, progress : progress)
            rangeProgress = propertyEasing.parametricProgress(rangeProgress)
            
            /**
             *  Although the following code block looks messy, is is much more efficient than the alternative.
             *  Due to the fact that KVC returns NSValue, NSPoint, NSNumber, or NSConcreteValue instances, it's not
             *  always easy to figure out exactly what the value is. Unwrapping by casting appears to be
             *  the most efficient approach here.
             **/
            
            var adjustedValue : Any?
            
            switch valueType {
            case .cgFloat:
                if let fromValue = propertyValue as? CGFloat,
                    let finalValue = finalValue as? CGFloat
                {
                    adjustedValue = fromValue.progressValue(to: finalValue, atProgress: rangeProgress)
                }
            case .cgPoint:
                if let fromValue = propertyValue as? CGPoint,
                    let finalValue = finalValue as? CGPoint
                {
                    adjustedValue = fromValue.progressValue(to: finalValue, atProgress: rangeProgress)
                }
            case .cgSize:
                if let fromValue = propertyValue as? CGSize,
                    let finalValue = finalValue as? CGSize
                {
                    adjustedValue = fromValue.progressValue(to: finalValue, atProgress: rangeProgress)
                }
            case .cgRect:
                if let fromValue = propertyValue as? CGRect,
                    let finalValue = finalValue as? CGRect
                {
                    adjustedValue = fromValue.progressValue(to: finalValue, atProgress: rangeProgress)
                }
            case .cgTransform:
                if let fromValue = propertyValue as? CGAffineTransform,
                    let finalValue = finalValue as? CGAffineTransform
                {
                    adjustedValue = fromValue.progressValue(to: finalValue, atProgress: rangeProgress)
                }
            case .cgColor:
                if CFGetTypeID(propertyValue as AnyObject) == CGColor.typeID &&
                    CFGetTypeID(finalValue as AnyObject) == CGColor.typeID
                {
                    adjustedValue = (propertyValue as! CGColor).progressValue(to: (finalValue as! CGColor), atProgress: rangeProgress)
                }
            case .uiColor:
                if let fromValue = propertyValue as? UIColor,
                    let finalValue = finalValue as? UIColor
                {
                    adjustedValue = fromValue.progressValue(to: finalValue, atProgress: rangeProgress)
                }
            case .caTransform3d:
                if let fromValue = propertyValue as? CATransform3D,
                    let finalValue = finalValue as? CATransform3D
                {
                    adjustedValue = fromValue.progressValue(to: finalValue, atProgress: rangeProgress)
                }
            }

            if let adjustedValue = adjustedValue
            {
                if propertyType == .viewValue
                {
                    view.setValue(adjustedValue, forKey: propertyKey)
                }
                else if propertyType == .layerValue
                {
                    // This is an exception, cecause the view, and layer, have the same 'transform'
                    // property name, but they are different type (CGAffineTransform/CATransform3D)
                    
                    if propertyKey == "transform3D"
                    {
                        view.layer.setValue(adjustedValue, forKey: "transform")
                    }
                    else
                    {
                        view.layer.setValue(adjustedValue, forKey: propertyKey)
                    }
                }
            }
        }
    }
    
    static func adjustedRangeProgress(range : ClosedRange<CGFloat>, progress: CGFloat) -> CGFloat
    {
        if range == 0.0...1.0 {
            return progress
        }
        
        if progress >= range.upperBound
        {
            return 1.0
        }
        else if progress <= range.lowerBound
        {
            return 0.0
        }
        
        let boundingRange = range.upperBound - range.lowerBound
        let boundingProgress = progress - range.lowerBound
        
        let adjustedProgress = boundingProgress / boundingRange
        return adjustedProgress
    }
    
    fileprivate func configureValueType()
    {
        if let _ = propertyValue as? CGFloat
        {
            valueType = .cgFloat
        }
        else if let _ = propertyValue as? CGPoint
        {
            valueType = .cgPoint
        }
        else if let _ = propertyValue as? CGSize
        {
            valueType = .cgSize
        }
        else if let _ = propertyValue as? CGRect
        {
            valueType = .cgRect
        }
        else if let _ = propertyValue as? UIColor
        {
            valueType = .uiColor
        }
        else if CFGetTypeID(propertyValue as AnyObject) == CGColor.typeID
        {
            valueType = .cgColor
        }
        else if let _ = propertyValue as? CGAffineTransform
        {
            valueType = .cgTransform
        }
        else if let _ = propertyValue as? CATransform3D
        {
            valueType = .caTransform3d
        }
    }
}
