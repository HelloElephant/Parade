//
//  PDAnimationMaker.swift
//  PDAnimator-Demo
//
//  Created by Anton Doudarev on 3/23/18.
//  Copyright © 2018 ELEPHANT. All rights reserved.
//

import Foundation
import UIKit

public class PDAnimationMaker
{
    
    /// Array that keeps all the UIViews as keys to generate the Views states after constructions
    fileprivate var animationsViews = [UIView]()

    
    /// Array of views that are attached to relay the progress during scrolling. Use
    /// the attachAnimatableView(:) method to add views to relay progress down the hierarchy.
    fileprivate var newAnimatableViews : [UIView]?
    
    
    /// The initial starting states prior to appearence defined by the builder
    fileprivate var initialStates  : [UIView : PDAnimatorViewMaker] = [UIView : PDAnimatorViewMaker]()
   
    
    /// The initial starting states prior to appearence defined by the builder
    fileprivate var finalStates    : [UIView : PDAnimatorViewMaker] = [UIView : PDAnimatorViewMaker]()
    
    
    /// Constructs the final PDAnimator to be used by the PDAnimatableType
    ///
    /// - Returns: returns constructed PDAnimatableType
    internal func constructedAnimator() -> PDAnimator?
    {
        var newAnimatedViews = [PDAnimatorView]()
        
        for view in animationsViews
        {
            let animation  = PDAnimatorView()
            animation.view = view
            
            if let viewInitialState = initialStates[view]
            {
                animation.fromState = viewInitialState.constructedState()
            }
            
            if let viewFinalState = finalStates[view]
            {
                animation.toState = viewFinalState.constructedState()
            }
            
            newAnimatedViews.append(animation)
        }
        
        let animator = PDAnimator()
        animator.animatedViews = newAnimatedViews
        animator.attachedAnimatableViews = newAnimatableViews as? [PDAnimatableType]
       
        return animator
    }
    
    
    /// Adds a starting state for a view, and returns an animation state maker
    /// Note: This is the values the view will interpolate to when appearing onto the screen.
    ///
    /// - Parameters:
    ///   - view: the view to attach the starting state to
    ///   - callback: recursive callback retuning a view state builder
    /// - Returns: returns self, to recursively continue the building process
    @discardableResult public func startState(for view: UIView, _ callback : (_ animation : PDAnimatorViewMaker) -> Void) -> PDAnimationMaker
    {
        if !animationsViews.contains(view)
        {
            animationsViews.append(view)
        }
        
        if initialStates[view] == nil
        {
            initialStates[view] = PDAnimatorViewMaker()
        }
        
        callback(initialStates[view]!)
        
        return self
    }
    
    
    /// Adds an ending state for a view, and returns an animation state maker
    /// Note: These are the values the view will interpolate to when disappearing off the screen.
    ///
    /// - Parameters:
    ///   - view: the view to attach the final state to
    ///   - callback: recursive callback retuning a view state builder
    /// - Returns: returns self, to recursively continue the building process
    @discardableResult public func endState(for view: UIView, _ callback : (_ animation : PDAnimatorViewMaker) -> Void) -> PDAnimationMaker
    {
        if !animationsViews.contains(view)
        {
            animationsViews.append(view)
        }
        
        if finalStates[view] == nil
        {
            finalStates[view] = PDAnimatorViewMaker()
        }
        
        callback(finalStates[view]!)
        
        return self
    }
    
    
    /// Adds a starting state for an array of views, and returns an animation state maker
    /// Note: These are the values the views will interpolate to when appearing onto the screen.
    ///
    /// - Parameters:
    ///   - views: the views to attach the starting state to
    ///   - callback: recursive callback retuning a view state builder
    /// - Returns: returns self, to recursively continue the building process
    @discardableResult public func startState(forViews views:  [UIView], _ callback :  (_ animation : PDAnimatorViewMaker) -> Void) -> PDAnimationMaker
    {
        for view in views
        {
            startState(for: view, callback)
        }
        
        return self
    }
    
    
    /// Adds an ending state for an array of views, and returns an animation state maker
    /// Note: These are the values the views will interpolate to when disappearing off the screen.
    ///
    /// - Parameters:
    ///   - views: the views to attach the starting state to
    ///   - callback: recursive callback retuning a view state builder
    /// - Returns: returns self, to recursively continue the building process
    @discardableResult public func endState(forViews views: [UIView], _ callback : (_ animation : PDAnimatorViewMaker) -> Void) -> PDAnimationMaker
    {
        for view in views
        {
            endState(for: view, callback)
        }
        
        return self
    }
    
    
    /// Adds a start and end states for a view, and returns an animation state maker
    /// Note: This can be used to interpolate to the same appearence
    /// and disappearence values on s specific view (i.e alpha to 0.0)
    ///
    /// - Parameters:
    ///   - view: the view to attach the starting state to
    ///   - callback: recursive callback retuning a view state builder
    /// - Returns: returns self, to recursively continue the building process
    @discardableResult public func startEndState(for view: UIView, _ callback : (_ animation : PDAnimatorViewMaker) -> Void) -> PDAnimationMaker
    {
        if !animationsViews.contains(view)
        {
            animationsViews.append(view)
        }
        
        if initialStates[view] == nil
        {
            initialStates[view] = PDAnimatorViewMaker()
        }
        
        if finalStates[view] == nil
        {
            finalStates[view] = PDAnimatorViewMaker()
        }

        callback(initialStates[view]!)
        callback(finalStates[view]!)
        
        return self
    }
    
    
    /// Adds a start and end states for and array of  views, and returns
    /// an animation state maker
    ///
    /// Note: This can be used to interpolate to the same appearence
    /// and disappearence values for a specific set of views (i.e alpha to 0.0)
    ///
    /// - Parameters:
    ///   - view: the view to attach the starting state to
    ///   - callback: recursive callback retuning a view state builder
    /// - Returns: returns self, to recursively continue the building process
    @discardableResult public func startEndState(forViews views: [UIView], _ callback : (_ animation : PDAnimatorViewMaker) -> Void) -> PDAnimationMaker
    {
        for view in views
        {
            startEndState(for: view, callback)
        }
        
        return self
    }
    
    
    /// Attach another view that implements PDAnimatableType to relay the progress to
    ///
    /// - Parameter view: the view to relay progress to
    /// - Returns: returns self, to recursively continue the building process
    @discardableResult public func attachAnimatableView(_ view: UIView)-> PDAnimationMaker
    {
        if view is PDAnimatableType
        {
            if newAnimatableViews == nil {
                 newAnimatableViews = [UIView]()
            }
            
            if !newAnimatableViews!.contains(view)
            {
                newAnimatableViews!.append(view)
            }
        }

        return self
    }
    
    
    /// Attach an array of views that implement PDAnimatableType to relay the progress to
    ///
    /// - Parameter views: the views to relay progress to
    /// - Returns: returns self, to recursively continue the building process
    @discardableResult public func attachAnimatableViews(_ views: [UIView])-> PDAnimationMaker
    {
        for view in views
        {
            attachAnimatableView(view)
        }
        
        return self
    }
}


