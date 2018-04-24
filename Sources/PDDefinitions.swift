//
//  PDDefinitions.swift
//  PDAnimator
//
//  Created by Anton Doudarev on 3/20/18.
//  Copyright © 2018 ELEPHANT. All rights reserved.
//

import Foundation
import UIKit

/**
 *  Protocol to be implemented UIViews objects that be added to
 *  the scroll view hierarchy as a subview
 *
 *  - For UIScrollView implement any UIView added to the hierarchy
 *  - For UITableView implement on UITableViewCell
 *  - For UICollectionView implement on UICollectionViewCell
 *
 **/
public protocol PDAnimatableType
{
    // The progress animator definition that interpolates animatable properties
    func configuredAnimator() -> PDAnimator;
}

internal enum PDProgressDirection
{
    /// Interpolates over the y center progress of the PDAnimatableType
    case vertical
    
    /// Interpolates horizontally based on the relative center.x value
    case horizontal
}

/// This is the progress that is being communicated to the scrollview's subviews.
/// I.E. When scrolling vertically, the center of the aparing view prior to scrolling
///      onto the screen from below, will calculate the progress from 0.0 to 1.0 using
///      it's center and converting it relative to the view port (UIScreen) center.
///
///      So when the view is appeariong it goes from .verticalBelowCenter(0.0) to .verticalBelowCenter(1.0).
///      Then when it disappears it goes from .verticalAboveCenter(1.0) to .verticalAboveCenter(0.0).
///      When the view's center is aligned with the viewport center the progress is verticalCenter
///
///      Appearing from the right horizontally,it goes .horizontalRightCenter(0.0) to .horizontalRightCenter(1.0)
///      Then when it disappears to the left, it goes  .horizontalLeftCenter(1.0) to .horizontalLeftCenter(0.0)
///
///      Notice that the progress is always from 0.0 -> 1.0 -> 0.0
///
/// - verticalAboveCenter: vertical progress above the relative center
/// - verticalBelowCenter: vertical progress below the relative center
/// - verticalCenter: vertical center progress
/// - horizontalRightCenter: horizontal progress to the right the relative center
/// - horizontalLeftCenter:  horizontal progress to the left the relative center
/// - horizontalCenter: horizontal center progress
internal enum PDScrollProgressType : Equatable
{
    case verticalAboveCenter(progress   : CGFloat)
    case verticalBelowCenter(progress   : CGFloat)
    case verticalCenter
    
    case horizontalRightCenter(progress : CGFloat)
    case horizontalLeftCenter(progress  : CGFloat)
    case horizontalCenter
}


/// Equatable Type Definition
///
/// - Parameters:
///   - lhs: lefthand side
///   - rhs: hight handside
/// - Returns: true, if the enums is equal
internal func ==(lhs: PDScrollProgressType, rhs: PDScrollProgressType) -> Bool {
    
    switch (lhs, rhs) {
        
    case let (.verticalAboveCenter(a), .verticalAboveCenter(b)),
         let (.verticalBelowCenter(a), .verticalBelowCenter(b)),
         let (.horizontalRightCenter(a), .horizontalRightCenter(b)),
         let (.horizontalLeftCenter(a), .horizontalLeftCenter(b)) :
        
        return a == b
        
    case (.verticalCenter, .verticalCenter),
         (.horizontalCenter, .horizontalCenter) :
        
        return true
        
    default:
        return false
    }
}
