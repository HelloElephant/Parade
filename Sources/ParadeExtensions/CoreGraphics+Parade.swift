//
//  CoreGraphics+PDInterpolation.swift
//  parallax-kit-demo
//
//  Created by Anton Doudarev on 3/20/18.
//  Copyright © 2018 ELEPHANT. All rights reserved.
//

import Foundation
import UIKit

extension CGFloat
{
    func progressValue(to toValue : CGFloat, atProgress progress : CGFloat) -> CGFloat {
        return self + ((toValue - self) * progress)
    }
}

extension CGPoint
{
    func progressValue(to toPoint : CGPoint, atProgress progress : CGFloat) -> CGPoint {
        let xDifference = x.progressValue(to: toPoint.x, atProgress: progress)
        let yDifference = y.progressValue(to: toPoint.y, atProgress: progress)
        return CGPoint(x : xDifference, y : yDifference)
    }
    
    public func scaledValue(to scale : CGFloat) -> CGPoint {
        return scaledValue(x : scale, y : scale)
    }
    
    public func scaledValue(x xScale : CGFloat, y yScale : CGFloat) -> CGPoint {
        return CGPoint(x :  x * xScale, y :  y * yScale)
    }
}

extension CGSize
{
    func progressValue(to toSize : CGSize, atProgress progress : CGFloat) -> CGSize {
        let widthDifference  = width.progressValue(to: toSize.width, atProgress: progress)
        let heightDifference = height.progressValue(to: toSize.height, atProgress: progress)
        return CGSize(width : widthDifference, height : heightDifference)
    }
    
    public func scaledValue(to scale : CGFloat) -> CGSize {
        return scaledValue(width : scale, height : scale)
    }
    
    public func scaledValue(width widthScale : CGFloat, height heightScale : CGFloat) -> CGSize {
        return CGSize(width :  width * widthScale, height :  height * heightScale)
    }
}

extension CGRect
{
    func progressValue(to toRect : CGRect, atProgress progress : CGFloat) -> CGRect {
        var adjustedRect = CGRect.zero
        
        adjustedRect.size = size.progressValue(to: toRect.size, atProgress: progress)
        adjustedRect.origin = toRect.origin.progressValue(to: toRect.origin, atProgress: progress)
       
        return adjustedRect
    }

    public func scaledValue(to scale : CGFloat) -> CGRect {
        return scaledValue(bounds : scale, origin : scale)
    }
    
    public func scaledValue(bounds sizeScale : CGFloat, origin originScale : CGFloat) -> CGRect {
       
        var adjustedRect    = CGRect.zero
       
        adjustedRect.size   = size.scaledValue(width : sizeScale, height : sizeScale)
        adjustedRect.origin = origin.scaledValue(x : originScale, y : originScale)
        
        return adjustedRect
    }
}

extension CGAffineTransform
{
    func progressValue(to toTransform : CGAffineTransform, atProgress progress : CGFloat) -> CGAffineTransform {
        
        let aDifference  = a.progressValue(to: toTransform.a, atProgress: progress)
        let bDifference  = b.progressValue(to: toTransform.b, atProgress: progress)
        let cDifference  = c.progressValue(to: toTransform.c, atProgress: progress)
        let dDifference  = d.progressValue(to: toTransform.d, atProgress: progress)
        let txDifference = tx.progressValue(to: toTransform.tx, atProgress: progress)
        let tyDifference = ty.progressValue(to: toTransform.ty, atProgress: progress)
       
        return CGAffineTransform(a: aDifference, b: bDifference, c: cDifference, d: dDifference, tx: txDifference, ty: tyDifference)
    }
}

