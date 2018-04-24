//
//  SKAnimation.swift
//  ScrollWeaver-Demo
//
//  Created by Anton Doudarev on 3/23/18.
//  Copyright © 2018 ELEPHANT. All rights reserved.
//

import Foundation
import UIKit

public class SKViewAnimation {
    
    weak var view : UIView?
    
    var centeredState    : SKAnimationViewState?
    var appearFromState  : SKAnimationViewState?
    var disappearToState : SKAnimationViewState?
    
    func adjustState(forProgress progress: SKScrollProgress) {
        
        guard let view = view,
            let centeredState = centeredState,
            let appearFromState = appearFromState,
            let disappearToState = disappearToState else
        {
            return
        }
        
        switch progress {
        case let .verticalAboveCenter(progressValue):
            disappearToState.adjustProgress(forView : view,
                                            toState : centeredState,
                                            progress: progressValue)
            
        case let .verticalBelowCenter(progressValue):
            appearFromState.adjustProgress(forView : view,
                                           toState : centeredState,
                                           progress: progressValue)
            
            break
        case .verticalCenter:
            appearFromState.adjustProgress(forView : view,
                                           toState : centeredState,
                                           progress: 1.0)
            
        case let .horizontalLeftCenter(progressValue):
            disappearToState.adjustProgress(forView : view,
                                            toState : centeredState,
                                            progress: progressValue)
        case let .horizontalRightCenter(progressValue):
            appearFromState.adjustProgress(forView : view,
                                           toState : centeredState,
                                           progress: progressValue)
            
        case .horizontalCenter:
            disappearToState.adjustProgress(forView : view,
                                            toState : centeredState,
                                            progress: 1.0)

        default:
            break
        }
    }
}
