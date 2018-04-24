//
//  SKDefinitions.swift
//  ScrollWeaver
//
//  Created by Anton Doudarev on 3/20/18.
//  Copyright © 2018 ELEPHANT. All rights reserved.
//

import Foundation
import UIKit

enum SKScrollViewDirectionType
{
    case vertical
    case horizontal
    case multiDirectional
}

public indirect enum SKScrollProgress : Equatable
{
    case verticalAboveCenter(progress   : CGFloat)
    case verticalBelowCenter(progress   : CGFloat)
    case verticalCenter
    
    case horizontalRightCenter(progress : CGFloat)
    case horizontalLeftCenter(progress  : CGFloat)
    case horizontalCenter
    
    case directionalProgress(horizontal  : SKScrollProgress, vertical : SKScrollProgress)
}

public func ==(lhs: SKScrollProgress, rhs: SKScrollProgress) -> Bool {
    
    switch (lhs, rhs) {
        
    case let (.verticalAboveCenter(a), .verticalAboveCenter(b)),
         let (.verticalBelowCenter(a), .verticalBelowCenter(b)),
         let (.horizontalRightCenter(a), .horizontalRightCenter(b)),
         let (.horizontalLeftCenter(a), .horizontalLeftCenter(b)) :
        
        return a == b
        
    case (.verticalCenter, .verticalCenter),
         (.horizontalCenter, .horizontalCenter) :
        
        return true
        
    case let (.directionalProgress(a, b), .directionalProgress(c, d)) :
        
        return (a == c && b == d)
        
    default:
        return false
    }
}


