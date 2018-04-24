//
//  PDStateInterpolationTests.swift
//  PDAnimatorTests
//
//  Created by Anton Doudarev on 4/12/18.
//  Copyright © 2018 ELEPHANT. All rights reserved.
//

import XCTest
import UIKit
@testable import Parade

class PDStateInterpolationTests: XCTestCase
{    
    func testVerticalAnimationInterpolation()
    {
        let view = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 200, height: 200))
        view.center = CGPoint(x : 200, y : 200)
        view.layer.shadowOffset = CGSize(width:200, height:200)
        view.transform =  CGAffineTransform(a: 1.0, b: 1.0, c: 1.0, d: 1.0, tx: 1.0, ty: 1.0)
        view.backgroundColor   = UIColor.white
        view.layer.borderColor = UIColor.white.cgColor
        
        let offscreenTransform = CGAffineTransform(a: 0.0, b: 0.0, c: 0.0, d: 0.0, tx: 0.0, ty: 0.0)
    
        let animation = PDAnimator.newVerticalAnimator { (animator) in
            
            animator.startState(for: view, { (s) in
                
                s.alpha(0.0).easing(.linear)
                s.center(CGPoint(x:100, y:100)).easing(.linear)
                s.shadowOffset(CGSize(width:100, height:100)).easing(.linear)
                s.bounds( CGRect(x: 0.0, y: 0.0, width: 400, height: 400)).easing(.linear)
                s.bounds( CGRect(x: 0.0, y: 0.0, width: 400, height: 400)).easing(.linear)
                s.transform(offscreenTransform).easing(.linear)
                s.backgroundColor(UIColor.black).easing(.linear)
                s.borderColor(UIColor.black.cgColor)
           
            }).endState(for: view, { (s) in
                
                s.alpha(0.0).easing(.linear)
                s.center(CGPoint(x:100, y:100)).easing(.linear)
                s.shadowOffset(CGSize(width:100, height:100)).easing(.linear)
                s.bounds( CGRect(x: 0.0, y: 0.0, width: 400, height: 400)).easing(.linear)
                s.transform(offscreenTransform).easing(.linear)
                s.transform(offscreenTransform).easing(.linear)
                s.backgroundColor(UIColor.black).easing(.linear)
                s.borderColor(UIColor.black.cgColor)
            })
        }
        
        XCTAssert(animation.animatedViews.count == 1, "[testVerticalAnimationInterpolation] - incorrect animabion count")
        XCTAssert(animation.animatedViews[0].fromState?.animatableProperties.count == 7, "[testVerticalAnimationInterpolation] - incorrect animabion property count")
        
        for animatableType in animation.animatedViews
        {
            animatableType.configureDefaultStateIfNeeded()
        }
        
        /* Below Center */
        
        animation.interpolateViewAnimation(forProgress: .verticalBelowCenter(progress: 0.5))
        
        XCTAssert(view.alpha == 0.5,
                  "[testVerticalAnimationInterpolation] - view verticalBelowCenter alpha : \(view.alpha) is incorrectly calculated")
        XCTAssert(view.center.equalTo(CGPoint(x : 150, y : 150)),
                  "[testVerticalAnimationInterpolation] - view verticalBelowCenter center : \(view.center) is incorrectly calculated")
        XCTAssert(view.layer.shadowOffset.equalTo(CGSize(width:150, height:150)),
                  "[testVerticalAnimationInterpolation] - view verticalBelowCenter shadowOffet : \(view.layer.shadowOffset) is incorrectly calculated")
        XCTAssert(view.bounds.equalTo( CGRect(x: 0.0, y: 0.0, width: 300, height: 300)),
                  "[testVerticalAnimationInterpolation] - view verticalBelowCenter bounds : \(view.bounds) is incorrectly calculated")
        XCTAssert(view.transform.a == 0.5,
                  "[testVerticalAnimationInterpolation] - view verticalBelowCenter transform a  : \(view.transform) is incorrectly calculated")
        XCTAssert(view.transform.b == 0.5,
                  "[testVerticalAnimationInterpolation] - view verticalBelowCenter transform b  : \(view.transform) is incorrectly calculated")
        XCTAssert(view.transform.c == 0.5,
                  "[testVerticalAnimationInterpolation] - view verticalBelowCenter transform c  : \(view.transform) is incorrectly calculated")
        XCTAssert(view.transform.d == 0.5,
                  "[testVerticalAnimationInterpolation] - view verticalBelowCenter transform d  : \(view.transform) is incorrectly calculated")
        XCTAssert(view.transform.tx == 0.5,
                  "[testVerticalAnimationInterpolation] - view verticalBelowCenter transform tx : \(view.transform) is incorrectly calculated")
        XCTAssert(view.transform.ty == 0.5,
                  "[testVerticalAnimationInterpolation] - view verticalBelowCenter transform ty : \(view.transform) is incorrectly calculated")
    
        let verticalBelowCenterComponents = view.backgroundColor?.components
        
        XCTAssert(verticalBelowCenterComponents?.r == 0.5,
                  "[testVerticalAnimationInterpolation] - view verticalBelowCenter color r  : \(verticalBelowCenterComponents!) is incorrectly calculated")
        XCTAssert(verticalBelowCenterComponents?.g == 0.5,
                  "[testVerticalAnimationInterpolation] - view verticalBelowCenter color g : \(verticalBelowCenterComponents!) is incorrectly calculated")
        XCTAssert(verticalBelowCenterComponents?.b == 0.5,
                  "[testVerticalAnimationInterpolation] - view verticalBelowCenter color b : \(verticalBelowCenterComponents!) is incorrectly calculated")
        
        let verticalBelowCenterBorderColorComponents = view.layer.borderColor?.componentsConfig
        
        XCTAssert(verticalBelowCenterBorderColorComponents?.r == 0.5,
                  "[testVerticalAnimationInterpolation] - view verticalBelowCenter borderColor r  : \(verticalBelowCenterBorderColorComponents!) is incorrectly calculated")
        XCTAssert(verticalBelowCenterBorderColorComponents?.g == 0.5,
                  "[testVerticalAnimationInterpolation] - view verticalBelowCenter borderColor g : \(verticalBelowCenterBorderColorComponents!) is incorrectly calculated")
        XCTAssert(verticalBelowCenterBorderColorComponents?.b == 0.5,
                  "[testVerticalAnimationInterpolation] - view verticalBelowCenter borderColor b : \(verticalBelowCenterBorderColorComponents!) is incorrectly calculated")

        /* Centered Center */
        
        animation.interpolateViewAnimation(forProgress: .verticalCenter)
        
        XCTAssert(view.alpha == 1.0,
                  "[testVerticalAnimationInterpolation] - view verticalCenter alpha is incorrectly calculated")
        XCTAssert(view.center.equalTo(CGPoint(x : 200, y : 200)),
                  "[testVerticalAnimationInterpolation] - view verticalCenter center : \(view.center) is incorrectly calculated")
        XCTAssert(view.layer.shadowOffset.equalTo(CGSize(width:200, height:200)),
                  "[testVerticalAnimationInterpolation] - view verticalCenter shadowOffet : \(view.layer.shadowOffset) is incorrectly calculated")
        XCTAssert(view.bounds.equalTo( CGRect(x: 0.0, y: 0.0, width: 200, height: 200)),
                  "[testVerticalAnimationInterpolation] - view verticalCenter bounds : \(view.bounds) is incorrectly calculated")
        XCTAssert(view.transform.a == 1.0,
                  "[testVerticalAnimationInterpolation] - view verticalCenter transform a  : \(view.transform) is incorrectly calculated")
        XCTAssert(view.transform.b == 1.0,
                  "[testVerticalAnimationInterpolation] - view verticalCenter transform b  : \(view.transform) is incorrectly calculated")
        XCTAssert(view.transform.c == 1.0,
                  "[testVerticalAnimationInterpolation] - view verticalCenter transform c  : \(view.transform) is incorrectly calculated")
        XCTAssert(view.transform.d == 1.0,
                  "[testVerticalAnimationInterpolation] - view verticalCenter transform d  : \(view.transform) is incorrectly calculated")
        XCTAssert(view.transform.tx == 1.0,
                  "[testVerticalAnimationInterpolation] - view verticalCenter transform tx : \(view.transform) is incorrectly calculated")
        XCTAssert(view.transform.ty == 1.0,
                  "[testVerticalAnimationInterpolation] - view verticalCenter transform ty : \(view.transform) is incorrectly calculated")
        
        let verticalCenterComponents = view.backgroundColor?.components
        
        XCTAssert(verticalCenterComponents?.r == 1.0,
                  "[testVerticalAnimationInterpolation] - view verticalCenter color r  : \(verticalCenterComponents!) is incorrectly calculated")
        XCTAssert(verticalCenterComponents?.g == 1.0,
                  "[testVerticalAnimationInterpolation] - view verticalCenter color g : \(verticalCenterComponents!) is incorrectly calculated")
        XCTAssert(verticalCenterComponents?.b == 1.0,
                  "[testVerticalAnimationInterpolation] - view verticalCenter color b : \(verticalCenterComponents!) is incorrectly calculated")
        
        let verticalCenteredBorderColorComponents = view.layer.borderColor?.componentsConfig
        
        XCTAssert(verticalCenteredBorderColorComponents?.r == 1.0,
                  "[testVerticalAnimationInterpolation] - view verticalCenter borderColor r  : \(verticalCenteredBorderColorComponents!) is incorrectly calculated")
        XCTAssert(verticalCenteredBorderColorComponents?.g == 1.0,
                  "[testVerticalAnimationInterpolation] - view verticalCenter borderColor g : \(verticalCenteredBorderColorComponents!) is incorrectly calculated")
        XCTAssert(verticalCenteredBorderColorComponents?.b == 1.0,
                  "[testVerticalAnimationInterpolation] - view verticalCenter borderColor b : \(verticalCenteredBorderColorComponents!) is incorrectly calculated")
    
        /* AboveCenter Center */
        
        animation.interpolateViewAnimation(forProgress: .verticalAboveCenter(progress: 0.5))
        
        XCTAssert(view.alpha == 0.5,
                  "[testVerticalAnimationInterpolation] - view verticalAboveCenter alpha : \(view.alpha) is incorrectly calculated")
        XCTAssert(view.center.equalTo(CGPoint(x : 150, y : 150)),
                  "[testVerticalAnimationInterpolation] - view verticalAboveCenter center : \(view.center) is incorrectly calculated")
        XCTAssert(view.layer.shadowOffset.equalTo(CGSize(width:150, height:150)),
                  "[testVerticalAnimationInterpolation] - view verticalAboveCenter shadowOffet : \(view.layer.shadowOffset) is incorrectly calculated")
        XCTAssert(view.bounds.equalTo( CGRect(x: 0.0, y: 0.0, width: 300, height: 300)),
                  "[testVerticalAnimationInterpolation] - view verticalAboveCenter bounds : \(view.bounds) is incorrectly calculated")
        XCTAssert(view.transform.a == 0.5,
                  "[testVerticalAnimationInterpolation] - view verticalAboveCenter transform a  : \(view.transform) is incorrectly calculated")
        XCTAssert(view.transform.b == 0.5,
                  "[testVerticalAnimationInterpolation] - view verticalAboveCenter transform b  : \(view.transform) is incorrectly calculated")
        XCTAssert(view.transform.c == 0.5,
                  "[testVerticalAnimationInterpolation] - view verticalAboveCenter transform c  : \(view.transform) is incorrectly calculated")
        XCTAssert(view.transform.d == 0.5,
                  "[testVerticalAnimationInterpolation] - view verticalAboveCenter transform d  : \(view.transform) is incorrectly calculated")
        XCTAssert(view.transform.tx == 0.5,
                  "[testVerticalAnimationInterpolation] - view verticalAboveCenter transform tx : \(view.transform) is incorrectly calculated")
        XCTAssert(view.transform.ty == 0.5,
                  "[testVerticalAnimationInterpolation] - view verticalAboveCenter transform ty : \(view.transform) is incorrectly calculated")
        
        let verticalAboveCenterComponents = view.backgroundColor?.components
        
        XCTAssert(verticalAboveCenterComponents?.r == 0.5,
                  "[testVerticalAnimationInterpolation] - view verticalAboveCenter color r  : \(verticalAboveCenterComponents!) is incorrectly calculated")
        XCTAssert(verticalAboveCenterComponents?.g == 0.5,
                  "[testVerticalAnimationInterpolation] - view verticalAboveCenter color g : \(verticalAboveCenterComponents!) is incorrectly calculated")
        XCTAssert(verticalAboveCenterComponents?.b == 0.5,
                  "[testVerticalAnimationInterpolation] - view verticalAboveCenter color b : \(verticalAboveCenterComponents!) is incorrectly calculated")
   
        
        let verticalAboveCenterBorderColorComponents = view.layer.borderColor?.componentsConfig
        
        XCTAssert(verticalAboveCenterBorderColorComponents?.r == 0.5,
                  "[testVerticalAnimationInterpolation] - view verticalAboveCenter borderColor r  : \(verticalAboveCenterBorderColorComponents!) is incorrectly calculated")
        XCTAssert(verticalAboveCenterBorderColorComponents?.g == 0.5,
                  "[testVerticalAnimationInterpolation] - view verticalAboveCenter borderColor g : \(verticalAboveCenterBorderColorComponents!) is incorrectly calculated")
        XCTAssert(verticalAboveCenterBorderColorComponents?.b == 0.5,
                  "[testVerticalAnimationInterpolation] - view verticalAboveCenter borderColor b : \(verticalAboveCenterBorderColorComponents!) is incorrectly calculated")
    }
    
    func testHorizonalAnimationInterpolation()
    {
        let view = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 200, height: 200))
        view.center = CGPoint(x : 200, y : 200)
        view.layer.shadowOffset = CGSize(width:200, height:200)
        view.layer.transform = CATransform3D(m11: 1.0, m12: 1.0, m13: 1.0, m14: 1.0,
                                             m21: 1.0, m22: 1.0, m23: 1.0, m24: 1.0,
                                             m31: 1.0, m32: 1.0, m33: 1.0, m34: 1.0,
                                             m41: 1.0, m42: 1.0, m43: 1.0, m44: 1.0)
        
        let offscreenTransform = CATransform3D(m11: 0.0, m12: 0.0, m13: 0.0, m14: 0.0,
                                               m21: 0.0, m22: 0.0, m23: 0.0, m24: 0.0,
                                               m31: 0.0, m32: 0.0, m33: 0.0, m34: 0.0,
                                               m41: 0.0, m42: 0.0, m43: 0.0, m44: 0.0)
        
        let animation = PDAnimator.newHorizontalAnimator { (animator) in
            
            animator.startState(for: view, { (s) in
                
                s.alpha(0.0).easing(.linear)
                s.center(CGPoint(x:100, y:100)).easing(.linear)
                s.shadowOffset(CGSize(width:100, height:100)).easing(.linear)
                s.bounds( CGRect(x: 0.0, y: 0.0, width: 400, height: 400)).easing(.linear)
                s.transform3D(offscreenTransform)
           
            }).endState(for: view, { (s) in
                
                s.alpha(0.0).easing(.linear)
                s.center(CGPoint(x:100, y:100)).easing(.linear)
                s.shadowOffset(CGSize(width:100, height:100)).easing(.linear)
                s.bounds( CGRect(x: 0.0, y: 0.0, width: 400, height: 400)).easing(.linear)
                s.transform3D(offscreenTransform)
            })
        }
        
        XCTAssert(animation.animatedViews.count == 1, "[testHorizonalAnimationInterpolation] - incorrect animabion count")
        XCTAssert(animation.animatedViews[0].fromState?.animatableProperties.count == 5, "[testHorizonalAnimationInterpolation] - incorrect animabion property count")
        
        for animatableType in animation.animatedViews
        {
            animatableType.configureDefaultStateIfNeeded()
        }
    
        /* Left Horizontal of Center Center */
        
        animation.interpolateViewAnimation(forProgress: .horizontalLeftCenter(progress: 0.5))
        
        XCTAssert(view.alpha == 0.5,
                  "[testHorizonalAnimationInterpolation] - view horizontalLeftCenter alpha : \(view.alpha) is incorrectly calculated")
        XCTAssert(view.center.equalTo(CGPoint(x : 150, y : 150)),
                  "[testHorizonalAnimationInterpolation] - view horizontalLeftCenter center : \(view.center) is incorrectly calculated")
        XCTAssert(view.layer.shadowOffset.equalTo(CGSize(width:150, height:150)),
                  "[testHorizonalAnimationInterpolation] - view horizontalLeftCenter shadowOffet : \(view.layer.shadowOffset) is incorrectly calculated")
        XCTAssert(view.bounds.equalTo( CGRect(x: 0.0, y: 0.0, width: 300, height: 300)),
                  "[testHorizonalAnimationInterpolation] - view horizontalLeftCenter bounds : \(view.bounds) is incorrectly calculated")
        XCTAssert(view.layer.transform.m11 == 0.5,
                  "[testVerticalAnimationInterpolation] - view horizontalLeftCenter transform 3D m11 : \(view.layer.transform) is incorrectly calculated")
        XCTAssert(view.layer.transform.m12 == 0.5,
                  "[testVerticalAnimationInterpolation] - view horizontalLeftCenter transform 3D m12 : \(view.layer.transform) is incorrectly calculated")
        XCTAssert(view.layer.transform.m13 == 0.5,
                  "[testVerticalAnimationInterpolation] - view horizontalLeftCenter transform 3D m13 : \(view.layer.transform) is incorrectly calculated")
        XCTAssert(view.layer.transform.m14 == 0.5,
                  "[testVerticalAnimationInterpolation] - view horizontalLeftCenter transform 3d m14 : \(view.layer.transform) is incorrectly calculated")
        XCTAssert(view.layer.transform.m21 == 0.5,
                  "[testVerticalAnimationInterpolation] - view horizontalLeftCenter transform 3D m21 : \(view.layer.transform) is incorrectly calculated")
        XCTAssert(view.layer.transform.m22 == 0.5,
                  "[testVerticalAnimationInterpolation] - view horizontalLeftCenter transform 3D m22 : \(view.layer.transform) is incorrectly calculated")
        XCTAssert(view.layer.transform.m23 == 0.5,
                  "[testVerticalAnimationInterpolation] - view horizontalLeftCenter transform 3D m23 : \(view.layer.transform) is incorrectly calculated")
        XCTAssert(view.layer.transform.m24 == 0.5,
                  "[testVerticalAnimationInterpolation] - view horizontalLeftCenter transform 3d m24 : \(view.layer.transform) is incorrectly calculated")
        XCTAssert(view.layer.transform.m31 == 0.5,
                  "[testVerticalAnimationInterpolation] - view horizontalLeftCenter transform 3D m31 : \(view.layer.transform) is incorrectly calculated")
        XCTAssert(view.layer.transform.m32 == 0.5,
                  "[testVerticalAnimationInterpolation] - view horizontalLeftCenter transform 3D m32 : \(view.layer.transform) is incorrectly calculated")
        XCTAssert(view.layer.transform.m33 == 0.5,
                  "[testVerticalAnimationInterpolation] - view horizontalLeftCenter transform 3D m33 : \(view.layer.transform) is incorrectly calculated")
        XCTAssert(view.layer.transform.m34 == 0.5,
                  "[testVerticalAnimationInterpolation] - view horizontalLeftCenter transform 3d m34 : \(view.layer.transform) is incorrectly calculated")
        XCTAssert(view.layer.transform.m41 == 0.5,
                  "[testVerticalAnimationInterpolation] - view horizontalLeftCenter transform 3D m41 : \(view.layer.transform) is incorrectly calculated")
        XCTAssert(view.layer.transform.m42 == 0.5,
                  "[testVerticalAnimationInterpolation] - view horizontalLeftCenter transform 3D m42 : \(view.layer.transform) is incorrectly calculated")
        XCTAssert(view.layer.transform.m43 == 0.5,
                  "[testVerticalAnimationInterpolation] - view horizontalLeftCenter transform 3D m43 : \(view.layer.transform) is incorrectly calculated")
        XCTAssert(view.layer.transform.m44 == 0.5,
                  "[testVerticalAnimationInterpolation] - view horizontalLeftCenter transform 3d m44 : \(view.layer.transform) is incorrectly calculated")
        
        /* Centered Horizontally */
        
        animation.interpolateViewAnimation(forProgress: .horizontalCenter)
        
        XCTAssert(view.alpha == 1.0,
                  "[testHorizonalAnimationInterpolation] - view horizontalCenter alpha is incorrectly calculated")
        XCTAssert(view.center.equalTo(CGPoint(x : 200, y : 200)),
                  "[testHorizonalAnimationInterpolation] - view horizontalCenter center : \(view.center) is incorrectly calculated")
        XCTAssert(view.layer.shadowOffset.equalTo(CGSize(width:200, height:200)),
                  "[testHorizonalAnimationInterpolation] - view horizontalCenter shadowOffet : \(view.layer.shadowOffset) is incorrectly calculated")
        XCTAssert(view.bounds.equalTo( CGRect(x: 0.0, y: 0.0, width: 200, height: 200)),
                  "[testHorizonalAnimationInterpolation] - view horizontalCenter bounds : \(view.bounds) is incorrectly calculated")
        XCTAssert(view.layer.transform.m11 == 1.0,
                  "[testVerticalAnimationInterpolation] - view horizontalCenter transform 3D m11 : \(view.layer.transform) is incorrectly calculated")
        XCTAssert(view.layer.transform.m12 == 1.0,
                  "[testVerticalAnimationInterpolation] - view horizontalCenter transform 3D m12 : \(view.layer.transform) is incorrectly calculated")
        XCTAssert(view.layer.transform.m13 == 1.0,
                  "[testVerticalAnimationInterpolation] - view horizontalCenter transform 3D m13 : \(view.layer.transform) is incorrectly calculated")
        XCTAssert(view.layer.transform.m14 == 1.0,
                  "[testVerticalAnimationInterpolation] - view horizontalCenter transform 3d m14 : \(view.layer.transform) is incorrectly calculated")
        XCTAssert(view.layer.transform.m21 == 1.0,
                  "[testVerticalAnimationInterpolation] - view horizontalCenter transform 3D m21 : \(view.layer.transform) is incorrectly calculated")
        XCTAssert(view.layer.transform.m22 == 1.0,
                  "[testVerticalAnimationInterpolation] - view horizontalCenter transform 3D m22 : \(view.layer.transform) is incorrectly calculated")
        XCTAssert(view.layer.transform.m23 == 1.0,
                  "[testVerticalAnimationInterpolation] - view horizontalCenter transform 3D m23 : \(view.layer.transform) is incorrectly calculated")
        XCTAssert(view.layer.transform.m24 == 1.0,
                  "[testVerticalAnimationInterpolation] - view horizontalCenter transform 3d m24 : \(view.layer.transform) is incorrectly calculated")
        XCTAssert(view.layer.transform.m31 == 1.0,
                  "[testVerticalAnimationInterpolation] - view horizontalCenter transform 3D m31 : \(view.layer.transform) is incorrectly calculated")
        XCTAssert(view.layer.transform.m32 == 1.0,
                  "[testVerticalAnimationInterpolation] - view horizontalCenter transform 3D m32 : \(view.layer.transform) is incorrectly calculated")
        XCTAssert(view.layer.transform.m33 == 1.0,
                  "[testVerticalAnimationInterpolation] - view horizontalCenter transform 3D m33 : \(view.layer.transform) is incorrectly calculated")
        XCTAssert(view.layer.transform.m34 == 1.0,
                  "[testVerticalAnimationInterpolation] - view horizontalCenter transform 3d m34 : \(view.layer.transform) is incorrectly calculated")
        XCTAssert(view.layer.transform.m41 == 1.0,
                  "[testVerticalAnimationInterpolation] - view horizontalCenter transform 3D m41 : \(view.layer.transform) is incorrectly calculated")
        XCTAssert(view.layer.transform.m42 == 1.0,
                  "[testVerticalAnimationInterpolation] - view horizontalCenter transform 3D m42 : \(view.layer.transform) is incorrectly calculated")
        XCTAssert(view.layer.transform.m43 == 1.0,
                  "[testVerticalAnimationInterpolation] - view horizontalCenter transform 3D m43 : \(view.layer.transform) is incorrectly calculated")
        XCTAssert(view.layer.transform.m44 == 1.0,
                  "[testVerticalAnimationInterpolation] - view horizontalCenter transform 3d m44 : \(view.layer.transform) is incorrectly calculated")
        
        /* Right Horizontal of Center */
        
        animation.interpolateViewAnimation(forProgress: .horizontalRightCenter(progress: 0.5))
        
        XCTAssert(view.alpha == 0.5,
                  "[testHorizonalAnimationInterpolation] - view horizontalRightCenter alpha : \(view.alpha) is incorrectly calculated")
        XCTAssert(view.center.equalTo(CGPoint(x : 150, y : 150)),
                  "[testHorizonalAnimationInterpolation] - view horizontalRightCenter center : \(view.center) is incorrectly calculated")
        XCTAssert(view.layer.shadowOffset.equalTo(CGSize(width:150, height:150)),
                  "[testHorizonalAnimationInterpolation] - view horizontalRightCenter shadowOffet : \(view.layer.shadowOffset) is incorrectly calculated")
        XCTAssert(view.bounds.equalTo( CGRect(x: 0.0, y: 0.0, width: 300, height: 300)),
                  "[testHorizonalAnimationInterpolation] - view horizontalRightCenter bounds : \(view.bounds) is incorrectly calculated")
        XCTAssert(view.layer.transform.m11 == 0.5,
                  "[testVerticalAnimationInterpolation] - view horizontalRightCenter transform 3D m11 : \(view.layer.transform) is incorrectly calculated")
        XCTAssert(view.layer.transform.m12 == 0.5,
                  "[testVerticalAnimationInterpolation] - view horizontalRightCenter transform 3D m12 : \(view.layer.transform) is incorrectly calculated")
        XCTAssert(view.layer.transform.m13 == 0.5,
                  "[testVerticalAnimationInterpolation] - view horizontalRightCenter transform 3D m13 : \(view.layer.transform) is incorrectly calculated")
        XCTAssert(view.layer.transform.m14 == 0.5,
                  "[testVerticalAnimationInterpolation] - view horizontalRightCenter transform 3d m14 : \(view.layer.transform) is incorrectly calculated")
        XCTAssert(view.layer.transform.m21 == 0.5,
                  "[testVerticalAnimationInterpolation] - view horizontalRightCenter transform 3D m21 : \(view.layer.transform) is incorrectly calculated")
        XCTAssert(view.layer.transform.m22 == 0.5,
                  "[testVerticalAnimationInterpolation] - view horizontalRightCenter transform 3D m22 : \(view.layer.transform) is incorrectly calculated")
        XCTAssert(view.layer.transform.m23 == 0.5,
                  "[testVerticalAnimationInterpolation] - view horizontalRightCenter transform 3D m23 : \(view.layer.transform) is incorrectly calculated")
        XCTAssert(view.layer.transform.m24 == 0.5,
                  "[testVerticalAnimationInterpolation] - view horizontalRightCenter transform 3d m24 : \(view.layer.transform) is incorrectly calculated")
        XCTAssert(view.layer.transform.m31 == 0.5,
                  "[testVerticalAnimationInterpolation] - view horizontalRightCenter transform 3D m31 : \(view.layer.transform) is incorrectly calculated")
        XCTAssert(view.layer.transform.m32 == 0.5,
                  "[testVerticalAnimationInterpolation] - view horizontalRightCenter transform 3D m32 : \(view.layer.transform) is incorrectly calculated")
        XCTAssert(view.layer.transform.m33 == 0.5,
                  "[testVerticalAnimationInterpolation] - view horizontalRightCenter transform 3D m33 : \(view.layer.transform) is incorrectly calculated")
        XCTAssert(view.layer.transform.m34 == 0.5,
                  "[testVerticalAnimationInterpolation] - view horizontalRightCenter transform 3d m34 : \(view.layer.transform) is incorrectly calculated")
        XCTAssert(view.layer.transform.m41 == 0.5,
                  "[testVerticalAnimationInterpolation] - view horizontalRightCenter transform 3D m41 : \(view.layer.transform) is incorrectly calculated")
        XCTAssert(view.layer.transform.m42 == 0.5,
                  "[testVerticalAnimationInterpolation] - view horizontalRightCenter transform 3D m42 : \(view.layer.transform) is incorrectly calculated")
        XCTAssert(view.layer.transform.m43 == 0.5,
                  "[testVerticalAnimationInterpolation] - view horizontalRightCenter transform 3D m43 : \(view.layer.transform) is incorrectly calculated")
        XCTAssert(view.layer.transform.m44 == 0.5,
                  "[testVerticalAnimationInterpolation] - view horizontalRightCenter transform 3d m44 : \(view.layer.transform) is incorrectly calculated")
    

    }
    
    func testVerticalAnimationStateInterpolation()
    {
        let view = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 200, height: 200))
        view.center = CGPoint(x : 200, y : 200)
        view.layer.shadowOffset = CGSize(width:200, height:200)
        
        let animation = PDAnimator.newVerticalAnimator { (animator) in
            
            animator.startState(for: view, { (s) in
                
                s.alpha(0.0).easing(.linear)
                s.center(CGPoint(x:100, y:100)).easing(.linear)
                s.shadowOffset(CGSize(width:100, height:100)).easing(.linear)
                s.bounds( CGRect(x: 0.0, y: 0.0, width: 400, height: 400)).easing(.linear)
           
            }).endState(for: view, { (s) in
                
                s.alpha(0.0).easing(.linear)
                s.center(CGPoint(x:100, y:100)).easing(.linear)
                s.shadowOffset(CGSize(width:100, height:100)).easing(.linear)
                s.bounds( CGRect(x: 0.0, y: 0.0, width: 400, height: 400)).easing(.linear)
            })
        }
        
        XCTAssert(animation.animatedViews.count == 1, "[testVerticalAnimationMakerProperties] - incorrect animabion count")
        XCTAssert(animation.animatedViews[0].fromState?.animatableProperties.count == 4, "[testVerticalAnimationMakerProperties] - incorrect animabion property count")
        
        for animatableType in animation.animatedViews
        {
            animatableType.configureDefaultStateIfNeeded()
            
            /* Below Center */
            
            animatableType.interpolateState(toProgress: .verticalBelowCenter(progress: 0.5))
            
            XCTAssert(view.alpha == 0.5,
                      "[testVerticalStateInterpolation] - view verticalBelowCenter alpha : \(view.alpha) is incorrectly calculated")
            XCTAssert(view.center.equalTo(CGPoint(x : 150, y : 150)),
                      "[testVerticalStateInterpolation] - view verticalBelowCenter center : \(view.center) is incorrectly calculated")
            XCTAssert(view.layer.shadowOffset.equalTo(CGSize(width:150, height:150)),
                      "[testVerticalStateInterpolation] - view verticalBelowCenter shadowOffet : \(view.layer.shadowOffset) is incorrectly calculated")
            XCTAssert(view.bounds.equalTo( CGRect(x: 0.0, y: 0.0, width: 300, height: 300)),
                      "[testVerticalStateInterpolation] - view verticalBelowCenter bounds : \(view.bounds) is incorrectly calculated")
            
            /* Centered Center */
            
            animatableType.interpolateState(toProgress: .verticalCenter)
            
            XCTAssert(view.alpha == 1.0,
                      "[testVerticalStateInterpolation] - view verticalCenter alpha is incorrectly calculated")
            XCTAssert(view.center.equalTo(CGPoint(x : 200, y : 200)),
                      "[testVerticalStateInterpolation] - view verticalCenter center : \(view.center) is incorrectly calculated")
            XCTAssert(view.layer.shadowOffset.equalTo(CGSize(width:200, height:200)),
                      "[testVerticalStateInterpolation] - view verticalCenter shadowOffet : \(view.layer.shadowOffset) is incorrectly calculated")
            XCTAssert(view.bounds.equalTo( CGRect(x: 0.0, y: 0.0, width: 200, height: 200)),
                      "[testVerticalStateInterpolation] - view verticalCenter bounds : \(view.bounds) is incorrectly calculated")
            
            /* AboveCenter Center */
            
            animatableType.interpolateState(toProgress: .verticalAboveCenter(progress: 0.5))
            
            XCTAssert(view.alpha == 0.5,
                      "[testVerticalStateInterpolation] - view verticalAboveCenter alpha : \(view.alpha) is incorrectly calculated")
            XCTAssert(view.center.equalTo(CGPoint(x : 150, y : 150)),
                      "[testVerticalStateInterpolation] - view verticalAboveCenter center : \(view.center) is incorrectly calculated")
            XCTAssert(view.layer.shadowOffset.equalTo(CGSize(width:150, height:150)),
                      "[testVerticalStateInterpolation] - view verticalAboveCenter shadowOffet : \(view.layer.shadowOffset) is incorrectly calculated")
            XCTAssert(view.bounds.equalTo( CGRect(x: 0.0, y: 0.0, width: 300, height: 300)),
                      "[testVerticalStateInterpolation] - view verticalAboveCenter bounds : \(view.bounds) is incorrectly calculated")
            
        }
    }
    
    func testUniquePropertyValuesPerStateInterpolation()
    {
        let view = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 200, height: 200))
        view.center = CGPoint(x : 200, y : 200)
    
        let animation = PDAnimator.newVerticalAnimator { (animator) in
            
            animator.startState(for: view, { (s) in
                
                s.alpha(0.0).easing(.linear)
                
            }).endState(for: view, { (s) in
                
                s.alpha(0.0).easing(.linear)
                s.center(CGPoint(x : 400, y : 400)).easing(.linear)
                
            })
        }
        
        XCTAssert(animation.animatedViews.count == 1, "[testVerticalAnimationInterpolation] - incorrect animabion count")
        XCTAssert(animation.animatedViews[0].fromState?.animatableProperties.count == 1, "[testVerticalAnimationInterpolation] - incorrect animabion property count")
        XCTAssert(animation.animatedViews[0].toState?.animatableProperties.count == 2, "[testVerticalAnimationInterpolation] - incorrect animabion property count")
        
        for animatableType in animation.animatedViews
        {
            animatableType.configureDefaultStateIfNeeded()
        }
        
        /* Below Center */
        
        animation.interpolateViewAnimation(forProgress: .verticalBelowCenter(progress: 0.5))
        
        XCTAssert(view.alpha == 0.5,
                  "[testVerticalAnimationInterpolation] - view verticalBelowCenter alpha : \(view.alpha) is incorrectly calculated")
        
        /* Centered Center */
        
        animation.interpolateViewAnimation(forProgress: .verticalCenter)
        
        XCTAssert(view.alpha == 1.0,
                  "[testVerticalAnimationInterpolation] - view verticalCenter alpha is incorrectly calculated")
        
        /* AboveCenter Center */
        
        animation.interpolateViewAnimation(forProgress: .verticalAboveCenter(progress: 0.5))
        
        XCTAssert(view.alpha == 0.5,
                  "[testVerticalAnimationInterpolation] - view verticalCenter alpha is incorrectly calculated")
    }
    
    func testVerticalNoEndStateInterpolation()
    {
        let view = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 200, height: 200))
        
        let animation = PDAnimator.newVerticalAnimator { (animator) in
            
            animator.startState(for: view, { (s) in
                
                s.alpha(0.0).easing(.linear)
                
            })
        }
        
        XCTAssert(animation.animatedViews.count == 1, "[testVerticalAnimationInterpolation] - incorrect animabion count")
        XCTAssert(animation.animatedViews[0].fromState?.animatableProperties.count == 1, "[testVerticalAnimationInterpolation] - incorrect animabion property count")
        
        for animatableType in animation.animatedViews
        {
            animatableType.configureDefaultStateIfNeeded()
        }
        
        /* Below Center */
        
        animation.interpolateViewAnimation(forProgress: .verticalBelowCenter(progress: 0.5))
        
        XCTAssert(view.alpha == 0.5,
                  "[testVerticalAnimationInterpolation] - view verticalBelowCenter alpha : \(view.alpha) is incorrectly calculated")
        
        /* Centered Center */
        
        animation.interpolateViewAnimation(forProgress: .verticalCenter)
        
        XCTAssert(view.alpha == 1.0,
                  "[testVerticalAnimationInterpolation] - view verticalCenter alpha is incorrectly calculated")
        
        /* AboveCenter Center */
        
        animation.interpolateViewAnimation(forProgress: .verticalAboveCenter(progress: 0.5))
        
        XCTAssert(view.alpha == 1.0,
                  "[testVerticalAnimationInterpolation] - view verticalCenter alpha is incorrectly calculated")
    }
    
    func testVerticalNoStartStateInterpolation()
    {
        let view = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 200, height: 200))
        
        let animation = PDAnimator.newVerticalAnimator { (animator) in
            
            animator.endState(for: view, { (s) in
                
                s.alpha(0.0).easing(.linear)
                
            })
        }
        
        XCTAssert(animation.animatedViews.count == 1, "[testVerticalAnimationInterpolation] - incorrect animabion count")
        XCTAssert(animation.animatedViews[0].toState?.animatableProperties.count == 1, "[testVerticalAnimationInterpolation] - incorrect animabion property count")
        
        for animatableType in animation.animatedViews
        {
            animatableType.configureDefaultStateIfNeeded()
        }
        
        /* Below Center */
        
        animation.interpolateViewAnimation(forProgress: .verticalBelowCenter(progress: 0.5))
        
        XCTAssert(view.alpha == 1.0,
                  "[testVerticalAnimationInterpolation] - view verticalBelowCenter alpha : \(view.alpha) is incorrectly calculated")
        
        /* Centered Center */
        
        animation.interpolateViewAnimation(forProgress: .verticalCenter)
        
        XCTAssert(view.alpha == 1.0,
                  "[testVerticalAnimationInterpolation] - view verticalCenter alpha is incorrectly calculated")
        
        /* AboveCenter Center */
        
        animation.interpolateViewAnimation(forProgress: .verticalAboveCenter(progress: 0.5))
        
        XCTAssert(view.alpha == 0.5,
                  "[testVerticalAnimationInterpolation] - view verticalCenter alpha is incorrectly calculated")
    }
}
