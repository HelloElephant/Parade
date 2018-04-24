//
//  SKAnimationEasing.swift
//  ScrollWeaver-Demo
//
//  Created by Anton Doudarev on 3/28/18.
//  Copyright © 2018 Anton Doudarev. All rights reserved.
//
//  Based / Renamed from https://github.com/AntonTheDev/FlightParametrics/blob/master/Source/FPEasing.swift
//

import Foundation
import UIKit

let overshoot : CGFloat = 1.70158
let CGM_PI_2 = CGFloat(Double.pi / 2)
let CGM_PI = CGFloat(Double.pi)

public enum SKAnimationEasing : Equatable {
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
            return 1.0 - SKAnimationEasing.outBounce.parametricProgress(1.0 - p)
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
                return 0.5 * SKAnimationEasing.inBounce.parametricProgress(p * 2.0);
            } else{
                return 0.5 * SKAnimationEasing.outBounce.parametricProgress(p * 2.0 - 1.0) + 0.5;
            }
        case .outInBounce:
            if(p < 0.5) {
                return 0.5 * SKAnimationEasing.outBounce.parametricProgress(p / 2.0);
            } else{
                return 0.5 * SKAnimationEasing.inBounce.parametricProgress(p * 2.0 - 1.0) + 0.5;
            }
        }
    }
    
    public func reverseEasing() -> SKAnimationEasing {
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


public func ==(lhs : SKAnimationEasing, rhs : SKAnimationEasing) -> Bool {
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
