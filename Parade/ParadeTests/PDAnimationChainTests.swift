//
//  PDAnimatorChainTests.swift
//  PDAnimatorTests
//
//  Created by Anton Doudarev on 4/12/18.
//  Copyright © 2018 ELEPHANT. All rights reserved.
//

import XCTest
@testable import Parade

class PDAnimatorChainTests: XCTestCase
{    
    func testAttachedAnimationViewInterpolation()
    {
        let view = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 200, height: 200))
        
      
        let attachedAnimatableView = VerticalAnimatableView(frame: CGRect(x: 0.0, y: 0.0, width: 200, height: 200))

        let _ = VerticalAnimatableView(coder: NSCoder())
        let _ = HorizontalAnimatableView(coder: NSCoder())
        
        
        view.center = CGPoint(x : 200, y : 200)
        view.layer.shadowOffset = CGSize(width:200, height:200)
        
        let animation = PDAnimator.newVerticalAnimator { (animator) in
            
            animator.startState(for: view, { (s) in
                
                s.alpha(0.0).easing(.linear)
            
            }).endState(for: view, { (s) in
                
                s.alpha(0.0).easing(.linear)
                
            }).attachAnimatableView(attachedAnimatableView)
        }
        
        XCTAssert(animation.animatedViews.count == 1, "[testVerticalAnimationInterpolation] - incorrect animabion count")
        XCTAssert(animation.attachedAnimatableViews?.count == 1, "[testVerticalAnimationInterpolation] - incorrect number of attached views")
        
        XCTAssert(animation.animatedViews[0].fromState?.animatableProperties.count == 1, "[testVerticalAnimationInterpolation] - incorrect animabion property count")
        
        for animatableType in animation.animatedViews
        {
            animatableType.configureDefaultStateIfNeeded()
        }
 
        /* Below Center */
        
        animation.interpolateViewAnimation(forProgress: .verticalBelowCenter(progress: 0.5))
        
        XCTAssert(view.alpha == 0.5,
                  "[testVerticalAnimationInterpolation] - view verticalBelowCenter alpha : \(view.alpha) is incorrectly calculated")
      
        XCTAssert(attachedAnimatableView.alpha == 0.5,
                  "[testVerticalAnimationInterpolation] - view verticalBelowCenter alpha : \(view.alpha) is incorrectly calculated")
        
        /* Centered Center */
        
        animation.interpolateViewAnimation(forProgress: .verticalCenter)
        
        XCTAssert(view.alpha == 1.0,
                  "[testVerticalAnimationInterpolation] - view verticalCenter alpha is incorrectly calculated")
    
        XCTAssert(attachedAnimatableView.alpha == 1.0,
                  "[testVerticalAnimationInterpolation] - view verticalBelowCenter alpha : \(view.alpha) is incorrectly calculated")

        /* AboveCenter Center */
        
        animation.interpolateViewAnimation(forProgress: .verticalAboveCenter(progress: 0.5))
        
        XCTAssert(attachedAnimatableView.alpha == 0.5,
                  "[testVerticalAnimationInterpolation] - view verticalBelowCenter alpha : \(view.alpha) is incorrectly calculated")
    }
    
    func testAttachedAnimationViewsInterpolation()
    {
        let view = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 200, height: 200))
        let attachedAnimatableView1 = VerticalAnimatableView(frame: CGRect(x: 0.0, y: 0.0, width: 200, height: 200))
        let attachedAnimatableView2 = VerticalAnimatableView(frame: CGRect(x: 0.0, y: 0.0, width: 200, height: 200))
        
        view.center = CGPoint(x : 200, y : 200)
        view.layer.shadowOffset = CGSize(width:200, height:200)
        
        let animation = PDAnimator.newVerticalAnimator { (animator) in
            
            animator.startState(for: view, { (s) in
                
                s.alpha(0.0).easing(.linear)
                
            }).endState(for: view, { (s) in
                
                s.alpha(0.0).easing(.linear)
                
            }).attachAnimatableViews([attachedAnimatableView1, attachedAnimatableView2] )
        }
        
        XCTAssert(animation.animatedViews.count == 1, "[testVerticalAnimationInterpolation] - incorrect animabion count")
        XCTAssert(animation.attachedAnimatableViews?.count == 2, "[testVerticalAnimationInterpolation] - incorrect number of attached views")
        
        XCTAssert(animation.animatedViews[0].fromState?.animatableProperties.count == 1, "[testVerticalAnimationInterpolation] - incorrect animabion property count")
        
        for animatableType in animation.animatedViews
        {
            animatableType.configureDefaultStateIfNeeded()
        }
        
        /* Below Center */
        
        animation.interpolateViewAnimation(forProgress: .verticalBelowCenter(progress: 0.5))
        
        XCTAssert(view.alpha == 0.5,
                  "[testVerticalAnimationInterpolation] - view verticalBelowCenter alpha : \(view.alpha) is incorrectly calculated")
        
        XCTAssert(attachedAnimatableView1.alpha == 0.5,
                  "[testVerticalAnimationInterpolation] - view verticalBelowCenter alpha : \(view.alpha) is incorrectly calculated")
        
        XCTAssert(attachedAnimatableView2.alpha == 0.5,
                  "[testVerticalAnimationInterpolation] - view verticalBelowCenter alpha : \(view.alpha) is incorrectly calculated")
        
        /* Centered Center */
        
        animation.interpolateViewAnimation(forProgress: .verticalCenter)
        
        XCTAssert(view.alpha == 1.0,
                  "[testVerticalAnimationInterpolation] - view verticalCenter alpha is incorrectly calculated")
        
        XCTAssert(attachedAnimatableView1.alpha == 1.0,
                  "[testVerticalAnimationInterpolation] - view verticalBelowCenter alpha : \(view.alpha) is incorrectly calculated")
        XCTAssert(attachedAnimatableView2.alpha == 1.0,
                  "[testVerticalAnimationInterpolation] - view verticalBelowCenter alpha : \(view.alpha) is incorrectly calculated")
        
        /* AboveCenter Center */
        
        animation.interpolateViewAnimation(forProgress: .verticalAboveCenter(progress: 0.5))
        
        XCTAssert(attachedAnimatableView1.alpha == 0.5,
                  "[testVerticalAnimationInterpolation] - view verticalBelowCenter alpha : \(view.alpha) is incorrectly calculated")
        XCTAssert(attachedAnimatableView2.alpha == 0.5,
                  "[testVerticalAnimationInterpolation] - view verticalBelowCenter alpha : \(view.alpha) is incorrectly calculated")
    }
    
    func testUpdatesValuesMethod()
    {
        UIScrollView.initializeParade()
        
        let verticalScrollView = UIScrollView()
        verticalScrollView.addSubview(VerticalAnimatableView(frame: CGRect(x: 0, y: 0, width: 200, height: 200 )))
        verticalScrollView.addSubview(UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200 )))
        verticalScrollView.setContentOffset(CGPoint(x: 0.0, y: 1.0), animated: true)
        verticalScrollView.updateViews()
        
        
        let horizontalScrollView = UIScrollView()
        horizontalScrollView.addSubview(HorizontalAnimatableView(frame: CGRect(x: 0, y: 0, width: 200, height: 200 )))
        horizontalScrollView.addSubview(UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200 )))
        horizontalScrollView.setContentOffset(CGPoint(x: 0.0, y: 1.0), animated: true)
        horizontalScrollView.updateViews()
    }
}
