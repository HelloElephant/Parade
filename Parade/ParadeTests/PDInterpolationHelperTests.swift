//
//  PDInterpolationHelperTests.swift
//  PDAnimatorTests
//
//  Created by Anton Doudarev on 4/12/18.
//  Copyright © 2018 ELEPHANT. All rights reserved.
//

import XCTest
@testable import Parade

class PDInterpolationHelperTests: XCTestCase
{    
    func testScaleValueHelpers()
    {
        let pointValue = CGPoint(x:10, y:20).scaledValue(to: 2.0)
        
        XCTAssert(pointValue.x == 20.0, "[testScaleValueHelpers] - incorrect point value scaling")
        XCTAssert(pointValue.y == 40.0, "[testScaleValueHelpers] - incorrect point value scaling")
        
        let pointValue2 = CGPoint(x:10, y:20).scaledValue(x: 2.0, y: 4.0)
        
        XCTAssert(pointValue2.x == 20.0, "[testScaleValueHelpers] - incorrect point value scaling")
        XCTAssert(pointValue2.y == 80.0, "[testScaleValueHelpers] - incorrect point value scaling")
        
        let sizeValue = CGSize(width:10, height:20).scaledValue(to: 2.0)
        
        XCTAssert(sizeValue.width == 20.0,  "[testScaleValueHelpers] - incorrect size value scaling")
        XCTAssert(sizeValue.height == 40.0, "[testScaleValueHelpers] - incorrect size value scaling")
        
        let sizeValue2 = CGSize(width:10, height:20).scaledValue(width: 2.0, height: 4.0)
        
        XCTAssert(sizeValue2.width == 20.0, "[testScaleValueHelpers] - incorrect size value scaling")
        XCTAssert(sizeValue2.height == 80.0, "[testScaleValueHelpers] - incorrect size value scaling")
        
        let rectValue = CGRect(x:10, y:20, width:10, height:20).scaledValue(to: 2.0)
        
        XCTAssert(rectValue.origin.x == 20.0,  "[testScaleValueHelpers] - incorrect rect value scaling")
        XCTAssert(rectValue.origin.y == 40.0, "[testScaleValueHelpers] - incorrect rect value scaling")
        XCTAssert(rectValue.width == 20.0,  "[testScaleValueHelpers] - incorrect rect value scaling")
        XCTAssert(rectValue.height == 40.0, "[testScaleValueHelpers] - incorrect rect value scaling")
        
        let rectValue2 = CGRect(x:10, y:20, width:10, height:20).scaledValue(bounds: 2.0, origin: 4.0)
        
        XCTAssert(rectValue2.origin.x == 40.0,  "[testScaleValueHelpers] - incorrect rect value scaling")
        XCTAssert(rectValue2.origin.y == 80.0, "[testScaleValueHelpers] - incorrect rect value scaling")
        XCTAssert(rectValue2.width == 20.0,  "[testScaleValueHelpers] - incorrect rect value scaling")
        XCTAssert(rectValue2.height == 40.0, "[testScaleValueHelpers] - incorrect rect value scaling")
        
        let floatValue = CGFloat(10).progressValue(to: 20, atProgress: 0.5)
        XCTAssert(floatValue == 15 , "[testScaleValueHelpers] - float progressValue incorrect")
    }
    
