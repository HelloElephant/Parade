//
//  SKAnimator.swift
//  ScrollWeaver-Demo
//
//  Created by Anton Doudarev on 3/23/18.
//  Copyright © 2018 ELEPHANT. All rights reserved.
//

import Foundation

public class SKAnimation {
    
    var animations = [SKViewAnimation]()
    var animatableViews : [SKAnimatableType]?
    
    public class func newAnimator(_ callback : (_ animator : SKAnimationBuilder) -> Void) -> SKAnimation {
        let newAnimator = SKAnimationBuilder()
        callback(newAnimator)
        return newAnimator.constructedAnimator()!
    }
    
    func interpolateAnimation(forProgress progress: SKScrollProgress) {
        
        for animation in animations {
            animation.adjustState(forProgress: progress)
        }
       
        guard let animatableViews = animatableViews else {
            return
        }
        
        for animatableView in animatableViews {
            animatableView.progressAnimator?.interpolateAnimation(forProgress: progress)
        }
    }
}

