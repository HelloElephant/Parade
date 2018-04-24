//
//  IntroProgressDotView.swift
//  PDAnimator-Demo
//
//  Created by Anton Doudarev on 3/30/18.
//  Copyright © 2018 ELEPHANT. All rights reserved.
//

import Foundation
import UIKit

class ProgressDotView : UIView {
    
    var needsLayout = true
    
    var dotViews = [UIView]()
    var shadowView : ShadowView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    func setupViews() {
        clipsToBounds = true
        
        for x in 0...20
        {
            let view = UIView(frame: CGRect.zero)
            view.frame = CGRect(x:0, y: 10 * x, width:4, height:4)
            view.backgroundColor = UIColor.white
            view.layer.cornerRadius = 2.0
            view.layer.masksToBounds = true
            addSubview(view)
            dotViews.append(view)
        }
        
        shadowView = ShadowView(frame: bounds)
        addSubview(shadowView!)
    }

    override func layoutSubviews()
    {
        super.layoutSubviews()
        shadowView?.frame = bounds
    }
}

class ShadowView : UIView {
    
    var isDrawn = false
    override public init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = UIColor.clear
    }
    
    override public func draw(_ rect: CGRect) {
        
        super.draw(rect)
       
        guard let context = UIGraphicsGetCurrentContext(), !rect.equalTo(CGRect.zero) else {
            return
        }
        
        let gradientColor = UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 1.000)
        
        var red1: CGFloat = 1.0, green1: CGFloat = 1.0, blue1: CGFloat = 1.0, alpha1: CGFloat = 1.0
        var red2: CGFloat = 1.0, green2: CGFloat = 1.0, blue2: CGFloat = 1.0, alpha2: CGFloat = 1.0
        
        UIColor.clear.getRed(&red1, green: &green1, blue: &blue1, alpha: &alpha1)
        gradientColor.getRed(&red2, green: &green2, blue: &blue2, alpha: &alpha2)
        
        let fraction : CGFloat = 0.5
        
        let blendedColor = UIColor(red  : red1   * (1 - fraction) + red2   * fraction,
                                   green: green1 * (1 - fraction) + green2 * fraction,
                                   blue : blue1  * (1 - fraction) + blue2  * fraction,
                                   alpha: alpha1 * (1 - fraction) + alpha2 * fraction);
        
        
        let gradientColors = [gradientColor.cgColor, blendedColor.cgColor, gradientColor.cgColor] as CFArray

        
        guard let gradient = CGGradient(colorsSpace : CGColorSpaceCreateDeviceRGB(),
                                        colors      : gradientColors,
                                        locations   : [0.0, 0.5, 1.0]) else
        {
            return
        }
      
        let rectanglePath = UIBezierPath(rect: rect)
       
        context.saveGState()
        rectanglePath.addClip()
        context.drawLinearGradient(gradient,
                                   start    : CGPoint(x: 0, y: rect.height),
                                   end      : CGPoint(x: 0, y: 0),
                                   options  : CGGradientDrawingOptions())
        context.restoreGState()
    }
}