extension CATransform3D
{
    func progressValue(to toTransform : CATransform3D, atProgress progress : CGFloat) -> CATransform3D {
        
        let m11Difference = m11.progressValue(to: toTransform.m11, atProgress: progress)
        let m12Difference = m12.progressValue(to: toTransform.m12, atProgress: progress)
        let m13Difference = m13.progressValue(to: toTransform.m13, atProgress: progress)
        let m14Difference = m14.progressValue(to: toTransform.m14, atProgress: progress)
        
        let m21Difference = m21.progressValue(to: toTransform.m21, atProgress: progress)
        let m22Difference = m22.progressValue(to: toTransform.m22, atProgress: progress)
        let m23Difference = m23.progressValue(to: toTransform.m23, atProgress: progress)
        let m24Difference = m24.progressValue(to: toTransform.m24, atProgress: progress)
        
        let m31Difference = m31.progressValue(to: toTransform.m31, atProgress: progress)
        let m32Difference = m32.progressValue(to: toTransform.m32, atProgress: progress)
        let m33Difference = m33.progressValue(to: toTransform.m33, atProgress: progress)
        let m34Difference = m34.progressValue(to: toTransform.m34, atProgress: progress)
        
        let m41Difference = m41.progressValue(to: toTransform.m41, atProgress: progress)
        let m42Difference = m42.progressValue(to: toTransform.m42, atProgress: progress)
        let m43Difference = m43.progressValue(to: toTransform.m43, atProgress: progress)
        let m44Difference = m44.progressValue(to: toTransform.m44, atProgress: progress)
        
        return CATransform3D(m11: m11Difference, m12: m12Difference, m13: m13Difference, m14: m14Difference,
                             m21: m21Difference, m22: m22Difference, m23: m23Difference, m24: m24Difference,
                             m31: m31Difference, m32: m32Difference, m33: m33Difference, m34: m34Difference,
                             m41: m41Difference, m42: m42Difference, m43: m43Difference, m44: m44Difference)
    }
}

extension CGColor {
    
    var componentsConfig: (r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat)
    {
        let componentConfig = self.components
        
        switch componentConfig?.count == 2 {
        case true : return (r: componentConfig![0], g: componentConfig![0], b: componentConfig![0], a: componentConfig![1])
        case false: return (r: componentConfig![0], g: componentConfig![1], b: componentConfig![2], a: componentConfig![3])
        }
    }
    
    func progressValue(to toValue : CGColor, atProgress progress : CGFloat) -> CGColor
    {
        let fromComponents = self.componentsConfig
        let toComponents = toValue.componentsConfig
        
        let r = (1 - progress) * fromComponents.r + progress * toComponents.r
        let g = (1 - progress) * fromComponents.g + progress * toComponents.g
        let b = (1 - progress) * fromComponents.b + progress * toComponents.b
        let a = (1 - progress) * fromComponents.a + progress * toComponents.a
        
        return UIColor(red: r, green: g, blue: b, alpha: a).cgColor
    }
}

extension UIColor
{
    var components: (r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat)
    {
        return self.cgColor.componentsConfig
    }
    
    func progressValue(to toValue : UIColor, atProgress progress : CGFloat) -> UIColor
    {
        return UIColor(cgColor: cgColor.progressValue(to: toValue.cgColor, atProgress: progress))
    }
}


let overshoot : CGFloat = 1.70158
let CGM_PI_2 = CGFloat(Double.pi / 2)
let CGM_PI = CGFloat(Double.pi)

public enum PDEasing : Equatable {
    case linear
    case smoothStep
    case smootherStep
    case inAtan
    case outAtan
    case inOutAtan
    case inSine
    case outSine
    case inOutSine
    case outInSine
    case inQuadratic
    case outQuadratic
    case inOutQuadratic
    case outInQuadratic
    case inCubic
    case outCubic
    case inOutCubic
    case outInCubic
    case inQuartic
    case outQuartic
    case inOutQuartic
    case outInQuartic
    case inQuintic
    case outQuintic
    case inOutQuintic
    case outInQuintic
    case inExponential
    case outExponential
    case inOutExponential
    case outInExponential
    case inCircular
    case outCircular
    case inOutCircular
    case outInCircular
    case inBack
    case outBack
    case inOutBack
    case outInBack
    case inElastic
    case outElastic
    case inOutElastic
    case outInElastic
    case inBounce
    case outBounce
    case inOutBounce
    case outInBounce
    
