//
//  PDViewInterpolationTests.swift
//  PDAnimatorTests
//
//  Created by Anton Doudarev on 4/12/18.
//  Copyright © 2018 ELEPHANT. All rights reserved.
//

import XCTest
@testable import Parade

class PDViewInterpolationTests : XCTestCase
{    
    let screenSize  = CGSize(width:750.0, height: 1334.0)
    let centerPoint                 = CGPoint(x:375, y: 667)
    let aboveLeftCenterPoint        = CGPoint(x:-375, y: -667)
    let aboveLeftCenterHalfPoint    = CGPoint(x:0.0, y: 0)
    let belowRightCenterPoint       = CGPoint(x:1125, y: 2001)
    let belowRightCenterHalfPoint   = CGPoint(x:750.0, y: 1334)
    
    func testVerticalSplitCenter()
    {
        let scrollview = UIScrollView()
        
        if let progress = scrollview.verticalProgress(at: centerPoint, to: screenSize.height)
        {
            XCTAssert(progress == .verticalCenter, "[verticalSplitCenterProgress] - incorrect .verticalCenter progress")
        }
        
        if let progress = scrollview.verticalProgress(at: belowRightCenterHalfPoint, to: screenSize.height)
        {
            XCTAssert(progress == .verticalBelowCenter(progress : 0.5), "[verticalSplitCenterProgress] - incorrect .verticalBelowCenter half point progress")
        }
        
        if let progress = scrollview.verticalProgress(at: belowRightCenterPoint, to: screenSize.height)
        {
            XCTAssert(progress == .verticalBelowCenter(progress : 0.0), "[verticalSplitCenterProgress] - incorrect .verticalBelowCenter progress")
        }
        
        if let progress = scrollview.verticalProgress(at: aboveLeftCenterPoint, to: screenSize.height)
        {
            XCTAssert(progress == .verticalAboveCenter(progress : 0.0), "[verticalSplitCenterProgress] - incorrect .verticalAboveCenter progress")
        }
        
        if let progress = scrollview.verticalProgress(at: aboveLeftCenterHalfPoint, to: screenSize.height)
        {
            XCTAssert(progress == .verticalAboveCenter(progress : 0.5), "[verticalSplitCenterProgress] - incorrect .verticalAboveCenter half point progress")
        }
    }
    
    func testHorizontalSplitCenter()
    {
        let scrollview = UIScrollView()
        
        if let progress = scrollview.horizontalProgress(at: centerPoint, to: screenSize.width)
        {
            XCTAssert(progress == .horizontalCenter, "[horizontalSplitCenterProgress] - incorrect .horizontalCenter progress")
        }
        
        if let progress = scrollview.horizontalProgress(at: aboveLeftCenterHalfPoint, to: screenSize.width)
        {
            XCTAssert(progress == .horizontalLeftCenter(progress : 0.5), "[horizontalSplitCenterProgress] - incorrect .horizontalLeftCenter half point progress")
        }
        
        if let progress = scrollview.horizontalProgress(at: aboveLeftCenterPoint, to: screenSize.width)
        {
            XCTAssert(progress == .horizontalLeftCenter(progress : 0.0), "[horizontalSplitCenterProgress] - incorrect .horizontalLeftCenter progress")
        }
        
        if let progress = scrollview.horizontalProgress(at: belowRightCenterPoint, to: screenSize.width)
        {
            XCTAssert(progress == .horizontalRightCenter(progress : 0.0), "[horizontalSplitCenterProgress] - incorrect .horizontalRightCenter progress")
        }
        
        if let progress = scrollview.horizontalProgress(at: belowRightCenterHalfPoint, to: screenSize.width)
        {
            XCTAssert(progress == .horizontalRightCenter(progress : 0.5), "[horizontalSplitCenterProgress] - incorrect .horizontalRightCenter half point progress")
        }
    }
    
    func testRangeProgress()
    {
        let noRangeProgress = PDAnimatableProperty.adjustedRangeProgress(range: 0.0...1.0, progress: 0.5)
        
        XCTAssert(noRangeProgress == 0.5, "[adjustedRangeProgress] - incorrect rangeProgress")
        
        let boundLeftRightProgress = PDAnimatableProperty.adjustedRangeProgress(range: 0.25...0.75, progress: 0.5)
        
        XCTAssert(boundLeftRightProgress == 0.5, "[adjustedRangeProgress] - incorrect rangeProgress")
        
        let boundLeftRightZeroProgress = PDAnimatableProperty.adjustedRangeProgress(range: 0.25...0.75, progress: 0.25)
        
        XCTAssert(boundLeftRightZeroProgress == 0.0, "[adjustedRangeProgress] - incorrect rangeProgress")
        
        let boundLeftRightUnderZeroProgress = PDAnimatableProperty.adjustedRangeProgress(range: 0.25...0.75, progress: 0.0)
        
        XCTAssert(boundLeftRightUnderZeroProgress == 0.0, "[adjustedRangeProgress] - incorrect rangeProgress")
        
        let boundLeftRightOverUpperBoundProgress = PDAnimatableProperty.adjustedRangeProgress(range: 0.25...0.75, progress: 0.8)
        
        XCTAssert(boundLeftRightOverUpperBoundProgress == 1.0, "[adjustedRangeProgress] - incorrect rangeProgress")
        
        let boundLeftProgress = PDAnimatableProperty.adjustedRangeProgress(range: 0.0...0.5, progress: 0.5)
        
        XCTAssert(boundLeftProgress == 1.0, "[adjustedRangeProgress] - incorrect rangeProgress")
        
        let boundRightZeroProgress = PDAnimatableProperty.adjustedRangeProgress(range: 0.5...1.0, progress: 0.5)
        
        XCTAssert(boundRightZeroProgress == 0.0, "[adjustedRangeProgress] - incorrect rangeProgress")
        
        let boundRightHalfProgress = PDAnimatableProperty.adjustedRangeProgress(range: 0.5...1.0, progress: 0.75)
        
        XCTAssert(boundRightHalfProgress == 0.5, "[adjustedRangeProgress] - incorrect rangeProgress")
    }
    
