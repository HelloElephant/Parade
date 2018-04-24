//
//  PDAnimator.swift
//  PDAnimator-Demo
//
//  Created by Anton Doudarev on 3/23/18.
//  Copyright © 2018 ELEPHANT. All rights reserved.
//

import Foundation
import UIKit

/**
 *  This is an animator class that needs to be returned when implementing the PDAnimatableType
 *
 *  Each View Animation contains 3 states different states that it interpolates in between.
 *
 *  The hierarchy is as followes:
 *                  - PDAnimator
 *                      -> Animations : [PDAnimatorView] (Each PDAnimatorView contains 3 States)
 *                              -> defaultState : PDAnimatorViewState (Array of PDAnimatorViewStateProperties)
 *                              -> fromState    : PDAnimatorViewState (Array of PDAnimatorViewStateProperties)
 *                              -> toState      : PDAnimatorViewState (Array of PDAnimatorViewStateProperties)
 *
 *
 *  Each PDAnimatorViewStateProperties defines the perperty key, value, easing, and range to interpolate over
 *
 *  Implement the PDAnimatableType protocol on any view that the scroll view can contains
 *      - UIScrollView      : implement PDAnimatableType on any UIView in the UIScrollView
 *      - UITableView       : implement PDAnimatableType on UITableViewCell
 *      - UICollectionView  : implement PDAnimatableType on UICollectionViewCell
 *
 *   To create the PDAnimator in implementing PDAnimatableType,
 *   use the blocks based PDAnimationMaker to defined the initial from state, and
 *   and the final disappearence state, nad when the scroll view begins to scroll
 *   the Animator will take a snapshot of the current state to interpolate in between.
 *
 *
 **/
public class PDAnimator
{
    
    /// The animations to interpolate over
    var animatedViews = [PDAnimatorView]()
    
    
    /// The attached animatable views to relay the progress to
    var attachedAnimatableViews : [PDAnimatableType]?

    
    /// The animators relative progress direction
    var animationDirection : PDProgressDirection = .vertical
    
    
    /// Use this block based approach to create an PDAnimator
    /// and define the initial starting state, and final state to
    /// interpolate between vertically.
    ///
    /// - Parameter callback: an animation builder instance
    /// - Returns: preconfigured animation that interpolates between states
    public class func newVerticalAnimator(_ callback : (_ animator : PDAnimationMaker) -> Void) -> PDAnimator
    {
        let newAnimator = PDAnimationMaker()
        callback(newAnimator)
        return newAnimator.constructedAnimator()!
    }
    
    
    /// Use this block based approach to create an PDAnimator
    /// and define the initial starting state, and final state to
    /// interpolate between horizontally.
    ///
    /// - Parameter callback: an animation builder instance
    /// - Returns: preconfigured animation that interpolates between states
    public class func newHorizontalAnimator(_ callback : (_ animator : PDAnimationMaker) -> Void) -> PDAnimator
    {
        let newAnimationMaker = PDAnimationMaker()
        
        callback(newAnimationMaker)
        
        let newAnimation = newAnimationMaker.constructedAnimator()!
        newAnimation.animationDirection = .horizontal
       
        return newAnimation
    }
    
    
    /// This is called by the scrolling action of the UIScrollView
    /// when the contentOffset changes, and the scrolling progress
    /// is recalculated.
    ///
    /// - Parameter progress: the current progress of the view
    internal func interpolateViewAnimation(forProgress progress: PDScrollProgressType) {
        
        for animation in animatedViews
        {
            animation.interpolateState(toProgress: progress)
        }
       
        guard let attachedAnimatableViews = attachedAnimatableViews else
        {
            return
        }
        
        if let attachedAnimatableViews = attachedAnimatableViews as? [UIView]
        {
            for animatableView in attachedAnimatableViews
            {
                var progressAnimator : PDAnimator?
                
                if let _ = animatableView.cachedProgressAnimator
                {
                    progressAnimator = animatableView.cachedProgressAnimator!
                }
                else
                {
                    animatableView.cachedProgressAnimator = (animatableView as? PDAnimatableType)?.configuredAnimator()
                    progressAnimator = animatableView.cachedProgressAnimator!
                }
                
                progressAnimator?.interpolateViewAnimation(forProgress: progress)
            }
        }
    }
}