    public func parametricProgress(_ p : CGFloat) -> CGFloat {
        switch self {
        case .linear:
            return p
        case .smoothStep:
            return p * p * (3.0 - 2.0 * p)
        case .smootherStep:
            return  p * p * p * (p * (p * 6.0 - 15.0) + 10.0)
        case .inAtan:
            let m: CGFloat = atan(15.0)
            return atan((p - 1.0) * 15.0) / m + 1.0
        case .outAtan:
            let m: CGFloat = atan(15.0)
            return atan(p * 15.0) / m
        case .inOutAtan:
            let m: CGFloat = atan(0.5 * 15.0)
            return atan((p - 0.5) * 15.0) / (2.0 * m) + 0.5
        case .inSine:
            return sin((p - 1.0) * CGM_PI_2) + 1.0
        case .outSine:
            return sin(p * CGM_PI_2)
        case .inOutSine:
            return 0.5 * (1.0 - cos(p * CGM_PI))
        case .outInSine:
            if (p < 0.5) {
                return 0.5 * sin(p * 2 * (CGM_PI / 2.0))
            } else {
                return -0.5 * cos(((p * 2) - 1.0) * (CGM_PI / 2.0)) + 1.0
            }
        case .inQuadratic:
            return p * p
        case .outQuadratic:
            return -(p * (p - 2))
        case .inOutQuadratic:
            if p < 0.5 {
                return 2.0 * p * p
            } else {
                return (-2.0 * p * p) + (4.0 * p) - 1.0
            }
        case .outInQuadratic:
            if (p * 2.0) < 1.0 {
                return -(0.5) * (p * 2.0) * ((p * 2.0) - 2.0);
            } else {
                let t = (p * 2.0) - 1.0
                return 0.5 * t * t + 0.5
            }
        case .inCubic:
            return p * p * p
        case .outCubic:
            let f : CGFloat = (p - 1)
            return f * f * f + 1
        case .inOutCubic:
            if p < 0.5 {
                return 4.0 * p * p * p
            } else {
                let f : CGFloat = ((2.0 * p) - 2.0)
                return 0.5 * f * f * f + 1.0
            }
        case .outInCubic:
            let f : CGFloat = (p * 2 - 1.0)
            return 0.5 * f * f * f + 0.5
        case .inQuartic:
            return p * p * p * p
        case .outQuartic:
            let f : CGFloat = (p - 1.0)
            return f * f * f * (1.0 - p) + 1.0
        case .inOutQuartic:
            if (p < 0.5) {
                return 8.0 * p * p * p * p
            } else {
                let f : CGFloat = (p - 1)
                return -8.0 * f * f * f * f + 1.0
            }
        case .outInQuartic:
            if ((p * 2.0 - 1.0) < 0.0) {
                let t = p * 2 - 1
                return -0.5 * (t * t * t * t - 1.0)
            } else {
                let t = p * 2 - 1
                return 0.5 * t * t * t * t + 0.5
            }
        case .inQuintic:
            return p * p * p * p * p
        case .outQuintic:
            let f : CGFloat = (p - 1.0)
            return f * f * f * f * f + 1.0
        case .inOutQuintic:
            if p < 0.5 {
                return 16.0 * p * p * p * p * p
            } else {
                let f : CGFloat = ((2.0 * p) - 2.0)
                return  0.5 * f * f * f * f * f + 1
            }
        case .outInQuintic:
            let f = p * 2.0 - 1.0
            return 0.5 * f * f * f * f * f + 0.5
        case .inExponential:
            return p == 0.0 ? p : pow(2, 10.0 * (p - 1.0))
        case .outExponential:
            return (p == 1.0) ? p : 1.0 - pow(2, -10.0 * p)
        case .inOutExponential:
            if p == 0.0 || p == 1.0 { return p }
            
            if p < 0.5 {
                return 0.5 * pow(2, (20.0 * p) - 10.0)
            } else  {
                return -0.5 * pow(2, (-20.0 * p) + 10.0) + 1.0
            }
        case .outInExponential:
            if p == 1.0 {
                return 0.5
            }
            
            if (p < 0.5) {
                return 0.5 * (1 - pow(2, -10.0 * p * 2.0))
            } else {
                return 0.5 * pow(2, 10.0 * (((p * 2.0) - 1.0) - 1.0)) + 0.5
            }
        case .inCircular:
            return 1 - sqrt(1 - (p * p))
        case .outCircular:
            return sqrt((2 - p) * p)
        case .inOutCircular:
            if p < 0.5 {
                return 0.5 * (1 - sqrt(1 - 4 * (p * p)))
            } else {
                return 0.5 * (sqrt(-((2 * p) - 3) * ((2 * p) - 1)) + 1)
            }
        case .outInCircular:
            let f = p * 2.0 - 1.0
            if (f < 0.0) {
                return 0.5 * sqrt(1 - f * f)
            } else {
                let pProgress = (sqrt(1.0 - f * f) - 1.0)
                return -(0.5) * pProgress + 0.5
            }
        case .inBack:
            return p * p * ((overshoot + 1.0) * p - overshoot)
        case .outBack:
            let f : CGFloat = p - 1.0
            return f * f * ((overshoot + 1.0) * f + overshoot) + 1.0
        case .inOutBack:
            if p < 0.5  {
                let f : CGFloat = 2 * p
                return 0.5 * (f * f * f - f * sin(f * CGM_PI))
            } else {
                let f : CGFloat = (1.0 - (2.0 * p - 1.0))
                let calculated = (f * f * f - f * sin(f * CGM_PI))
                return 0.5 * (1.0 - calculated) + 0.5
            }
        case .outInBack:
            if p < 0.5  {
                let f : CGFloat =  p / 2.0
                return 0.5 * (f * f * f - f * sin(f * CGM_PI))
            } else {
                let f : CGFloat = (1.0 - (2.0 * p - 1.0))
                let calculated = (f * f * f - f * sin(f * CGM_PI))
                return 0.5 * (1.0 - calculated) + 0.5
            }
        case .inElastic:
            return sin(13 * CGM_PI_2 * p) * pow(2, 10 * (p - 1))
        case .outElastic:
            return sin(-13 * CGM_PI_2 * (p + 1)) * pow(2, -10 * p) + 1
        case .inOutElastic:
            if p < 0.5  {
                return 0.5 * sin(13.0 * CGM_PI_2 * (2.0 * p)) * pow(2, 10.0 * ((2.0 * p) - 1.0))
            } else {
                return 0.5 * (sin(-13.0 * CGM_PI_2 * ((2.0 * p - 1.0) + 1.0)) * pow(2, -10.0 * (2.0 * p - 1.0)) + 2.0)
            }
        case .outInElastic:
            if p < 0.5  {
                return 0.5 * (sin(-13.0 * CGM_PI_2 * ((2.0 * p - 1.0) + 1.0)) * pow(2, -10.0 * (2.0 * p - 1.0)) + 2.0)
            } else {
                return 0.5 * sin(13.0 * CGM_PI_2 * (2.0 * p)) * pow(2, 10.0 * ((2.0 * p) - 1.0))
            }
        case .inBounce:
            return 1.0 - PDEasing.outBounce.parametricProgress(1.0 - p)
        case .outBounce:
            if(p < 4.0/11.0) {
                return (121.0 * p * p)/16.0;
            } else if(p < 8.0/11.0) {
                return (363.0/40.0 * p * p) - (99.0/10.0 * p) + 17.0/5.0;
            } else if(p < 9.0/10.0) {
                return (4356.0/361.0 * p * p) - (35442.0/1805.0 * p) + 16061.0/1805.0;
            }else {
                return (54.0/5.0 * p * p) - (513.0/25.0 * p) + 268.0/25.0;
            }
        case .inOutBounce:
            if(p < 0.5) {
                return 0.5 * PDEasing.inBounce.parametricProgress(p * 2.0);
            } else{
                return 0.5 * PDEasing.outBounce.parametricProgress(p * 2.0 - 1.0) + 0.5;
            }
        case .outInBounce:
            if(p < 0.5) {
                return 0.5 * PDEasing.outBounce.parametricProgress(p / 2.0);
            } else{
                return 0.5 * PDEasing.inBounce.parametricProgress(p * 2.0 - 1.0) + 0.5;
            }
        }
    }
    
