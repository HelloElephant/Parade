//
//  PDAnimatablePropertyMaker.swift
//  PDAnimator-Demo
//
//  Created by Anton Doudarev on 4/3/18.
//  Copyright © 2018 ELEPHANT. All rights reserved.
//

import Foundation
import UIKit

public class PDAnimatablePropertyMaker
{    
    internal var propertyKey     : String?
    internal var propertyValue   : Any?
    internal var propertyRange   : ClosedRange<CGFloat> = 0...1.0
    internal var propertyEasing  : PDEasing = .linear
    internal var propertyType       : PDPropertyType = .viewValue
    
    internal func constructedPropertyState() -> PDAnimatableProperty
    {
        let propertyState = PDAnimatableProperty()
        propertyState.propertyKey    = propertyKey
        propertyState.propertyValue  = propertyValue
        propertyState.propertyRange  = propertyRange
        propertyState.propertyEasing = propertyEasing
        propertyState.propertyType      = propertyType
        
        return propertyState
    }
    
    @discardableResult public func range(_ rangeValue : ClosedRange<CGFloat>) -> PDAnimatablePropertyMaker
    {
        propertyRange = rangeValue
        return self
    }
    
    @discardableResult public func easing(_ easingValue : PDEasing) -> PDAnimatablePropertyMaker
    {
        propertyEasing = easingValue
        return self
    }
}