    func testReverseEasing()
    {
        XCTAssert(PDEasing.linear.reverseEasing() == .linear, "[testReverseEasing] - incorrect reverseEasing")
        XCTAssert(PDEasing.smoothStep.reverseEasing() == .smoothStep, "[testReverseEasing] - incorrect reverseEasing")
        XCTAssert(PDEasing.smootherStep.reverseEasing() == .smootherStep, "[testReverseEasing] - incorrect reverseEasing")
        XCTAssert(PDEasing.inAtan.reverseEasing() == .outAtan, "[testReverseEasing] - incorrect reverseEasing")
        XCTAssert(PDEasing.outAtan.reverseEasing() == .inAtan, "[testReverseEasing] - incorrect reverseEasing")
        XCTAssert(PDEasing.inOutAtan.reverseEasing() == .inOutAtan, "[testReverseEasing] - incorrect reverseEasing")
        XCTAssert(PDEasing.inSine.reverseEasing() == .outSine, "[testReverseEasing] - incorrect reverseEasing")
        XCTAssert(PDEasing.outSine.reverseEasing() == .inSine, "[testReverseEasing] - incorrect reverseEasing")
        XCTAssert(PDEasing.inOutSine.reverseEasing() == .outInSine, "[testReverseEasing] - incorrect reverseEasing")
        XCTAssert(PDEasing.outInSine.reverseEasing() == .inOutSine, "[testReverseEasing] - incorrect reverseEasing")
        XCTAssert(PDEasing.inQuadratic.reverseEasing() == .outQuadratic, "[testReverseEasing] - incorrect reverseEasing")
        XCTAssert(PDEasing.outQuadratic.reverseEasing() == .inQuadratic, "[testReverseEasing] - incorrect reverseEasing")
        XCTAssert(PDEasing.inOutQuadratic.reverseEasing() == .outInQuadratic, "[testReverseEasing] - incorrect reverseEasing")
        XCTAssert(PDEasing.outInQuadratic.reverseEasing() == .inOutQuadratic, "[testReverseEasing] - incorrect reverseEasing")
        XCTAssert(PDEasing.inCubic.reverseEasing() == .outCubic, "[testReverseEasing] - incorrect reverseEasing")
        XCTAssert(PDEasing.outCubic.reverseEasing() == .inCubic, "[testReverseEasing] - incorrect reverseEasing")
        XCTAssert(PDEasing.inOutCubic.reverseEasing() == .outInCubic, "[testReverseEasing] - incorrect reverseEasing")
        XCTAssert(PDEasing.outInCubic.reverseEasing() == .inOutCubic, "[testReverseEasing] - incorrect reverseEasing")
        XCTAssert(PDEasing.inQuartic.reverseEasing() == .outQuartic, "[testReverseEasing] - incorrect reverseEasing")
        XCTAssert(PDEasing.outQuartic.reverseEasing() == .inQuartic, "[testReverseEasing] - incorrect reverseEasing")
        XCTAssert(PDEasing.inOutQuartic.reverseEasing() == .outInQuartic, "[testReverseEasing] - incorrect reverseEasing")
        XCTAssert(PDEasing.outInQuartic.reverseEasing() == .inOutQuartic, "[testReverseEasing] - incorrect reverseEasing")
        XCTAssert(PDEasing.inQuintic.reverseEasing() == .outQuintic, "[testReverseEasing] - incorrect reverseEasing")
        XCTAssert(PDEasing.outQuintic.reverseEasing() == .inQuintic, "[testReverseEasing] - incorrect reverseEasing")
        XCTAssert(PDEasing.inOutQuintic.reverseEasing() == .outInQuintic, "[testReverseEasing] - incorrect reverseEasing")
        XCTAssert(PDEasing.outInQuintic.reverseEasing() == .inOutQuintic, "[testReverseEasing] - incorrect reverseEasing")
        XCTAssert(PDEasing.inExponential.reverseEasing() == .outExponential, "[testReverseEasing] - incorrect reverseEasing")
        XCTAssert(PDEasing.outExponential.reverseEasing() == .inExponential, "[testReverseEasing] - incorrect reverseEasing")
        XCTAssert(PDEasing.outInExponential.reverseEasing() == .inOutExponential, "[testReverseEasing] - incorrect reverseEasing")
        XCTAssert(PDEasing.inOutExponential.reverseEasing() == .outInExponential, "[testReverseEasing] - incorrect reverseEasing")
        XCTAssert(PDEasing.inCircular.reverseEasing() == .outCircular, "[testReverseEasing] - incorrect reverseEasing")
        XCTAssert(PDEasing.outCircular.reverseEasing() == .inCircular, "[testReverseEasing] - incorrect reverseEasing")
        XCTAssert(PDEasing.outInCircular.reverseEasing() == .inOutCircular, "[testReverseEasing] - incorrect reverseEasing")
        XCTAssert(PDEasing.inOutCircular.reverseEasing() == .outInCircular, "[testReverseEasing] - incorrect reverseEasing")
        XCTAssert(PDEasing.inBack.reverseEasing() == .outBack, "[testReverseEasing] - incorrect reverseEasing")
        XCTAssert(PDEasing.outBack.reverseEasing() == .inBack, "[testReverseEasing] - incorrect reverseEasing")
        XCTAssert(PDEasing.inOutBack.reverseEasing() == .outInBack, "[testReverseEasing] - incorrect reverseEasing")
        XCTAssert(PDEasing.outInBack.reverseEasing() == .inOutBack, "[testReverseEasing] - incorrect reverseEasing")
        XCTAssert(PDEasing.inElastic.reverseEasing() == .outElastic, "[testReverseEasing] - incorrect reverseEasing")
        XCTAssert(PDEasing.outElastic.reverseEasing() == .inElastic, "[testReverseEasing] - incorrect reverseEasing")
        XCTAssert(PDEasing.inOutElastic.reverseEasing() == .outInElastic, "[testReverseEasing] - incorrect reverseEasing")
        XCTAssert(PDEasing.outInElastic.reverseEasing() == .inOutElastic, "[testReverseEasing] - incorrect reverseEasing")
        XCTAssert(PDEasing.inBounce.reverseEasing() == .outBounce, "[testReverseEasing] - incorrect reverseEasing")
        XCTAssert(PDEasing.outBounce.reverseEasing() == .inBounce, "[testReverseEasing] - incorrect reverseEasing")
        XCTAssert(PDEasing.outInBounce.reverseEasing() == .inOutBounce, "[testReverseEasing] - incorrect reverseEasing")
        XCTAssert(PDEasing.inOutBounce.reverseEasing() == .outInBounce, "[testReverseEasing] - incorrect reverseEasing")
    }
    