    func testProgressDirectionEquality() {
       
        XCTAssert(PDScrollProgressType.verticalAboveCenter(progress: 0.5) == PDScrollProgressType.verticalAboveCenter(progress: 0.5),
                  "[testProgressDirectionEquality] - incorrectly evaluated direction equality")
        XCTAssert(PDScrollProgressType.verticalAboveCenter(progress: 0.5) != PDScrollProgressType.verticalAboveCenter(progress: 0.75),
                  "[testProgressDirectionEquality] - incorrectly evaluated direction equality")
        XCTAssert(PDScrollProgressType.verticalAboveCenter(progress: 0.5) != PDScrollProgressType.verticalBelowCenter(progress: 0.75),
                  "[testProgressDirectionEquality] - incorrectly evaluated direction equality")
        XCTAssert(PDScrollProgressType.verticalAboveCenter(progress: 0.5) != PDScrollProgressType.horizontalRightCenter(progress: 0.75),
                  "[testProgressDirectionEquality] - incorrectly evaluated direction equality")
        XCTAssert(PDScrollProgressType.verticalAboveCenter(progress: 0.5) != PDScrollProgressType.horizontalLeftCenter(progress: 0.75),
                  "[testProgressDirectionEquality] - incorrectly evaluated direction equality")
        XCTAssert(PDScrollProgressType.verticalAboveCenter(progress: 0.5) != PDScrollProgressType.verticalCenter,
                  "[testProgressDirectionEquality] - incorrectly evaluated direction equality")
        XCTAssert(PDScrollProgressType.verticalAboveCenter(progress: 0.5) != PDScrollProgressType.horizontalCenter,
                  "[testProgressDirectionEquality] - incorrectly evaluated direction equality")
        XCTAssert(PDScrollProgressType.horizontalLeftCenter(progress: 0.5) == PDScrollProgressType.horizontalLeftCenter(progress: 0.5),
                  "[testProgressDirectionEquality] - incorrectly evaluated direction equality")
        XCTAssert(PDScrollProgressType.horizontalLeftCenter(progress: 0.5) != PDScrollProgressType.verticalAboveCenter(progress: 0.75),
                  "[testProgressDirectionEquality] - incorrectly evaluated direction equality")
        XCTAssert(PDScrollProgressType.horizontalLeftCenter(progress: 0.5) != PDScrollProgressType.verticalBelowCenter(progress: 0.75),
                  "[testProgressDirectionEquality] - incorrectly evaluated direction equality")
        XCTAssert(PDScrollProgressType.horizontalLeftCenter(progress: 0.5) != PDScrollProgressType.horizontalRightCenter(progress: 0.75),
                  "[testProgressDirectionEquality] - incorrectly evaluated direction equality")
        XCTAssert(PDScrollProgressType.horizontalLeftCenter(progress: 0.5) != PDScrollProgressType.horizontalLeftCenter(progress: 0.75),
                  "[testProgressDirectionEquality] - incorrectly evaluated direction equality")
        XCTAssert(PDScrollProgressType.horizontalLeftCenter(progress: 0.5) != PDScrollProgressType.verticalCenter,
                  "[testProgressDirectionEquality] - incorrectly evaluated direction equality")
        XCTAssert(PDScrollProgressType.horizontalLeftCenter(progress: 0.5) != PDScrollProgressType.horizontalCenter,
                  "[testProgressDirectionEquality] - incorrectly evaluated direction equality")
        XCTAssert(PDScrollProgressType.horizontalCenter == PDScrollProgressType.horizontalCenter,
                  "[testProgressDirectionEquality] - incorrectly evaluated direction equality")
        XCTAssert(PDScrollProgressType.verticalCenter == PDScrollProgressType.verticalCenter,
                  "[testProgressDirectionEquality] - incorrectly evaluated direction equality")
        XCTAssert(PDScrollProgressType.horizontalCenter != PDScrollProgressType.verticalCenter,
                  "[testProgressDirectionEquality] - incorrectly evaluated direction equality")
    }
}
