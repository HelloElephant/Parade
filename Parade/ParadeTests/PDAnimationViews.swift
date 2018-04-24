//
//  PDAnimatorViews.swift
//  PDAnimatorTests
//
//  Created by Anton Doudarev on 4/13/18.
//  Copyright © 2018 ELEPHANT. All rights reserved.
//

import Foundation
import UIKit
@testable import Parade

class VerticalAnimatableView : UIView, PDAnimatableType {
    override init(frame: CGRect) { super.init(frame: frame) }
    required init?(coder aDecoder: NSCoder) { return nil }
    
    func configuredAnimator() -> PDAnimator {
        
        return PDAnimator.newVerticalAnimator { (animator) in
            animator.startState(for: self, { (s) in
                s.alpha(0.0).easing(.linear)
            }).endState(for: self, { (s) in
                s.alpha(0.0).easing(.linear)
            })
        }
    }
}

class HorizontalAnimatableView : UIView, PDAnimatableType {
    
    override init(frame: CGRect) { super.init(frame: frame) }
    required init?(coder aDecoder: NSCoder) { return nil }
    
    func configuredAnimator() -> PDAnimator {
        return PDAnimator.newHorizontalAnimator { (animator) in
            animator.startState(for: self, { (s) in
                s.alpha(0.0).easing(.linear)
            }).endState(for: self, { (s) in
                s.alpha(0.0).easing(.linear)
            })
        }
    }
}