    public func reverseEasing() -> PDEasing {
        switch self {
        case .linear:
            return .linear
        case .smoothStep:
            return .smoothStep
        case .smootherStep:
            return .smootherStep
        case .inAtan:
            return .outAtan
        case .outAtan:
            return .inAtan
        case .inOutAtan:
            return .inOutAtan
        case .inSine:
            return .outSine
        case .outSine:
            return .inSine
        case .inOutSine:
            return .outInSine
        case .outInSine:
            return .inOutSine
        case .inQuadratic:
            return .outQuadratic
        case .outQuadratic:
            return .inQuadratic
        case .inOutQuadratic:
            return .outInQuadratic
        case .outInQuadratic:
            return .inOutQuadratic
        case .inCubic:
            return .outCubic
        case .outCubic:
            return .inCubic
        case .inOutCubic:
            return .outInCubic
        case .outInCubic:
            return .inOutCubic
        case .inQuartic:
            return .outQuartic
        case .outQuartic:
            return .inQuartic
        case .inOutQuartic:
            return .outInQuartic
        case .outInQuartic:
            return .inOutQuartic
        case .inQuintic:
            return .outQuintic
        case .outQuintic:
            return .inQuintic
        case .inOutQuintic:
            return .outInQuintic
        case .outInQuintic:
            return .inOutQuintic
        case .inExponential:
            return .outExponential
        case .outExponential:
            return .inExponential
        case .inOutExponential:
            return .outInExponential
        case .outInExponential:
            return .inOutExponential
        case .inCircular:
            return .outCircular
        case .outCircular:
            return .inCircular
        case .inOutCircular:
            return .outInCircular
        case .outInCircular:
            return .inOutCircular
        case .inBack:
            return .outBack
        case .outBack:
            return .inBack
        case .inOutBack:
            return .outInBack
        case .outInBack:
            return .inOutBack
        case .inElastic:
            return .outElastic
        case .outElastic:
            return .inElastic
        case .inOutElastic:
            return .outInElastic
        case .outInElastic:
            return .inOutElastic
        case .inBounce:
            return .outBounce
        case .outBounce:
            return .inBounce
        case .inOutBounce:
            return .outInBounce
        case .outInBounce:
            return .inOutBounce
        }
    }
}


