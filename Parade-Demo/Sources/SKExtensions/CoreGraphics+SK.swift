//
//  CoreGraphics+ScrollWeaver.swift
//  parallax-kit-demo
//
//  Created by Anton Doudarev on 3/20/18.
//  Copyright © 2018 ELEPHANT. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    var components: (r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
        let components = self.cgColor.components!
        
        switch components.count == 2 {
        case true : return (r: components[0], g: components[0], b: components[0], a: components[1])
        case false: return (r: components[0], g: components[1], b: components[2], a: components[3])
        }
    }
    
    func progressValue(to toValue : UIColor, atProgress progress : CGFloat) -> UIColor {
        
        let fromComponents = self.components
        let toComponents = toValue.components
        
        let r = (1 - progress) * fromComponents.r + progress * toComponents.r
        let g = (1 - progress) * fromComponents.g + progress * toComponents.g
        let b = (1 - progress) * fromComponents.b + progress * toComponents.b
        let a = (1 - progress) * fromComponents.a + progress * toComponents.a
        
        return UIColor(red: r, green: g, blue: b, alpha: a)
    }
}

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
}

extension CGSize
{
    func progressValue(to toSize : CGSize, atProgress progress : CGFloat) -> CGSize {
        let widthDifference  = width.progressValue(to: toSize.width, atProgress: progress)
        let heightDifference = height.progressValue(to: toSize.height, atProgress: progress)
        return CGSize(width : widthDifference, height : heightDifference)
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
}

extension CGVector
{
    func progressValue(to toVector : CGVector, atProgress progress : CGFloat) -> CGVector {
        let dxDifference = dx.progressValue(to: toVector.dx, atProgress: progress)
        let dyDifference = dy.progressValue(to: toVector.dy, atProgress: progress)
        return CGVector(dx : dxDifference, dy : dyDifference)
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
