//
//  PDAnimationMakerTests.swift
//  PDAnimatorTests
//
//  Created by Anton Doudarev on 4/12/18.
//  Copyright © 2018 ELEPHANT. All rights reserved.
//

import XCTest
import UIKit
@testable import Parade

class PDAnimationMakerTests: XCTestCase
{
    var makerTestValues      = [String : (startValue : Any?, endValue:Any?)]()
    var makerRangeTestValues = [String : (startRange : ClosedRange<CGFloat>, endRange:ClosedRange<CGFloat>)]()
    
    override func setUp()
    {
        super.setUp()
       
        setupViewMakerTestValues()
        setupViewMakerRangeTestValues()
    }
    
    func testSwizzledMethodsUpdates()
    {
        UIScrollView.initializeParade()
        
        let scrollView = UIScrollView()
        scrollView.updateViews()
        
        let tableView = UITableView(frame: CGRect(x: 0.0, y: 0.0, width: 200, height: 200))
        tableView.updateViews()
        tableView.contentOffset = CGPoint(x: 0.0, y: 1.0)

        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.updateViews()
        collectionView.setContentOffset(CGPoint(x: 0.0, y: 1.0), animated: true)
    }
    
    func setupViewMakerTestValues()
    {
        makerTestValues["alpha"]            = (startValue : CGFloat(0.0),
                                               endValue   : CGFloat(0.5))
        
        makerTestValues["backgroundColor"]  = (startValue : UIColor.blue,
                                               endValue   : UIColor.orange)
        
        // Make sure that bounds size is the same as the size property
        // settings the size, actually creates a bounding rect with a zero origin
        makerTestValues["bounds"]           = (startValue : CGRect(x: 0, y: 0, width: 400, height : 400),
                                               endValue   : CGRect(x: 0, y: 0, width: 700, height : 700))

        // Make sure that bounds size is the same as the size property
        // settings the size, actually creates a bounding rect with a zero origin
        makerTestValues["size"]             = (startValue : CGSize(width: 400, height : 400),
                                               endValue   : CGSize(width: 700, height : 700))
        
        makerTestValues["center"]           = (startValue : CGPoint(x:200, y:200),
                                               endValue   : CGPoint(x: 500, y: 500))
    
        makerTestValues["transform"]        = (startValue : CGAffineTransform.identity.scaledBy(x: 0.5, y: 0.5).translatedBy(x: 0, y: 150.0),
                                               endValue   : CGAffineTransform.identity.scaledBy(x: 1.5, y: 1.5).translatedBy(x: 0, y: 300.0))
        
        makerTestValues["borderWidth"]      = (startValue : CGFloat(0.0),
                                               endValue   : CGFloat(0.5))
        
        makerTestValues["borderColor"]      = (startValue : UIColor.green.cgColor,
                                               endValue   : UIColor.yellow.cgColor)
        
        makerTestValues["contentsRect"]     = (startValue : CGRect(x: 200, y: 200, width: 350, height : 350),
                                               endValue   : CGRect(x: 300, y: 300, width: 500, height : 500))
        
        makerTestValues["cornerRadius"]     = (startValue : CGFloat(4.0),
                                               endValue   : CGFloat(6.0))
        
        makerTestValues["shadowColor"]      = (startValue : UIColor.magenta.cgColor,
                                               endValue   : UIColor.green.cgColor)
        
        makerTestValues["shadowOpacity"]    = (startValue : CGFloat(0.25),
                                               endValue   : CGFloat(0.5))
        
        makerTestValues["shadowOffset"]     = (startValue : CGSize(width: 400, height : 400),
                                               endValue   : CGSize(width: 700, height : 700))
        
        makerTestValues["shadowRadius"]     = (startValue : CGFloat(4.0),
                                               endValue   : CGFloat(2.0))
        
        makerTestValues["zPosition"]        = (startValue : CGFloat(20),
                                               endValue   : CGFloat(6))
        
        makerTestValues["transform3D"]      = (startValue : CATransform3DTranslate(CATransform3DIdentity, 0, -200, 200),
                                               endValue   : CATransform3DTranslate(CATransform3DIdentity, 0, -300, 300))
        
        makerTestValues["customViewValue"]  = (startValue : CGFloat(40),
                                               endValue   : CGFloat(60))
        
        makerTestValues["customLayerValue"] = (startValue : CGFloat(20),
                                               endValue   : CGFloat(30))
    }
    
    func setupViewMakerRangeTestValues()
    {
        makerRangeTestValues["alpha"]            = (startRange : 0.1...0.2,
                                                    endRange   : 0.3...0.6)
        
        makerRangeTestValues["backgroundColor"]  = (startRange : 0.1...0.2,
                                                    endRange   : 0.3...0.6)
        
        makerRangeTestValues["bounds"]           = (startRange : 0.1...0.2,
                                                    endRange   : 0.3...0.6)
        
        makerRangeTestValues["center"]           = (startRange : 0.1...0.2,
                                                    endRange   : 0.3...0.6)
        
        makerRangeTestValues["size"]             = (startRange : 0.1...0.2,
                                                    endRange   : 0.3...0.6)
        
        makerRangeTestValues["transform"]        = (startRange : 0.1...0.2,
                                                    endRange   : 0.3...0.6)
        
        makerRangeTestValues["borderWidth"]      = (startRange : 0.1...0.2,
                                                    endRange   : 0.3...0.6)
        
        makerRangeTestValues["borderColor"]      = (startRange : 0.1...0.2,
                                                    endRange   : 0.3...0.6)
        
        makerRangeTestValues["contentsRect"]     = (startRange : 0.1...0.2,
                                                    endRange   : 0.3...0.6)
        
        makerRangeTestValues["cornerRadius"]     = (startRange : 0.1...0.2,
                                                    endRange   : 0.3...0.6)
        
        makerRangeTestValues["shadowColor"]      = (startRange : 0.1...0.2,
                                                    endRange   : 0.3...0.6)
        
        makerRangeTestValues["shadowOpacity"]    = (startRange : 0.1...0.2,
                                                    endRange   : 0.3...0.6)
        
        makerRangeTestValues["shadowOffset"]     = (startRange : 0.1...0.2,
                                                    endRange   : 0.3...0.6)
        
        makerRangeTestValues["shadowRadius"]     = (startRange : 0.1...0.2,
                                                    endRange   : 0.3...0.6)
        
        makerRangeTestValues["zPosition"]        = (startRange : 0.1...0.2,
                                                    endRange   : 0.3...0.6)
        
        makerRangeTestValues["transform3D"]      = (startRange : 0.1...0.2,
                                                    endRange   : 0.3...0.6)
        
        makerRangeTestValues["customViewValue"]  = (startRange : 0.1...0.2,
                                                    endRange   : 0.3...0.6)
        
        makerRangeTestValues["customLayerValue"] = (startRange : 0.1...0.2,
                                                    endRange   : 0.3...0.6)
    }
    