public func ==(lhs : PDEasing, rhs : PDEasing) -> Bool {
    switch lhs {
    case .linear:
        switch rhs { case .linear: return true default: return false }
    case .smoothStep:
        switch rhs { case .smoothStep: return true default: return false }
    case .smootherStep:
        switch rhs { case .smootherStep: return true default: return false }
    case .inSine:
        switch rhs { case .inSine: return true default: return false }
    case .outSine:
        switch rhs { case .outSine: return true default: return false }
    case .inOutSine:
        switch rhs { case .inOutSine: return true default: return false }
    case .outInSine:
        switch rhs { case .outInSine: return true default: return false }
    case .inAtan:
        switch rhs { case .inAtan: return true default: return false }
    case .outAtan:
        switch rhs { case .outAtan: return true default: return false }
    case .inOutAtan:
        switch rhs { case .inOutAtan: return true default: return false }
    case .inQuadratic:
        switch rhs { case .inQuadratic: return true default: return false }
    case .outQuadratic:
        switch rhs { case .outQuadratic: return true default: return false }
    case .inOutQuadratic:
        switch rhs { case .inOutQuadratic: return true default: return false }
    case .outInQuadratic:
        switch rhs { case .outInQuadratic: return true default: return false }
    case .inCubic:
        switch rhs { case .inCubic: return true default: return false }
    case .outCubic:
        switch rhs { case .outCubic: return true default: return false }
    case .inOutCubic:
        switch rhs { case .inOutCubic: return true default: return false }
    case .outInCubic:
        switch rhs { case .outInCubic: return true default: return false }
    case .inQuartic:
        switch rhs { case .inQuartic: return true default: return false }
    case .outQuartic:
        switch rhs { case .outQuartic: return true default: return false }
    case .inOutQuartic:
        switch rhs { case .inOutQuartic: return true default: return false }
    case .outInQuartic:
        switch rhs { case .outInQuartic: return true default: return false }
    case .inQuintic:
        switch rhs { case .inQuintic: return true default: return false }
    case .outQuintic:
        switch rhs { case .outQuintic: return true default: return false }
    case .inOutQuintic:
        switch rhs { case .inOutQuintic: return true default: return false }
    case .outInQuintic:
        switch rhs { case .outInQuintic: return true default: return false }
    case .inExponential:
        switch rhs { case .inExponential: return true default: return false }
    case .outExponential:
        switch rhs { case .outExponential: return true default: return false }
    case .inOutExponential:
        switch rhs { case .inOutExponential: return true default: return false }
    case .outInExponential:
        switch rhs { case .outInExponential: return true default: return false }
    case .inCircular:
        switch rhs { case .inCircular: return true default: return false }
    case .outCircular:
        switch rhs { case .outCircular: return true default: return false }
    case .inOutCircular:
        switch rhs { case .inOutCircular: return true default: return false }
    case .outInCircular:
        switch rhs { case .outInCircular: return true default: return false }
    case .inBack:
        switch rhs { case .inBack: return true default: return false }
    case .outBack:
        switch rhs { case .outBack: return true default: return false }
    case .inOutBack:
        switch rhs { case .inOutBack: return true default: return false }
    case .outInBack:
        switch rhs { case .outInBack: return true default: return false }
    case .inElastic:
        switch rhs { case .inElastic: return true default: return false }
    case .outElastic:
        switch rhs { case .outElastic: return true default: return false }
    case .inOutElastic:
        switch rhs { case .inOutElastic: return true default: return false }
    case .outInElastic:
        switch rhs { case .outInElastic: return true default: return false }
    case .inBounce:
        switch rhs { case .inBounce: return true default: return false }
    case .outBounce:
        switch rhs { case .outBounce: return true default: return false }
    case .inOutBounce:
        switch rhs { case .inOutBounce: return true default: return false }
    case .outInBounce:
        switch rhs { case .outInBounce: return true default: return false }
    }
}

