//
//  PDAnimatorViewState.swift
//  PDAnimator-Demo
//
//  Created by Anton Doudarev on 3/22/18.
//  Copyright © 2018 ELEPHANT. All rights reserved.
//

import Foundation
import UIKit

/**
 *  This is a view state that contains an array of properties
 *  and their associated property values to interpolate against
 **/
public class PDAnimatorViewState {
    
    
    /// The properties defined by the builder
    var animatableProperties : [String : PDAnimatableProperty] = [String : PDAnimatableProperty]()
    
    /// This method calculates the progress values, and applies the final values
    /// to the view being pasesd in. EAch property has a range, and easing that
    /// is associated with the property key, and used in the adjusting the progress
    /// between states
    ///
    /// - Parameters:
    ///   - view: the view to apply the final values to
    ///   - state: the state to interpolate to
    ///   - progress: the progress to apply between states
    func adjustProgress(forView view: UIView,
                        toState state : PDAnimatorViewState,
                        progress: CGFloat) {
        
        for (key, property) in animatableProperties
        {
            property.adjustProgress(forView: view, toValue : state.animatableProperties[key]?.propertyValue, progress: progress)
        }
    }
}