    func testParametricEasing()
    {
        XCTAssert(PDEasing.linear.parametricProgress(0.5) == 0.5 , "[testParametricEasing] - incorrect testParametricEasing")
        XCTAssert(PDEasing.smoothStep.parametricProgress(0.5) == 0.5 , "[testParametricEasing] - incorrect testParametricEasing")
        XCTAssert(PDEasing.smootherStep.parametricProgress(0.5) == 0.5 , "[testParametricEasing] - incorrect testParametricEasing")
        XCTAssert(roundedCGFloat(PDEasing.inAtan.parametricProgress(0.5)) == 0.044 , "[testParametricEasing] - incorrect testParametricEasing")
        XCTAssert(roundedCGFloat(PDEasing.outAtan.parametricProgress(0.5)) == 0.956 , "[testParametricEasing] - incorrect testParametricEasing")
        XCTAssert(PDEasing.inOutAtan.parametricProgress(0.5) == 0.5 , "[testParametricEasing] - incorrect testParametricEasing")
        XCTAssert(roundedCGFloat(PDEasing.inSine.parametricProgress(0.5)) == 0.293 , "[testParametricEasing] - incorrect testParametricEasing")
        XCTAssert(roundedCGFloat(PDEasing.outSine.parametricProgress(0.5)) == 0.707 , "[testParametricEasing] - incorrect testParametricEasing")
        XCTAssert(roundedCGFloat(PDEasing.inOutSine.parametricProgress(0.75)) == 0.854 , "[testParametricEasing] - incorrect testParametricEasing")
        XCTAssert(PDEasing.outInSine.parametricProgress(0.5) == 0.5 , "[testParametricEasing] - incorrect testParametricEasing")
        XCTAssert(PDEasing.inQuadratic.parametricProgress(0.5) == 0.25 , "[testParametricEasing] - incorrect testParametricEasing")
        XCTAssert(PDEasing.outQuadratic.parametricProgress(0.5) == 0.75 , "[testParametricEasing] - incorrect testParametricEasing")
        XCTAssert(PDEasing.inOutQuadratic.parametricProgress(0.5) == 0.5 , "[testParametricEasing] - incorrect testParametricEasing")
        XCTAssert(PDEasing.outInQuadratic.parametricProgress(0.5) == 0.5 , "[testParametricEasing] - incorrect testParametricEasing")
        XCTAssert(PDEasing.inCubic.parametricProgress(0.5) == 0.125 , "[testParametricEasing] - incorrect testParametricEasing")
        XCTAssert(PDEasing.outCubic.parametricProgress(0.5) == 0.875 , "[testParametricEasing] - incorrect testParametricEasing")
        XCTAssert(PDEasing.inOutCubic.parametricProgress(0.5) == 0.5 , "[testParametricEasing] - incorrect testParametricEasing")
        XCTAssert(PDEasing.outInCubic.parametricProgress(0.5) == 0.5 , "[testParametricEasing] - incorrect testParametricEasing")
        XCTAssert(roundedCGFloat(PDEasing.inQuartic.parametricProgress(0.25)) == 0.004 , "[testParametricEasing] - incorrect testParametricEasing")
        XCTAssert(PDEasing.outQuartic.parametricProgress(0.5) == 0.9375 , "[testParametricEasing] - incorrect testParametricEasing")
        XCTAssert(PDEasing.inOutQuartic.parametricProgress(0.5) == 0.5 , "[testParametricEasing] - incorrect testParametricEasing")
        XCTAssert(PDEasing.outInQuartic.parametricProgress(0.5) == 0.5 , "[testParametricEasing] - incorrect testParametricEasing")
        XCTAssert(PDEasing.inQuintic.parametricProgress(0.5) == 0.03125 , "[testParametricEasing] - incorrect testParametricEasing")
        XCTAssert(PDEasing.outQuintic.parametricProgress(0.5) == 0.96875 , "[testParametricEasing] - incorrect testParametricEasing")
        XCTAssert(PDEasing.inOutQuintic.parametricProgress(0.5) == 0.5 , "[testParametricEasing] - incorrect testParametricEasing")
        XCTAssert(PDEasing.outInQuintic.parametricProgress(0.5) == 0.5 , "[testParametricEasing] - incorrect testParametricEasing")
        XCTAssert(PDEasing.inExponential.parametricProgress(0.5) == 0.03125 , "[testParametricEasing] - incorrect testParametricEasing")
        XCTAssert(PDEasing.outExponential.parametricProgress(0.5) == 0.96875 , "[testParametricEasing] - incorrect testParametricEasing")
        XCTAssert(roundedCGFloat(PDEasing.outInExponential.parametricProgress(0.5)) == 0.500 , "[testParametricEasing] - incorrect testParametricEasing")
        XCTAssert(PDEasing.inOutExponential.parametricProgress(0.5) == 0.5 , "[testParametricEasing] - incorrect testParametricEasing")
        XCTAssert(roundedCGFloat(PDEasing.inCircular.parametricProgress(0.5)) == 0.134 , "[testParametricEasing] - incorrect testParametricEasing")
        XCTAssert(roundedCGFloat(PDEasing.outCircular.parametricProgress(0.5)) == 0.866 , "[testParametricEasing] - incorrect testParametricEasing")
        XCTAssert(PDEasing.outInCircular.parametricProgress(0.5) == 0.5 , "[testParametricEasing] - incorrect testParametricEasing")
        XCTAssert(PDEasing.inOutCircular.parametricProgress(0.5) == 0.5 , "[testParametricEasing] - incorrect testParametricEasing")
        XCTAssert(roundedCGFloat(PDEasing.inBack.parametricProgress(0.5)) == -0.088 , "[testParametricEasing] - incorrect testParametricEasing")
        XCTAssert(PDEasing.outBack.parametricProgress(0.5) == 1.0876975 , "[testParametricEasing] - incorrect testParametricEasing")
        XCTAssert(PDEasing.outInBack.parametricProgress(0.5) == 0.5 , "[testParametricEasing] - incorrect testParametricEasing")
        XCTAssert(PDEasing.inOutBack.parametricProgress(0.5) == 0.5 , "[testParametricEasing] - incorrect testParametricEasing")
        XCTAssert(roundedCGFloat(PDEasing.inElastic.parametricProgress(0.5)) == -0.022 , "[testParametricEasing] - incorrect testParametricEasing")
        XCTAssert(roundedCGFloat(PDEasing.outElastic.parametricProgress(0.5)) == 1.022 , "[testParametricEasing] - incorrect testParametricEasing")
        XCTAssert(PDEasing.outInElastic.parametricProgress(0.5) == 0.5 , "[testParametricEasing] - incorrect testParametricEasing")
        XCTAssert(PDEasing.inOutElastic.parametricProgress(0.5) == 0.5 , "[testParametricEasing] - incorrect testParametricEasing")
        XCTAssert(roundedCGFloat(PDEasing.inBounce.parametricProgress(0.5)) == 0.281 , "[testParametricEasing] - incorrect testParametricEasing")
        XCTAssert(roundedCGFloat(PDEasing.outBounce.parametricProgress(0.5)) == 0.719 , "[testParametricEasing] - incorrect testParametricEasing")
        XCTAssert(roundedCGFloat(PDEasing.outInBounce.parametricProgress(0.5)) == 0.500 , "[testParametricEasing] - incorrect testParametricEasing")
        XCTAssert(PDEasing.inOutBounce.parametricProgress(0.5) == 0.5 , "[testParametricEasing] - incorrect testParametricEasing")
        XCTAssert(roundedCGFloat(PDEasing.outSine.parametricProgress(0.4)) == 0.588 , "[testParametricEasing] - incorrect \(PDEasing.outSine.parametricProgress(0.4)) testParametricEasing")
        XCTAssert(roundedCGFloat(PDEasing.inOutQuadratic.parametricProgress(0.4)) == 0.32 , "[testParametricEasing] - incorrect \(PDEasing.inOutQuadratic.parametricProgress(0.4)) testParametricEasing")
        XCTAssert(roundedCGFloat(PDEasing.outInQuadratic.parametricProgress(0.2)) == 0.32 , "[testParametricEasing] - incorrect \(PDEasing.outInQuadratic.parametricProgress(0.2)) testParametricEasing")
        XCTAssert(roundedCGFloat(PDEasing.outInQuartic.parametricProgress(0.2)) == 0.435 , "[testParametricEasing] - incorrect \(PDEasing.outInQuartic.parametricProgress(0.2)) testParametricEasing")
        XCTAssert(roundedCGFloat(PDEasing.inOutQuartic.parametricProgress(0.2)) == 0.013 , "[testParametricEasing] - incorrect \(PDEasing.inOutQuartic.parametricProgress(0.2)) testParametricEasing")
        XCTAssert(roundedCGFloat(PDEasing.inOutQuintic.parametricProgress(0.2)) == 0.005 , "[testParametricEasing] - incorrect \(PDEasing.inOutQuintic.parametricProgress(0.2)) testParametricEasing")
        XCTAssert(roundedCGFloat(PDEasing.inOutCubic.parametricProgress(0.2)) == 0.032 , "[testParametricEasing] - incorrect \(PDEasing.inOutCubic.parametricProgress(0.2)) testParametricEasing")
        XCTAssert(roundedCGFloat(PDEasing.inExponential.parametricProgress(0.0)) == 0.0 , "[testParametricEasing] - incorrect \(PDEasing.inExponential.parametricProgress(0.0)) testParametricEasing")
        XCTAssert(roundedCGFloat(PDEasing.outInExponential.parametricProgress(1.0)) == 0.5 , "[testParametricEasing] - incorrect \(PDEasing.outInExponential.parametricProgress(1.0)) testParametricEasing")
        XCTAssert(roundedCGFloat(PDEasing.outInExponential.parametricProgress(0.4)) == 0.498 , "[testParametricEasing] - incorrect \(PDEasing.outInExponential.parametricProgress(0.4)) testParametricEasing")
        XCTAssert(roundedCGFloat(PDEasing.outInSine.parametricProgress(0.4)) == 0.476 , "[testParametricEasing] - incorrect \(PDEasing.outInSine.parametricProgress(0.4)) testParametricEasing")
        XCTAssert(roundedCGFloat(PDEasing.inOutExponential.parametricProgress(0.25)) ==  0.016 , "[testParametricEasing] - incorrect \(PDEasing.inOutExponential.parametricProgress(0.25)) testParametricEasing")
        XCTAssert(roundedCGFloat(PDEasing.inOutExponential.parametricProgress(0.0)) == 0.0 , "[testParametricEasing] - incorrect \(PDEasing.inOutExponential.parametricProgress(0.0)) testParametricEasing")
        XCTAssert(roundedCGFloat(PDEasing.inOutExponential.parametricProgress(1.0)) == 1.0 , "[testParametricEasing] - incorrect \(PDEasing.inOutExponential.parametricProgress(1.0)) testParametricEasing")
        XCTAssert(roundedCGFloat(PDEasing.inOutCircular.parametricProgress(0.4)) == 0.2 , "[testParametricEasing] - incorrect \(PDEasing.inOutCircular.parametricProgress(0.4)) testParametricEasing")
        XCTAssert(roundedCGFloat(PDEasing.outInCircular.parametricProgress(0.4)) ==  0.490 , "[testParametricEasing] - incorrect \(PDEasing.outInCircular.parametricProgress(0.4)) testParametricEasing")
        XCTAssert(roundedCGFloat(PDEasing.inOutBack.parametricProgress(0.4)) == 0.021 , "[testParametricEasing] - incorrect \(PDEasing.inOutBack.parametricProgress(0.4)) testParametricEasing")
        XCTAssert(roundedCGFloat(PDEasing.outInBack.parametricProgress(0.4)) == -0.055 , "[testParametricEasing] - incorrect \(PDEasing.outInBack.parametricProgress(0.4)) testParametricEasing")
        XCTAssert(roundedCGFloat(PDEasing.inOutElastic.parametricProgress(0.4)) == -0.073 , "[testParametricEasing] - incorrect \(PDEasing.inOutElastic.parametricProgress(0.4)) testParametricEasing")
        XCTAssert(roundedCGFloat(PDEasing.outInElastic.parametricProgress(0.4)) ==  2.176 , "[testParametricEasing] - incorrect \(PDEasing.outInElastic.parametricProgress(0.4)) testParametricEasing")
        XCTAssert(roundedCGFloat(PDEasing.outBounce.parametricProgress(0.85)) ==  0.926 , "[testParametricEasing] - incorrect \(PDEasing.outBounce.parametricProgress(0.85)) testParametricEasing")
        XCTAssert(roundedCGFloat(PDEasing.inOutBounce.parametricProgress(0.4)) == 0.349 , "[testParametricEasing] - incorrect \(PDEasing.inOutBounce.parametricProgress(0.4)) testParametricEasing")
        XCTAssert(roundedCGFloat(PDEasing.outInBounce.parametricProgress(0.4)) == 0.151 , "[testParametricEasing] - incorrect \(PDEasing.outInBounce.parametricProgress(0.4)) testParametricEasing")
    }

    func roundedCGFloat(_ value : CGFloat) -> CGFloat
    {
        return CGFloat(round(1000*value)/1000)
    }
}
