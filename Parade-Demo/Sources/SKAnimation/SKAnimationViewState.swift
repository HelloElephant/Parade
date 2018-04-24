//
//  SKAnimationViewState.swift
//  ScrollWeaver-Demo
//
//  Created by Anton Doudarev on 3/22/18.
//  Copyright © 2018 ELEPHANT. All rights reserved.
//

import Foundation
import UIKit

public class SKAnimationViewState {
    
    var properties : [SKAnimationViewStateProperty] = [SKAnimationViewStateProperty]()
    
    func adjustProgress(forView view: UIView, toState state : SKAnimationViewState, progress: CGFloat) {
        
        for property in properties
        {
            guard let propertyKey = property.propertyKey else {
                continue
            }
            
            let toValue = state.properties.filter {$0.propertyKey! == propertyKey }.first?.propertyValue
            
            property.adjustProgress(forView: view, toValue : toValue, progress: progress)
        }
    }
}

public class SKAnimationViewStateProperty {
    
    public var propertyKey     : String?
    public var propertyValue   : Any?
    public var propertyRange   : ClosedRange<CGFloat> = 0...1.0
    public var propertyEasing  : SKAnimationEasing = .linear
    
    func adjustProgress(forView view: UIView, toValue value : Any?, progress: CGFloat) {
        
        guard let propertyKey = propertyKey, let value = value else {
            return
        }
        
        var rangeProgress : CGFloat =  propertyEasing.parametricProgress(progress)
        
        if  progress > propertyRange.lowerBound && progress < propertyRange.upperBound {
            
            let diff = propertyRange.upperBound - propertyRange.lowerBound
            
            let adjustedProgress =  progress <= propertyRange.lowerBound ? 0.0 : abs((progress - propertyRange.lowerBound) / diff)
            
            rangeProgress = propertyEasing.parametricProgress(adjustedProgress)
        }
        else if progress > propertyRange.upperBound {
            rangeProgress = 1.0
        } else if progress < propertyRange.lowerBound {
            rangeProgress = 0.0
        }
        
        if let fromValue = propertyValue as? CGFloat,
            let toValue = value as? CGFloat
        {
            let adjustedValue = fromValue.progressValue(to: toValue, atProgress: rangeProgress)
            view.setValue(adjustedValue, forKey: propertyKey)
        }
        
        if let fromValue = propertyValue as? CGPoint,
            let toValue = value as? CGPoint {
            
            let adjustedValue = fromValue.progressValue(to: toValue, atProgress: rangeProgress)
            
            view.setValue(adjustedValue, forKey: propertyKey)
        }
        
        if let fromValue = propertyValue as? CGSize,
            let toValue = value as? CGSize {
            
            let adjustedValue = fromValue.progressValue(to: toValue, atProgress: rangeProgress)
            
            view.setValue(adjustedValue, forKey: propertyKey)
        }
        
        if let fromValue = propertyValue as? CGRect,
            let toValue = value as? CGRect {
            
            let adjustedValue = fromValue.progressValue(to: toValue, atProgress: rangeProgress)
            
            view.setValue(adjustedValue, forKey: propertyKey)
        }
        
        
        if let fromValue = propertyValue as? UIColor,
            let toValue = value as? UIColor {
            
            let adjustedValue = fromValue.progressValue(to: toValue, atProgress: rangeProgress)
            
            view.setValue(adjustedValue, forKey: propertyKey)
        }
        
        if let fromValue = propertyValue as? CGAffineTransform,
            let toValue = value as? CGAffineTransform {
            
            let adjustedValue = fromValue.progressValue(to: toValue, atProgress: rangeProgress)
            
            view.setValue(adjustedValue, forKey: propertyKey)
        }
    }
}
