//
//  PDAnimatorView.swift
//  PDAnimator-Demo
//
//  Created by Anton Doudarev on 3/23/18.
//  Copyright © 2018 ELEPHANT. All rights reserved.
//

import Foundation
import UIKit

/**
 *  This is an nimation that keeps ttrack of 3 states
 *        -> CenteredState : PDAnimatorViewState
 *        -> InitialState  : PDAnimatorViewState
 *        -> FinalState    : PDAnimatorViewState
 *
 *  Each PDAnimatorViewState cotnains array of PDAnimatorViewStateProperties to interpolate over
 *
 **/
public class PDAnimatorView
{
    
    /// A weak reference to the view that is being animated
    weak var view : UIView?
    
    /// The default centered state, snapshop is taken on first scroll
    internal var defaultState     : PDAnimatorViewState?
    
    /// The starting state that the view is appearing from
    internal var fromState  : PDAnimatorViewState?
    
    /// The final state that the view will animate to.
    internal var toState : PDAnimatorViewState?
    
    
    /// This method is called by the PDAnimator to
    /// interpolates between state accordingly for the calculated
    /// progress when the scrollview contentOffset changes
    ///
    /// - Parameter progress: the calculated progress on contentOffset change
    internal func interpolateState(toProgress progress: PDScrollProgressType)
    {
        configureDefaultStateIfNeeded()
        
        if let view = view,
            let defaultState = defaultState
        {
            switch progress {
            case let .verticalAboveCenter(progressValue),
                 let .horizontalLeftCenter(progressValue):
                
                if let toState = toState
                {
                    toState.adjustProgress(forView : view,
                                           toState : defaultState,
                                           progress: progressValue)
                }
                else if let fromState = fromState
                {
                    // This is to ensure that the view fully gets adjusted
                    // as it bounces at each end of the scrollView
                    
                    fromState.adjustProgress(forView : view,
                                             toState : defaultState,
                                             progress: 1.0)
                }
                
            case let .verticalBelowCenter(progressValue),
                 let .horizontalRightCenter(progressValue):
                
                if let fromState = fromState
                {
                    fromState.adjustProgress(forView : view,
                                             toState : defaultState,
                                             progress: progressValue)
                }
                else if let toState = toState
                {
                    // This is to ensure that the view fully gets adjusted
                    // as it bounces at each end of the scrollView
                    
                    toState.adjustProgress(forView : view,
                                           toState : defaultState,
                                           progress: 1.0)
                }
                
                break
            case .verticalCenter,
                 .horizontalCenter:
                
                // We need to adjust to one of the two states
                // ad the view is centered on the screen to avoid
                // a weird flicker, and not resetting the value to 0
                
                if let fromState = fromState
                {
                    fromState.adjustProgress(forView : view,
                                             toState : defaultState,
                                             progress: 1.0)
                }
                else if let toState = toState
                {
                    toState.adjustProgress(forView : view,
                                           toState : defaultState,
                                           progress: 1.0)
                }
            }
        }
    }
    
    
    /// The first time the contentoffset changes,
    /// the animator instance takes a snapshot of all the
    /// key values that have been defined by the builder
    internal func configureDefaultStateIfNeeded()
    {
        guard defaultState == nil else
        {
            return
        }
        
        var mergedAnimatableproperties = [PDAnimatableProperty]()
        
        if let fromState = fromState {
            mergedAnimatableproperties.append(contentsOf: fromState.animatableProperties.values)
        }
        
        if let toState = toState {
            mergedAnimatableproperties.append(contentsOf: toState.animatableProperties.values)
        }
        
        let defaultSnapshot = PDAnimatorViewState()

        for property in mergedAnimatableproperties
        {
            if let propKey = property.propertyKey
            {
                let stateProperty = PDAnimatableProperty()
                stateProperty.propertyKey = propKey
                
                if let fromProperty =  fromState?.animatableProperties[propKey]
                {
                    property.propertyType = fromProperty.propertyType
                }
                else if let toProperty =  toState?.animatableProperties[propKey]
                {
                    property.propertyType = toProperty.propertyType
                }

                if property.propertyType == .viewValue
                {
                    stateProperty.propertyValue = view?.value(forKey: propKey)
                }
                else if property.propertyType == .layerValue
                {
                    
                    // This is an exception, cecause the view, and layer, have the same 'transform'
                    // property name, but they are different type (CGAffineTransform/CATransform3D)
                    
                    if propKey == "transform3D"
                    {
                        stateProperty.propertyValue = view?.layer.value(forKey: "transform")
                    }
                    else
                    {
                        stateProperty.propertyValue = view?.layer.value(forKey: propKey)
                    }
                }
                
                defaultSnapshot.animatableProperties[propKey] = stateProperty
            }
        }
        
        defaultState = defaultSnapshot
    }
}
