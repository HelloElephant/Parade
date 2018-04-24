//
//  SKAnimationBuilder.swift
//  ScrollWeaver-Demo
//
//  Created by Anton Doudarev on 3/23/18.
//  Copyright © 2018 ELEPHANT. All rights reserved.
//

import Foundation
import UIKit

public class SKAnimationBuilder {
    
    internal var views = [UIView]()
    
    internal var newAnimations      = [SKViewAnimation]()
    internal var newAnimatableViews = [UIView]()
    
    internal var defaultStates    : [UIView : SKAnimationViewStateMaker] = [UIView : SKAnimationViewStateMaker]()
    internal var fromStateStates  : [UIView : SKAnimationViewStateMaker] = [UIView : SKAnimationViewStateMaker]()
    internal var toStateStates    : [UIView : SKAnimationViewStateMaker] = [UIView : SKAnimationViewStateMaker]()
    
    internal func constructedAnimator() -> SKAnimation? {
        
        var newAnimations = [SKViewAnimation]()
        
        for view in views {
           
            let animation  = SKViewAnimation()
            animation.view = view
            
            animation.centeredState = generateDefaultState(forView: view)
 
            if let viewInitialState = fromStateStates[view] {
                animation.appearFromState = viewInitialState.constructedState()
            }
            
            if let viewFinalState = toStateStates[view] {
                animation.disappearToState = viewFinalState.constructedState()
            }
            
            newAnimations.append(animation)
        }
        
        let animator = SKAnimation()
        animator.animations = newAnimations
        animator.animatableViews = newAnimatableViews as? [SKAnimatableType]
        return animator
    }
    
    func generateDefaultState(forView view: UIView) -> SKAnimationViewState {
        
        let trackedProperties = ["alpha", "backgroundColor", "bounds" ,"center", "transform"]

        let defaultState = SKAnimationViewState()
        
        for propKey in trackedProperties {
            let stateProperty = SKAnimationViewStateProperty()
            stateProperty.propertyKey = propKey
            stateProperty.propertyValue = view.value(forKey: propKey)
            defaultState.properties.append(stateProperty)
        }
        
        return defaultState
    }
    
    @discardableResult public func addDefaultState(forView view: UIView, _ callback : (_ animation : SKAnimationViewStateMaker) -> Void) -> SKAnimationBuilder {
        
        if !views.contains(view) {
            views.append(view)
        }
        
        if defaultStates[view] == nil {
            defaultStates[view] = SKAnimationViewStateMaker()
        }
        
        callback(defaultStates[view]!)
        
        return self
    }
    
    @discardableResult public func addInitialState(forView view: UIView, _ callback : (_ animation : SKAnimationViewStateMaker) -> Void) -> SKAnimationBuilder {
        
        if !views.contains(view) {
            views.append(view)
        }
        
        if fromStateStates[view] == nil {
            fromStateStates[view] = SKAnimationViewStateMaker()
        }
        
        callback(fromStateStates[view]!)
        
        return self
    }
    
    @discardableResult public func addFinalState(forView view: UIView, _ callback : (_ animation : SKAnimationViewStateMaker) -> Void) -> SKAnimationBuilder {
        
        if !views.contains(view) {
            views.append(view)
        }
        
        if toStateStates[view] == nil {
            toStateStates[view] = SKAnimationViewStateMaker()
        }
        
        callback(toStateStates[view]!)
        
        return self
    }
    
    @discardableResult public func addInitialState(forViews animationViews:  [UIView], _ callback :  (_ animation : SKAnimationViewStateMaker) -> Void) -> SKAnimationBuilder {
        
        for view in animationViews {
            addInitialState(forView: view, callback)
        }
        
        return self
    }
    
    @discardableResult public func addFinalState(forViews animationViews: [UIView], _ callback : (_ animation : SKAnimationViewStateMaker) -> Void) -> SKAnimationBuilder {
        
        for view in animationViews {
            addFinalState(forView: view, callback)
        }
        
        return self
    }
    
    
    @discardableResult public func attachAnimatableView(_ view: UIView)-> SKAnimationBuilder {
        
        if view is SKAnimatableType {
            if !newAnimatableViews.contains(view) {
                newAnimatableViews.append(view)
            }
        }

        return self
    }
    
    @discardableResult public func attachAnimatableViews(_ views: [UIView])-> SKAnimationBuilder {
        
        for view in views {
            attachAnimatableView(view)
        }
        
        return self
    }
}

public class SKAnimationViewStateMaker {

    var propertyStates : [String : SKAnimationViewStatePropertyMaker] = [String :  SKAnimationViewStatePropertyMaker]()
    
    internal func constructedState() -> SKAnimationViewState?
    {
        let animationState = SKAnimationViewState()
        
        for (_, propertyState) in propertyStates {
            animationState.properties.append(propertyState.constructedPropertyState())
        }
        
        return animationState
    }
    
    @discardableResult public func alpha(_ value : CGFloat) -> SKAnimationViewStatePropertyMaker
    {
        configuredValue(value, forKey: "alpha")
        return propertyStates["alpha"]!
    }
    
    @discardableResult public func backgroundColor(_ value : UIColor) -> SKAnimationViewStatePropertyMaker
    {
        configuredValue(value, forKey: "backgroundColor")
        return propertyStates["backgroundColor"]!
    }
    
    @discardableResult public func bounds(_ value : CGSize) -> SKAnimationViewStatePropertyMaker {
        configuredValue(value, forKey: "bounds")
        return propertyStates["bounds"]!
    }
    
    @discardableResult public func center(_ value : CGPoint) -> SKAnimationViewStatePropertyMaker {
        configuredValue(value, forKey: "center")
        return propertyStates["center"]!
    }
    
    @discardableResult public func size(_ value : CGSize) -> SKAnimationViewStatePropertyMaker
    {
        var newBounds = CGRect.zero
        newBounds.size = value
        
        configuredValue(newBounds, forKey: "bounds")
        return propertyStates["bounds"]!
    }
    
    @discardableResult public func transform(_ value : CGAffineTransform) -> SKAnimationViewStatePropertyMaker {
        configuredValue(value, forKey: "transform")
        return propertyStates["transform"]!
    }
    
    internal func configuredValue(_ value : Any?, forKey key : String) {
        
        if propertyStates[key] == nil {
            
            let stateProperty = SKAnimationViewStatePropertyMaker()
           
            stateProperty.propertyValue = value
            stateProperty.propertyKey = key
            
            propertyStates[key] = stateProperty
        }
    }
}

public class SKAnimationViewStatePropertyMaker {
   
    public var propertyKey     : String?
    public var propertyValue   : Any?
    public var propertyRange   : ClosedRange<CGFloat> = 0...1.0
    public var propertyEasing  : SKAnimationEasing = .linear
    
    @discardableResult public func range(_ rangeValue : ClosedRange<CGFloat>) -> SKAnimationViewStatePropertyMaker {
        propertyRange = rangeValue
        return self
    }
    
    @discardableResult public func easing(_ easingValue : SKAnimationEasing) -> SKAnimationViewStatePropertyMaker {
        propertyEasing = easingValue
        return self
    }
    
    internal func constructedPropertyState() -> SKAnimationViewStateProperty {
        let propertyState = SKAnimationViewStateProperty()
        propertyState.propertyKey    = propertyKey
        propertyState.propertyValue  = propertyValue
        propertyState.propertyRange  = propertyRange
        propertyState.propertyEasing = propertyEasing
        
        return propertyState
    }
}