    func testVerticalAnimationMakerViewSizeProperty()
    {
        let view = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 200, height: 200))
    
        let animation = PDAnimator.newVerticalAnimator { (animator) in
            
            animator.startState(for: view, { (s) in
                s.size(makerTestValues["size"]!.startValue as! CGSize).range(makerRangeTestValues["size"]!.startRange).easing(.outSine)
            }).endState(for: view, { (s) in
                s.size(makerTestValues["size"]!.endValue as! CGSize).range(makerRangeTestValues["size"]!.endRange).easing(.outSine)
            })
        }
        
        let fromStateProperties = animation.animatedViews.first!.fromState!.animatableProperties
        let endStateProperties = animation.animatedViews.first!.toState!.animatableProperties
        
        for (_, property) in fromStateProperties
        {
            testStartValue(property: property, testMethodName: "testVerticalAnimationMakerViewSizeProperty")
        }
        
        for  (_, property) in endStateProperties
        {
            testEndValue(property: property, testMethodName: "testVerticalAnimationMakerViewSizeProperty")
        }
    }
    
    func testVerticalAnimationMakerProperties()
    {
        let view = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 200, height: 200))
        
        let animation = PDAnimator.newVerticalAnimator { (animator) in
            
            animator.startState(for: view, { (s) in
                
                s.alpha(makerTestValues["alpha"]!.startValue as! CGFloat).range(makerRangeTestValues["alpha"]!.startRange).easing(.outSine)
                s.backgroundColor(makerTestValues["backgroundColor"]!.startValue as! UIColor).range(makerRangeTestValues["backgroundColor"]!.startRange).easing(.outSine)
                s.bounds(makerTestValues["bounds"]!.startValue as! CGRect).range(makerRangeTestValues["bounds"]!.startRange).easing(.outSine)
                s.center(makerTestValues["center"]!.startValue as! CGPoint).range(makerRangeTestValues["center"]!.startRange).easing(.outSine)
                s.transform(makerTestValues["transform"]!.startValue as! CGAffineTransform).range(makerRangeTestValues["transform"]!.startRange).easing(.inSine)
                s.borderWidth(makerTestValues["borderWidth"]!.startValue as! CGFloat).range(makerRangeTestValues["borderWidth"]!.startRange).easing(.outSine)
                s.borderColor(makerTestValues["borderColor"]!.startValue as! CGColor).range(makerRangeTestValues["borderColor"]!.startRange).easing(.outSine)
                s.contentsRect(makerTestValues["contentsRect"]!.startValue as! CGRect).range(makerRangeTestValues["contentsRect"]!.startRange).easing(.outSine)
                s.cornerRadius(makerTestValues["cornerRadius"]!.startValue as! CGFloat).range(makerRangeTestValues["cornerRadius"]!.startRange).easing(.outSine)
                s.shadowColor(makerTestValues["shadowColor"]!.startValue as! CGColor).range(makerRangeTestValues["shadowColor"]!.startRange).easing(.outSine)
                s.shadowOpacity(makerTestValues["shadowOpacity"]!.startValue as! CGFloat).range(makerRangeTestValues["shadowOpacity"]!.startRange).easing(.outSine)
                s.shadowOffset(makerTestValues["shadowOffset"]!.startValue as! CGSize).range(makerRangeTestValues["shadowOffset"]!.startRange).easing(.inSine)
                s.shadowRadius(makerTestValues["shadowRadius"]!.startValue as! CGFloat).range(makerRangeTestValues["shadowRadius"]!.startRange).easing(.inSine)
                s.zPosition(makerTestValues["zPosition"]!.startValue as! CGFloat).range(makerRangeTestValues["zPosition"]!.startRange).easing(.inSine)
                s.transform3D(makerTestValues["transform3D"]!.startValue as! CATransform3D).range(makerRangeTestValues["transform3D"]!.startRange).easing(.inSine)
                s.layerValue(makerTestValues["customLayerValue"]!.startValue as! CGFloat, forKey : "customLayerValue" ).range(makerRangeTestValues["customLayerValue"]!.startRange)
                s.viewValue(makerTestValues["customViewValue"]!.startValue as! CGFloat, forKey : "customViewValue" ).range(makerRangeTestValues["customViewValue"]!.startRange)
                
            }).endState(for: view, { (s) in
                
                s.alpha(makerTestValues["alpha"]!.endValue as! CGFloat).range(makerRangeTestValues["alpha"]!.endRange).easing(.outSine)
                s.backgroundColor(makerTestValues["backgroundColor"]!.endValue as! UIColor).range(makerRangeTestValues["backgroundColor"]!.endRange).easing(.outSine)
                s.bounds(makerTestValues["bounds"]!.endValue as! CGRect).range(makerRangeTestValues["bounds"]!.endRange).easing(.outSine)
                s.center(makerTestValues["center"]!.endValue as! CGPoint).range(makerRangeTestValues["center"]!.endRange).easing(.outSine)
                s.transform(makerTestValues["transform"]!.endValue as! CGAffineTransform).range(makerRangeTestValues["transform"]!.endRange).easing(.inSine)
                s.borderWidth(makerTestValues["borderWidth"]!.endValue as! CGFloat).range(makerRangeTestValues["borderWidth"]!.endRange).easing(.outSine)
                s.borderColor(makerTestValues["borderColor"]!.endValue as! CGColor).range(makerRangeTestValues["borderColor"]!.endRange).easing(.outSine)
                s.contentsRect(makerTestValues["contentsRect"]!.endValue as! CGRect).range(makerRangeTestValues["contentsRect"]!.endRange).easing(.outSine)
                s.cornerRadius(makerTestValues["cornerRadius"]!.endValue as! CGFloat).range(makerRangeTestValues["cornerRadius"]!.endRange).easing(.outSine)
                s.shadowColor(makerTestValues["shadowColor"]!.endValue as! CGColor).range(makerRangeTestValues["shadowColor"]!.endRange).easing(.outSine)
                s.shadowOpacity(makerTestValues["shadowOpacity"]!.endValue as! CGFloat).range(makerRangeTestValues["shadowOpacity"]!.endRange).easing(.outSine)
                s.shadowRadius(makerTestValues["shadowRadius"]!.endValue as! CGFloat).range(makerRangeTestValues["shadowRadius"]!.endRange).easing(.inSine)
                s.shadowOffset(makerTestValues["shadowOffset"]!.endValue as! CGSize).range(makerRangeTestValues["shadowOffset"]!.endRange).easing(.inSine)
                s.zPosition(makerTestValues["zPosition"]!.endValue as! CGFloat).range(makerRangeTestValues["zPosition"]!.endRange).easing(.inSine)
                s.transform3D(makerTestValues["transform3D"]!.endValue as! CATransform3D).range(makerRangeTestValues["transform3D"]!.endRange).easing(.inSine)
                s.layerValue(makerTestValues["customLayerValue"]!.endValue as! CGFloat, forKey : "customLayerValue" ).range(makerRangeTestValues["customLayerValue"]!.endRange)
                s.viewValue(makerTestValues["customViewValue"]!.endValue as! CGFloat, forKey : "customViewValue" ).range(makerRangeTestValues["customViewValue"]!.endRange)
                
            })
        }
        
        XCTAssert(animation.animatedViews.count == 1, "[testVerticalAnimationMakerProperties] - incorrect animabion count")
        XCTAssert(animation.animatedViews[0].fromState?.animatableProperties.count == 17, "[testVerticalAnimationMakerProperties] - incorrect animabion property count")
        
        for animatableType in animation.animatedViews
        {
            let fromStateProperties = animatableType.fromState!.animatableProperties
            let endStateProperties = animatableType.toState!.animatableProperties
        
            for (_, property) in fromStateProperties
            {
                testStartValue(property: property, testMethodName: "testVerticalAnimationMakerProperties")
            }
            
            for  (_, property) in endStateProperties
            {
                testEndValue(property: property, testMethodName: "testVerticalAnimationMakerProperties")
            }
        }
    }
    
    func testHorizontalAnimationMakerProperties()
    {
        let view = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 200, height: 200))
        
        let animation = PDAnimator.newHorizontalAnimator { (animator) in
            
            animator.startState(for: view, { (s) in
                
                s.alpha(makerTestValues["alpha"]!.startValue as! CGFloat).range(makerRangeTestValues["alpha"]!.startRange).easing(.outSine)
                s.backgroundColor(makerTestValues["backgroundColor"]!.startValue as! UIColor).range(makerRangeTestValues["backgroundColor"]!.startRange).easing(.outSine)
                s.bounds(makerTestValues["bounds"]!.startValue as! CGRect).range(makerRangeTestValues["bounds"]!.startRange).easing(.outSine)
                s.center(makerTestValues["center"]!.startValue as! CGPoint).range(makerRangeTestValues["center"]!.startRange).easing(.outSine)
                s.transform(makerTestValues["transform"]!.startValue as! CGAffineTransform).range(makerRangeTestValues["transform"]!.startRange).easing(.inSine)
                s.borderWidth(makerTestValues["borderWidth"]!.startValue as! CGFloat).range(makerRangeTestValues["borderWidth"]!.startRange).easing(.outSine)
                s.borderColor(makerTestValues["borderColor"]!.startValue as! CGColor).range(makerRangeTestValues["borderColor"]!.startRange).easing(.outSine)
                s.contentsRect(makerTestValues["contentsRect"]!.startValue as! CGRect).range(makerRangeTestValues["contentsRect"]!.startRange).easing(.outSine)
                s.cornerRadius(makerTestValues["cornerRadius"]!.startValue as! CGFloat).range(makerRangeTestValues["cornerRadius"]!.startRange).easing(.outSine)
                s.shadowColor(makerTestValues["shadowColor"]!.startValue as! CGColor).range(makerRangeTestValues["shadowColor"]!.startRange).easing(.outSine)
                s.shadowOpacity(makerTestValues["shadowOpacity"]!.startValue as! CGFloat).range(makerRangeTestValues["shadowOpacity"]!.startRange).easing(.outSine)
                s.shadowOffset(makerTestValues["shadowOffset"]!.startValue as! CGSize).range(makerRangeTestValues["shadowOffset"]!.startRange).easing(.inSine)
                s.shadowRadius(makerTestValues["shadowRadius"]!.startValue as! CGFloat).range(makerRangeTestValues["shadowRadius"]!.startRange).easing(.inSine)
                s.zPosition(makerTestValues["zPosition"]!.startValue as! CGFloat).range(makerRangeTestValues["zPosition"]!.startRange).easing(.inSine)
                s.transform3D(makerTestValues["transform3D"]!.startValue as! CATransform3D).range(makerRangeTestValues["transform3D"]!.startRange).easing(.inSine)
                s.layerValue(makerTestValues["customLayerValue"]!.startValue as! CGFloat, forKey : "customLayerValue" ).range(makerRangeTestValues["customLayerValue"]!.startRange)
                s.viewValue(makerTestValues["customViewValue"]!.startValue as! CGFloat, forKey : "customViewValue" ).range(makerRangeTestValues["customViewValue"]!.startRange)
                
            }).endState(for: view, { (s) in
                
                s.alpha(makerTestValues["alpha"]!.endValue as! CGFloat).range(makerRangeTestValues["alpha"]!.endRange).easing(.outSine)
                s.backgroundColor(makerTestValues["backgroundColor"]!.endValue as! UIColor).range(makerRangeTestValues["backgroundColor"]!.endRange).easing(.outSine)
                s.bounds(makerTestValues["bounds"]!.endValue as! CGRect).range(makerRangeTestValues["bounds"]!.endRange).easing(.outSine)
                s.center(makerTestValues["center"]!.endValue as! CGPoint).range(makerRangeTestValues["center"]!.endRange).easing(.outSine)
                s.transform(makerTestValues["transform"]!.endValue as! CGAffineTransform).range(makerRangeTestValues["transform"]!.endRange).easing(.inSine)
                s.borderWidth(makerTestValues["borderWidth"]!.endValue as! CGFloat).range(makerRangeTestValues["borderWidth"]!.endRange).easing(.outSine)
                s.borderColor(makerTestValues["borderColor"]!.endValue as! CGColor).range(makerRangeTestValues["borderColor"]!.endRange).easing(.outSine)
                s.contentsRect(makerTestValues["contentsRect"]!.endValue as! CGRect).range(makerRangeTestValues["contentsRect"]!.endRange).easing(.outSine)
                s.cornerRadius(makerTestValues["cornerRadius"]!.endValue as! CGFloat).range(makerRangeTestValues["cornerRadius"]!.endRange).easing(.outSine)
                s.shadowColor(makerTestValues["shadowColor"]!.endValue as! CGColor).range(makerRangeTestValues["shadowColor"]!.endRange).easing(.outSine)
                s.shadowOpacity(makerTestValues["shadowOpacity"]!.endValue as! CGFloat).range(makerRangeTestValues["shadowOpacity"]!.endRange).easing(.outSine)
                s.shadowRadius(makerTestValues["shadowRadius"]!.endValue as! CGFloat).range(makerRangeTestValues["shadowRadius"]!.endRange).easing(.inSine)
                s.shadowOffset(makerTestValues["shadowOffset"]!.endValue as! CGSize).range(makerRangeTestValues["shadowOffset"]!.endRange).easing(.inSine)
                s.zPosition(makerTestValues["zPosition"]!.endValue as! CGFloat).range(makerRangeTestValues["zPosition"]!.endRange).easing(.inSine)
                s.transform3D(makerTestValues["transform3D"]!.endValue as! CATransform3D).range(makerRangeTestValues["transform3D"]!.endRange).easing(.inSine)
                s.layerValue(makerTestValues["customLayerValue"]!.endValue as! CGFloat, forKey : "customLayerValue" ).range(makerRangeTestValues["customLayerValue"]!.endRange)
                s.viewValue(makerTestValues["customViewValue"]!.endValue as! CGFloat, forKey : "customViewValue" ).range(makerRangeTestValues["customViewValue"]!.endRange)
                
            })
        }
        
        XCTAssert(animation.animatedViews.count == 1, "[testHorizontalAnimationMakerProperties] - incorrect animabion count")
        XCTAssert(animation.animatedViews[0].fromState?.animatableProperties.count == 17, "[testHorizontalAnimationMakerProperties] - incorrect animabion property count")
        
        for animatableType in animation.animatedViews
        {
            let fromStateProperties = animatableType.fromState!.animatableProperties
            let endStateProperties = animatableType.toState!.animatableProperties
            
            for(_, property) in fromStateProperties
            {
                testStartValue(property: property, testMethodName: "testHorizontalAnimationMakerProperties")
            }
            
            for (_, property) in endStateProperties
            {
                testEndValue(property: property, testMethodName: "testHorizontalAnimationMakerProperties")
            }
        }
    }
    
    func testVerticalMultipStateAnimationMakerProperties()
    {
        let view = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 200, height: 200))
        
        let animation = PDAnimator.newVerticalAnimator { (animator) in
            
            animator.startEndState(for: view, { (s) in
                
                s.alpha(makerTestValues["alpha"]!.startValue as! CGFloat).range(makerRangeTestValues["alpha"]!.startRange).easing(.outSine)
                s.backgroundColor(makerTestValues["backgroundColor"]!.startValue as! UIColor).range(makerRangeTestValues["backgroundColor"]!.startRange).easing(.outSine)
                s.bounds(makerTestValues["bounds"]!.startValue as! CGRect).range(makerRangeTestValues["bounds"]!.startRange).easing(.outSine)
                s.center(makerTestValues["center"]!.startValue as! CGPoint).range(makerRangeTestValues["center"]!.startRange).easing(.outSine)
                s.transform(makerTestValues["transform"]!.startValue as! CGAffineTransform).range(makerRangeTestValues["transform"]!.startRange).easing(.inSine)
                s.borderWidth(makerTestValues["borderWidth"]!.startValue as! CGFloat).range(makerRangeTestValues["borderWidth"]!.startRange).easing(.outSine)
                s.borderColor(makerTestValues["borderColor"]!.startValue as! CGColor).range(makerRangeTestValues["borderColor"]!.startRange).easing(.outSine)
                s.contentsRect(makerTestValues["contentsRect"]!.startValue as! CGRect).range(makerRangeTestValues["contentsRect"]!.startRange).easing(.outSine)
                s.cornerRadius(makerTestValues["cornerRadius"]!.startValue as! CGFloat).range(makerRangeTestValues["cornerRadius"]!.startRange).easing(.outSine)
                s.shadowColor(makerTestValues["shadowColor"]!.startValue as! CGColor).range(makerRangeTestValues["shadowColor"]!.startRange).easing(.outSine)
                s.shadowOpacity(makerTestValues["shadowOpacity"]!.startValue as! CGFloat).range(makerRangeTestValues["shadowOpacity"]!.startRange).easing(.outSine)
                s.shadowOffset(makerTestValues["shadowOffset"]!.startValue as! CGSize).range(makerRangeTestValues["shadowOffset"]!.startRange).easing(.inSine)
                s.shadowRadius(makerTestValues["shadowRadius"]!.startValue as! CGFloat).range(makerRangeTestValues["shadowRadius"]!.startRange).easing(.inSine)
                s.zPosition(makerTestValues["zPosition"]!.startValue as! CGFloat).range(makerRangeTestValues["zPosition"]!.startRange).easing(.inSine)
                s.transform3D(makerTestValues["transform3D"]!.startValue as! CATransform3D).range(makerRangeTestValues["transform3D"]!.startRange).easing(.inSine)
                s.layerValue(makerTestValues["customLayerValue"]!.startValue as! CGFloat, forKey : "customLayerValue" ).range(makerRangeTestValues["customLayerValue"]!.startRange)
                s.viewValue(makerTestValues["customViewValue"]!.startValue as! CGFloat, forKey : "customViewValue" ).range(makerRangeTestValues["customViewValue"]!.startRange)
                
            })
        }
        
        XCTAssert(animation.animatedViews.count == 1, "[testVerticalMultipStateAnimationMakerProperties] - incorrect animabion count")
        XCTAssert(animation.animatedViews[0].fromState?.animatableProperties.count == 17, "[testVerticalMultipStateAnimationMakerProperties] - incorrect animabion property count")
        
        for animatableType in animation.animatedViews {
            
            let fromStateProperties = animatableType.fromState!.animatableProperties
            let endStateProperties = animatableType.toState!.animatableProperties
            
            for (_, property) in fromStateProperties
            {
                testStartValue(property: property, testMethodName: "testVerticalMultipStateAnimationMakerProperties")
            }
            
            for (_, property) in endStateProperties
            {
                testStartValue(property: property, testMethodName: "testVerticalMultipStateAnimationMakerProperties")
            }
        }
    }
    
    func testVerticalMultipViewsAnimationMakerProperties()
    {
        let view1 = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 200, height: 200))
        let view2 = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 200, height: 200))
        let view3 = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 200, height: 200))
        let view4 = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 200, height: 200))
        
        let viewArray = [view1, view2, view3, view4]
        
        let animation = PDAnimator.newVerticalAnimator { (animator) in
            
            animator.startState(forViews: viewArray, { (s) in
                
                s.alpha(makerTestValues["alpha"]!.startValue as! CGFloat).range(makerRangeTestValues["alpha"]!.startRange).easing(.outSine)
                s.backgroundColor(makerTestValues["backgroundColor"]!.startValue as! UIColor).range(makerRangeTestValues["backgroundColor"]!.startRange).easing(.outSine)
                s.bounds(makerTestValues["bounds"]!.startValue as! CGRect).range(makerRangeTestValues["bounds"]!.startRange).easing(.outSine)
                s.center(makerTestValues["center"]!.startValue as! CGPoint).range(makerRangeTestValues["center"]!.startRange).easing(.outSine)
                s.transform(makerTestValues["transform"]!.startValue as! CGAffineTransform).range(makerRangeTestValues["transform"]!.startRange).easing(.inSine)
                s.borderWidth(makerTestValues["borderWidth"]!.startValue as! CGFloat).range(makerRangeTestValues["borderWidth"]!.startRange).easing(.outSine)
                s.borderColor(makerTestValues["borderColor"]!.startValue as! CGColor).range(makerRangeTestValues["borderColor"]!.startRange).easing(.outSine)
                s.contentsRect(makerTestValues["contentsRect"]!.startValue as! CGRect).range(makerRangeTestValues["contentsRect"]!.startRange).easing(.outSine)
                s.cornerRadius(makerTestValues["cornerRadius"]!.startValue as! CGFloat).range(makerRangeTestValues["cornerRadius"]!.startRange).easing(.outSine)
                s.shadowColor(makerTestValues["shadowColor"]!.startValue as! CGColor).range(makerRangeTestValues["shadowColor"]!.startRange).easing(.outSine)
                s.shadowOpacity(makerTestValues["shadowOpacity"]!.startValue as! CGFloat).range(makerRangeTestValues["shadowOpacity"]!.startRange).easing(.outSine)
                s.shadowOffset(makerTestValues["shadowOffset"]!.startValue as! CGSize).range(makerRangeTestValues["shadowOffset"]!.startRange).easing(.inSine)
                s.shadowRadius(makerTestValues["shadowRadius"]!.startValue as! CGFloat).range(makerRangeTestValues["shadowRadius"]!.startRange).easing(.inSine)
                s.zPosition(makerTestValues["zPosition"]!.startValue as! CGFloat).range(makerRangeTestValues["zPosition"]!.startRange).easing(.inSine)
                s.transform3D(makerTestValues["transform3D"]!.startValue as! CATransform3D).range(makerRangeTestValues["transform3D"]!.startRange).easing(.inSine)
                s.layerValue(makerTestValues["customLayerValue"]!.startValue as! CGFloat, forKey : "customLayerValue" ).range(makerRangeTestValues["customLayerValue"]!.startRange)
                s.viewValue(makerTestValues["customViewValue"]!.startValue as! CGFloat, forKey : "customViewValue" ).range(makerRangeTestValues["customViewValue"]!.startRange)
                
            }).endState(forViews: viewArray, { (s) in
                
                s.alpha(makerTestValues["alpha"]!.endValue as! CGFloat).range(makerRangeTestValues["alpha"]!.endRange).easing(.outSine)
                s.backgroundColor(makerTestValues["backgroundColor"]!.endValue as! UIColor).range(makerRangeTestValues["backgroundColor"]!.endRange).easing(.outSine)
                s.bounds(makerTestValues["bounds"]!.endValue as! CGRect).range(makerRangeTestValues["bounds"]!.endRange).easing(.outSine)
                s.center(makerTestValues["center"]!.endValue as! CGPoint).range(makerRangeTestValues["center"]!.endRange).easing(.outSine)
                s.transform(makerTestValues["transform"]!.endValue as! CGAffineTransform).range(makerRangeTestValues["transform"]!.endRange).easing(.inSine)
                s.borderWidth(makerTestValues["borderWidth"]!.endValue as! CGFloat).range(makerRangeTestValues["borderWidth"]!.endRange).easing(.outSine)
                s.borderColor(makerTestValues["borderColor"]!.endValue as! CGColor).range(makerRangeTestValues["borderColor"]!.endRange).easing(.outSine)
                s.contentsRect(makerTestValues["contentsRect"]!.endValue as! CGRect).range(makerRangeTestValues["contentsRect"]!.endRange).easing(.outSine)
                s.cornerRadius(makerTestValues["cornerRadius"]!.endValue as! CGFloat).range(makerRangeTestValues["cornerRadius"]!.endRange).easing(.outSine)
                s.shadowColor(makerTestValues["shadowColor"]!.endValue as! CGColor).range(makerRangeTestValues["shadowColor"]!.endRange).easing(.outSine)
                s.shadowOpacity(makerTestValues["shadowOpacity"]!.endValue as! CGFloat).range(makerRangeTestValues["shadowOpacity"]!.endRange).easing(.outSine)
                s.shadowRadius(makerTestValues["shadowRadius"]!.endValue as! CGFloat).range(makerRangeTestValues["shadowRadius"]!.endRange).easing(.inSine)
                s.shadowOffset(makerTestValues["shadowOffset"]!.endValue as! CGSize).range(makerRangeTestValues["shadowOffset"]!.endRange).easing(.inSine)
                s.zPosition(makerTestValues["zPosition"]!.endValue as! CGFloat).range(makerRangeTestValues["zPosition"]!.endRange).easing(.inSine)
                s.transform3D(makerTestValues["transform3D"]!.endValue as! CATransform3D).range(makerRangeTestValues["transform3D"]!.endRange).easing(.inSine)
                s.layerValue(makerTestValues["customLayerValue"]!.endValue as! CGFloat, forKey : "customLayerValue" ).range(makerRangeTestValues["customLayerValue"]!.endRange)
                s.viewValue(makerTestValues["customViewValue"]!.endValue as! CGFloat, forKey : "customViewValue" ).range(makerRangeTestValues["customViewValue"]!.endRange)
                
            })
        }
        
        XCTAssert(animation.animatedViews.count == 4, "[testVerticalMultipViewsAnimationMakerProperties] - incorrect animabion count")
        XCTAssert(animation.animatedViews[0].fromState?.animatableProperties.count == 17, "[testVerticalMultipViewsAnimationMakerProperties] - incorrect animabion property count")
        XCTAssert(animation.animatedViews[1].fromState?.animatableProperties.count == 17, "[testVerticalMultipViewsAnimationMakerProperties] - incorrect animabion property count")
        XCTAssert(animation.animatedViews[2].fromState?.animatableProperties.count == 17, "[testVerticalMultipViewsAnimationMakerProperties] - incorrect animabion property count")
        XCTAssert(animation.animatedViews[3].fromState?.animatableProperties.count == 17, "[testVerticalMultipViewsAnimationMakerProperties] - incorrect animabion property count")
        
        for animatableType in animation.animatedViews {
            
            let fromStateProperties = animatableType.fromState!.animatableProperties
            let endStateProperties = animatableType.toState!.animatableProperties
            
            for (_, property) in fromStateProperties
            {
                testStartValue(property: property, testMethodName: "testVerticalMultipViewsAnimationMakerProperties")
            }
            
            for (_, property) in endStateProperties
            {
                testEndValue(property: property, testMethodName: "testVerticalMultipViewsAnimationMakerProperties")
            }
        }
    }
    
    func testVerticalMultipViewsAnimationStartEndMakerProperties()
    {
        let view1 = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 200, height: 200))
        let view2 = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 200, height: 200))
        let view3 = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 200, height: 200))
        let view4 = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 200, height: 200))
        
        let viewArray = [view1, view2, view3, view4]
        
        let animation = PDAnimator.newVerticalAnimator { (animator) in
            
            animator.startEndState(forViews: viewArray, { (s) in
                
                s.alpha(makerTestValues["alpha"]!.startValue as! CGFloat).range(makerRangeTestValues["alpha"]!.startRange).easing(.outSine)
                s.backgroundColor(makerTestValues["backgroundColor"]!.startValue as! UIColor).range(makerRangeTestValues["backgroundColor"]!.startRange).easing(.outSine)
                s.bounds(makerTestValues["bounds"]!.startValue as! CGRect).range(makerRangeTestValues["bounds"]!.startRange).easing(.outSine)
                s.center(makerTestValues["center"]!.startValue as! CGPoint).range(makerRangeTestValues["center"]!.startRange).easing(.outSine)
                s.transform(makerTestValues["transform"]!.startValue as! CGAffineTransform).range(makerRangeTestValues["transform"]!.startRange).easing(.inSine)
                s.borderWidth(makerTestValues["borderWidth"]!.startValue as! CGFloat).range(makerRangeTestValues["borderWidth"]!.startRange).easing(.outSine)
                s.borderColor(makerTestValues["borderColor"]!.startValue as! CGColor).range(makerRangeTestValues["borderColor"]!.startRange).easing(.outSine)
                s.contentsRect(makerTestValues["contentsRect"]!.startValue as! CGRect).range(makerRangeTestValues["contentsRect"]!.startRange).easing(.outSine)
                s.cornerRadius(makerTestValues["cornerRadius"]!.startValue as! CGFloat).range(makerRangeTestValues["cornerRadius"]!.startRange).easing(.outSine)
                s.shadowColor(makerTestValues["shadowColor"]!.startValue as! CGColor).range(makerRangeTestValues["shadowColor"]!.startRange).easing(.outSine)
                s.shadowOpacity(makerTestValues["shadowOpacity"]!.startValue as! CGFloat).range(makerRangeTestValues["shadowOpacity"]!.startRange).easing(.outSine)
                s.shadowOffset(makerTestValues["shadowOffset"]!.startValue as! CGSize).range(makerRangeTestValues["shadowOffset"]!.startRange).easing(.inSine)
                s.shadowRadius(makerTestValues["shadowRadius"]!.startValue as! CGFloat).range(makerRangeTestValues["shadowRadius"]!.startRange).easing(.inSine)
                s.zPosition(makerTestValues["zPosition"]!.startValue as! CGFloat).range(makerRangeTestValues["zPosition"]!.startRange).easing(.inSine)
                s.transform3D(makerTestValues["transform3D"]!.startValue as! CATransform3D).range(makerRangeTestValues["transform3D"]!.startRange).easing(.inSine)
                s.layerValue(makerTestValues["customLayerValue"]!.startValue as! CGFloat, forKey : "customLayerValue" ).range(makerRangeTestValues["customLayerValue"]!.startRange)
                s.viewValue(makerTestValues["customViewValue"]!.startValue as! CGFloat, forKey : "customViewValue" ).range(makerRangeTestValues["customViewValue"]!.startRange)
                
            })
        }
        
        XCTAssert(animation.animatedViews.count == 4, "[testVerticalMultipViewsAnimationStartEndMakerProperties] - incorrect animabion count")
        XCTAssert(animation.animatedViews[0].fromState?.animatableProperties.count == 17, "[testVerticalMultipViewsAnimationStartEndMakerProperties] - incorrect animabion property count")
        XCTAssert(animation.animatedViews[1].fromState?.animatableProperties.count == 17, "[testVerticalMultipViewsAnimationStartEndMakerProperties] - incorrect animabion property count")
        XCTAssert(animation.animatedViews[2].fromState?.animatableProperties.count == 17, "[testVerticalMultipViewsAnimationStartEndMakerProperties] - incorrect animabion property count")
        XCTAssert(animation.animatedViews[3].fromState?.animatableProperties.count == 17, "[testVerticalMultipViewsAnimationStartEndMakerProperties] - incorrect animabion property count")
        
        for animatableType in animation.animatedViews {
            
            let fromStateProperties = animatableType.fromState!.animatableProperties
            let endStateProperties = animatableType.toState!.animatableProperties
            
            for (_, property) in fromStateProperties
            {
                testStartValue(property: property, testMethodName: "testVerticalMultipViewsAnimationStartEndMakerProperties")
            }
            
            for (_, property) in endStateProperties
            {
                testStartValue(property: property, testMethodName: "testVerticalMultipViewsAnimationStartEndMakerProperties")
            }
        }
    }
    
    func testVerticalStartOnlyAnimationMakerProperties()
    {
        let view = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 200, height: 200))
        
        let animation = PDAnimator.newVerticalAnimator { (animator) in
            
            animator.startState(for: view, { (s) in
                
                s.alpha(makerTestValues["alpha"]!.startValue as! CGFloat).range(makerRangeTestValues["alpha"]!.startRange).easing(.outSine)
                s.backgroundColor(makerTestValues["backgroundColor"]!.startValue as! UIColor).range(makerRangeTestValues["backgroundColor"]!.startRange).easing(.outSine)
                s.bounds(makerTestValues["bounds"]!.startValue as! CGRect).range(makerRangeTestValues["bounds"]!.startRange).easing(.outSine)
                s.center(makerTestValues["center"]!.startValue as! CGPoint).range(makerRangeTestValues["center"]!.startRange).easing(.outSine)
                s.transform(makerTestValues["transform"]!.startValue as! CGAffineTransform).range(makerRangeTestValues["transform"]!.startRange).easing(.inSine)
                s.borderWidth(makerTestValues["borderWidth"]!.startValue as! CGFloat).range(makerRangeTestValues["borderWidth"]!.startRange).easing(.outSine)
                s.borderColor(makerTestValues["borderColor"]!.startValue as! CGColor).range(makerRangeTestValues["borderColor"]!.startRange).easing(.outSine)
                s.contentsRect(makerTestValues["contentsRect"]!.startValue as! CGRect).range(makerRangeTestValues["contentsRect"]!.startRange).easing(.outSine)
                s.cornerRadius(makerTestValues["cornerRadius"]!.startValue as! CGFloat).range(makerRangeTestValues["cornerRadius"]!.startRange).easing(.outSine)
                s.shadowColor(makerTestValues["shadowColor"]!.startValue as! CGColor).range(makerRangeTestValues["shadowColor"]!.startRange).easing(.outSine)
                s.shadowOpacity(makerTestValues["shadowOpacity"]!.startValue as! CGFloat).range(makerRangeTestValues["shadowOpacity"]!.startRange).easing(.outSine)
                s.shadowOffset(makerTestValues["shadowOffset"]!.startValue as! CGSize).range(makerRangeTestValues["shadowOffset"]!.startRange).easing(.inSine)
                s.shadowRadius(makerTestValues["shadowRadius"]!.startValue as! CGFloat).range(makerRangeTestValues["shadowRadius"]!.startRange).easing(.inSine)
                s.zPosition(makerTestValues["zPosition"]!.startValue as! CGFloat).range(makerRangeTestValues["zPosition"]!.startRange).easing(.inSine)
                s.transform3D(makerTestValues["transform3D"]!.startValue as! CATransform3D).range(makerRangeTestValues["transform3D"]!.startRange).easing(.inSine)
                s.layerValue(makerTestValues["customLayerValue"]!.startValue as! CGFloat, forKey : "customLayerValue" ).range(makerRangeTestValues["customLayerValue"]!.startRange)
                s.viewValue(makerTestValues["customViewValue"]!.startValue as! CGFloat, forKey : "customViewValue" ).range(makerRangeTestValues["customViewValue"]!.startRange)
                
            })
        }
        
        XCTAssert(animation.animatedViews.count == 1, "[testVerticalAnimationMakerProperties] - incorrect animabion count")
        XCTAssert(animation.animatedViews[0].fromState?.animatableProperties.count == 17, "[testVerticalAnimationMakerProperties] - incorrect animabion property count")
    
        XCTAssert(animation.animatedViews[0].toState == nil, "[testVerticalAnimationMakerProperties] - incorrect animabion count")
        
        for animatableType in animation.animatedViews
        {
            let fromStateProperties = animatableType.fromState!.animatableProperties
 
            for  (_, property) in fromStateProperties
            {
                testStartValue(property: property, testMethodName: "testVerticalAnimationMakerProperties")
            }
        }
    }
    
    func testVerticalEndOnlyAnimationMakerProperties()
    {
        let view = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 200, height: 200))
        
        let animation = PDAnimator.newVerticalAnimator { (animator) in
            
            animator.endState(for: view, { (s) in
                
                s.alpha(makerTestValues["alpha"]!.startValue as! CGFloat).range(makerRangeTestValues["alpha"]!.startRange).easing(.outSine)
                s.backgroundColor(makerTestValues["backgroundColor"]!.startValue as! UIColor).range(makerRangeTestValues["backgroundColor"]!.startRange).easing(.outSine)
                s.bounds(makerTestValues["bounds"]!.startValue as! CGRect).range(makerRangeTestValues["bounds"]!.startRange).easing(.outSine)
                s.center(makerTestValues["center"]!.startValue as! CGPoint).range(makerRangeTestValues["center"]!.startRange).easing(.outSine)
                s.transform(makerTestValues["transform"]!.startValue as! CGAffineTransform).range(makerRangeTestValues["transform"]!.startRange).easing(.inSine)
                s.borderWidth(makerTestValues["borderWidth"]!.startValue as! CGFloat).range(makerRangeTestValues["borderWidth"]!.startRange).easing(.outSine)
                s.borderColor(makerTestValues["borderColor"]!.startValue as! CGColor).range(makerRangeTestValues["borderColor"]!.startRange).easing(.outSine)
                s.contentsRect(makerTestValues["contentsRect"]!.startValue as! CGRect).range(makerRangeTestValues["contentsRect"]!.startRange).easing(.outSine)
                s.cornerRadius(makerTestValues["cornerRadius"]!.startValue as! CGFloat).range(makerRangeTestValues["cornerRadius"]!.startRange).easing(.outSine)
                s.shadowColor(makerTestValues["shadowColor"]!.startValue as! CGColor).range(makerRangeTestValues["shadowColor"]!.startRange).easing(.outSine)
                s.shadowOpacity(makerTestValues["shadowOpacity"]!.startValue as! CGFloat).range(makerRangeTestValues["shadowOpacity"]!.startRange).easing(.outSine)
                s.shadowOffset(makerTestValues["shadowOffset"]!.startValue as! CGSize).range(makerRangeTestValues["shadowOffset"]!.startRange).easing(.inSine)
                s.shadowRadius(makerTestValues["shadowRadius"]!.startValue as! CGFloat).range(makerRangeTestValues["shadowRadius"]!.startRange).easing(.inSine)
                s.zPosition(makerTestValues["zPosition"]!.startValue as! CGFloat).range(makerRangeTestValues["zPosition"]!.startRange).easing(.inSine)
                s.transform3D(makerTestValues["transform3D"]!.startValue as! CATransform3D).range(makerRangeTestValues["transform3D"]!.startRange).easing(.inSine)
                s.layerValue(makerTestValues["customLayerValue"]!.startValue as! CGFloat, forKey : "customLayerValue" ).range(makerRangeTestValues["customLayerValue"]!.startRange)
                s.viewValue(makerTestValues["customViewValue"]!.startValue as! CGFloat, forKey : "customViewValue" ).range(makerRangeTestValues["customViewValue"]!.startRange)
            })
        }
        
        XCTAssert(animation.animatedViews.count == 1,
                  "[testVerticalAnimationMakerProperties] - incorrect animabion count")
        
        XCTAssert(animation.animatedViews[0].toState?.animatableProperties.count == 17,
                  "[testVerticalAnimationMakerProperties] - incorrect animabion property count")
        
        XCTAssert(animation.animatedViews[0].fromState == nil,
                  "[testVerticalAnimationMakerProperties] - incorrect animabion count")
        
        for animatableType in animation.animatedViews {
            
            let endStateProperties = animatableType.toState!.animatableProperties
            
            for (_, property) in endStateProperties
            {
                testStartValue(property: property, testMethodName: "testVerticalAnimationMakerProperties")
            }
        }
    }
    
    func testVerticalEmptyAnimationMakerProperties()
    {
        let view = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 200, height: 200))
        
        let animation = PDAnimator.newVerticalAnimator { (animator) in
            
            animator.endState(for: view, { (s) in

            })
        }
        
        XCTAssert(animation.animatedViews.count == 1,
                  "[testVerticalAnimationMakerProperties] - incorrect animabion count")

        XCTAssert(animation.animatedViews[0].fromState == nil,
                  "[testVerticalAnimationMakerProperties] - incorrect animabion count")
        
        XCTAssert(animation.animatedViews[0].toState == nil,
                  "[testVerticalAnimationMakerProperties] - incorrect animabion count")
    }
    
    func testStartValue(property : PDAnimatableProperty, testMethodName : String) {
        
        if let makerValue = property.propertyValue as? CGFloat,
           let testValue = makerTestValues[property.propertyKey!]!.startValue as? CGFloat
        {
            XCTAssert(makerValue == testValue,
                      "[\(testMethodName)] - incorrect \([property.propertyKey!) start state")
            
            XCTAssert(property.propertyRange == makerRangeTestValues[property.propertyKey!]?.startRange,
                      "[\(testMethodName)] - incorrect \([property.propertyKey!) start state range")
        }
        else if let makerValue = property.propertyValue as? CGSize,
                let testValue = makerTestValues[property.propertyKey!]!.startValue as? CGSize
        {
            XCTAssert(makerValue == testValue,
                      "[\(testMethodName)] - incorrect \([property.propertyKey!) start state")
            
            XCTAssert(property.propertyRange == makerRangeTestValues[property.propertyKey!]?.startRange,
                      "[\(testMethodName)] - incorrect \([property.propertyKey!) start state range")
        }
        else if let makerValue = property.propertyValue as? CGPoint,
                let testValue = makerTestValues[property.propertyKey!]!.startValue as? CGPoint
        {
            XCTAssert(makerValue == testValue,
                      "[\(testMethodName)] - incorrect \([property.propertyKey!) start state")
            
            XCTAssert(property.propertyRange == makerRangeTestValues[property.propertyKey!]?.startRange,
                      "[\(testMethodName)] - incorrect \([property.propertyKey!) start state range")
        }
        else if let makerValue = property.propertyValue as? CGRect,
                let testValue = makerTestValues[property.propertyKey!]!.startValue as? CGRect
        {
            XCTAssert(makerValue == testValue,
                      "[\(testMethodName)] - incorrect \([property.propertyKey!) start state")
            
            XCTAssert(property.propertyRange == makerRangeTestValues[property.propertyKey!]?.startRange,
                      "[\(testMethodName)] - incorrect \([property.propertyKey!) start state range")
        }
        else if let makerValue = property.propertyValue as? UIColor,
                let testValue = makerTestValues[property.propertyKey!]!.startValue as? UIColor
        {
            XCTAssert(makerValue == testValue,
                      "[\(testMethodName)] - incorrect \([property.propertyKey!) start state")
            
            XCTAssert(property.propertyRange == makerRangeTestValues[property.propertyKey!]?.startRange,
                      "[\(testMethodName)] - incorrect \([property.propertyKey!) start state range")
        }
        else if CFGetTypeID(property.propertyValue as AnyObject) == CGColor.typeID &&
                CFGetTypeID(makerTestValues[property.propertyKey!]?.startValue as AnyObject) == CGColor.typeID {
            
            let makerValue = property.propertyValue as! CGColor
            
            XCTAssert(makerValue == makerTestValues[property.propertyKey!]?.startValue as! CGColor,
                      "[\(testMethodName)] - incorrect \([property.propertyKey!) start state")
            
            XCTAssert(property.propertyRange == makerRangeTestValues[property.propertyKey!]?.startRange,
                      "[\(testMethodName)] - incorrect \([property.propertyKey!) start state range")
        }
        else if let makerValue = property.propertyValue as? CGAffineTransform,
                let testValue = makerTestValues[property.propertyKey!]!.startValue as? CGAffineTransform
        {
            XCTAssert(makerValue == testValue,
                      "[\(testMethodName)] - incorrect \([property.propertyKey!) start state")
            
            XCTAssert(property.propertyRange == makerRangeTestValues[property.propertyKey!]?.startRange,
                      "[\(testMethodName)] - incorrect \([property.propertyKey!) start state range")
        }
        else if let makerValue = property.propertyValue as? CATransform3D,
                let testValue = makerTestValues[property.propertyKey!]!.startValue as? CATransform3D
        {
            XCTAssert(CATransform3DEqualToTransform(makerValue, testValue),
                      "[\(testMethodName)] - incorrect \([property.propertyKey!) start state")
            
            XCTAssert(property.propertyRange == makerRangeTestValues[property.propertyKey!]?.startRange,
                      "[\(testMethodName)] - incorrect \([property.propertyKey!) start state range")
        }
        else
        {
            XCTFail( "[\(testMethodName)] - failed to check start state property \(property.propertyKey!) ")
        }
    }
    
    func testEndValue(property : PDAnimatableProperty, testMethodName : String) {
        
        if let makerValue = property.propertyValue as? CGFloat,
           let testValue = makerTestValues[property.propertyKey!]!.endValue as? CGFloat
        {
            XCTAssert(makerValue == testValue,
                      "[\(testMethodName)] - incorrect \([property.propertyKey!) end state")
            
            XCTAssert(property.propertyRange == makerRangeTestValues[property.propertyKey!]?.endRange,
                      "[\(testMethodName)] - incorrect \([property.propertyKey!) end state range")
        }
        else if let makerValue = property.propertyValue as? CGSize,
                let testValue = makerTestValues[property.propertyKey!]!.endValue as? CGSize
        {
            XCTAssert(makerValue == testValue,
                      "[\(testMethodName)] - incorrect \([property.propertyKey!) end state")
            
            XCTAssert(property.propertyRange == makerRangeTestValues[property.propertyKey!]?.endRange,
                      "[\(testMethodName)] - incorrect \([property.propertyKey!) end state range")
        }
        else if let makerValue = property.propertyValue as? CGPoint,
                let testValue = makerTestValues[property.propertyKey!]!.endValue as? CGPoint
        {
            XCTAssert(makerValue == testValue,
                      "[\(testMethodName)] - incorrect \([property.propertyKey!) end state")
            
            XCTAssert(property.propertyRange == makerRangeTestValues[property.propertyKey!]?.endRange,
                      "[\(testMethodName)] - incorrect \([property.propertyKey!) end state range")
        }
        else if let makerValue = property.propertyValue as? CGRect,
                let testValue = makerTestValues[property.propertyKey!]!.endValue as? CGRect
        {
            XCTAssert(makerValue == testValue, "[\(testMethodName)] - incorrect \([property.propertyKey!) end state")
            
            XCTAssert(property.propertyRange == makerRangeTestValues[property.propertyKey!]?.endRange, "[\(testMethodName)] - incorrect \([property.propertyKey!) end state range")
        }
        else if let makerValue = property.propertyValue as? UIColor,
                let testValue = makerTestValues[property.propertyKey!]!.endValue as? UIColor
        {
            XCTAssert(makerValue == testValue,
                      "[\(testMethodName)] - incorrect \([property.propertyKey!) end state")
            
            XCTAssert(property.propertyRange == makerRangeTestValues[property.propertyKey!]?.endRange,
                      "[\(testMethodName)] - incorrect \([property.propertyKey!) start state range")
        }
        else if CFGetTypeID(property.propertyValue as AnyObject) == CGColor.typeID &&
                CFGetTypeID(makerTestValues[property.propertyKey!]?.startValue as AnyObject) == CGColor.typeID {
            
            let makerValue = property.propertyValue as! CGColor
            
            XCTAssert(makerValue == makerTestValues[property.propertyKey!]?.endValue as! CGColor,
                      "[\(testMethodName)] - incorrect \([property.propertyKey!) end state")
            
            XCTAssert(property.propertyRange == makerRangeTestValues[property.propertyKey!]?.endRange,
                      "[\(testMethodName)] - incorrect \([property.propertyKey!) end state range")
        }
        else if let makerValue = property.propertyValue as? CGAffineTransform,
                let testValue = makerTestValues[property.propertyKey!]!.endValue as? CGAffineTransform
        {
            XCTAssert(makerValue == testValue,
                      "[\(testMethodName)] - incorrect \([property.propertyKey!) starendt state")
            
            XCTAssert(property.propertyRange == makerRangeTestValues[property.propertyKey!]?.endRange,
                      "[\(testMethodName)] - incorrect \([property.propertyKey!) end state range")
        }
        else if let makerValue = property.propertyValue as? CATransform3D,
                let testValue = makerTestValues[property.propertyKey!]!.endValue as? CATransform3D
        {
            XCTAssert(CATransform3DEqualToTransform(makerValue, testValue),
                      "[\(testMethodName)] - incorrect \([property.propertyKey!) end state")
            
            XCTAssert(property.propertyRange == makerRangeTestValues[property.propertyKey!]?.endRange,
                      "[\(testMethodName)] - incorrect \([property.propertyKey!) end state range")
        }
        else
        {
            XCTFail( "[\(testMethodName)] - failed to check end state properties ")
        }
    }
}
