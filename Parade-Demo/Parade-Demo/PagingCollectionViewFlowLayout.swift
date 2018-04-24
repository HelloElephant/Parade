//
//  PagingCollectionViewFlowLayout.swift
//  PDAnimator
//
//  Created by Anton Doudarev on 3/14/18.
//  Copyright © 2018 ELEPHANT. All rights reserved.
//

import Foundation
import UIKit

struct FlowLayoutConfig {
    
    // The width offset threshold percentage from 0 - 1
    static let thresholdOffsetPrecentage : CGFloat = 0.3
    
    // This is the flick velocity threshold
    static let velocityThreshold : CGFloat = 0.37
    
    // This is the flick velocity threshold
    static let delayedVelocityThreshold : CGFloat = 1.4
}

public class PagingCollectionViewFlowLayout : UICollectionViewFlowLayout {

    override init() {
        super.init()
        self.minimumInteritemSpacing = 0.0
        self.minimumLineSpacing = 0.0
        self.scrollDirection = .vertical
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Tracks the currently visible index
    var visibleIndex : Int = 0 {
        didSet {
            if visibleIndex > (self.collectionView?.numberOfItems(inSection: 0))! - 1 {
                self.visibleIndex = oldValue
            }
        }
    }

    override public func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return false
    }
    
    override public func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {

        let topThreshold = CGFloat(collectionView!.bounds.size.height) * ((CGFloat(visibleIndex) - FlowLayoutConfig.thresholdOffsetPrecentage))
        let bottomThreshold =  CGFloat(collectionView!.bounds.size.height) * ((CGFloat(visibleIndex) + FlowLayoutConfig.thresholdOffsetPrecentage))
        let currentHorizontalOffset = collectionView!.contentOffset.y
        
        let velocityThreshold = FlowLayoutConfig.velocityThreshold
        
        if currentHorizontalOffset < topThreshold ||                  // If the user scrolled past the halfway point
            velocity.y < -velocityThreshold  {                        // If the user flicked the item
            visibleIndex = max(0 , (visibleIndex - 1))
        }
        else if currentHorizontalOffset > bottomThreshold ||          // If the user scrolled past the halfway point
            velocity.y > velocityThreshold {                          // If the user flicked the it
            visibleIndex += 1
            visibleIndex = min((self.collectionView?.numberOfItems(inSection: 0))! - 1, visibleIndex)
        }
    
        var yOffset = CGFloat(collectionView!.bounds.height) * CGFloat(visibleIndex)

        // This ensures that the collecitonview smooth stops at the bottom
        // otherwise it causes a monster bounce sometimes
        if visibleIndex == (collectionView!.numberOfItems(inSection: 0)) - 1
        {
            yOffset -= 1.0
        }
            
        // This ensures that the collecitonview smooth stops at the top
        // otherwise it causes a monster bounce sometimes
        else if visibleIndex == 0 {
             yOffset = 1.0
        }
 
        var _proposedContentOffset = proposedContentOffset
        _proposedContentOffset.y = yOffset

        return _proposedContentOffset
    }
}
