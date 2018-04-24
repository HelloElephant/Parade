//
//  ParallaxImageCollectionViewCell.swift
//  PDAnimator-Demo
//
//  Created by Anton Doudarev on 3/22/18.
//  Copyright © 2018 ELEPHANT. All rights reserved.
//

import Foundation
import UIKit

#if ENV_TEST
import PDAnimator
#endif

class ParallaxImageCollectionViewCell: UICollectionViewCell {

    override init(frame: CGRect)
    {
        super.init(frame: frame)
        setupInterface()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setupInterface()
    }
    
    func setupInterface()
    {
        clipsToBounds = true
        contentView.clipsToBounds = false
        contentView.backgroundColor = defaultBackgroundColor
        
        contentView.addSubview(parallaxImageView)
        
        // Not the most effiecient way to layout
        // content, but good enough for a demo
        
        parallaxImageView.bounds.size = CGSize(width: contentView.bounds.width * 0.9,
                                               height: (contentView.bounds.width * 0.9) * (9/16))
        
        parallaxImageView.center = CGPoint(x : contentView.bounds.width / 2.0,
                                           y: (parallaxImageView.bounds.height / 2.0) + contentView.bounds.height * 0.2)
    }
    
    // MARK: Lazy Loaded Views
    
    lazy var parallaxImageView : ParallaxImageView  = {
        let view = ParallaxImageView(frame: .zero)
        view.backgroundColor = UIColor.white
        return view
    }()
}


// MARK: - PDAnimatableType
extension ParallaxImageCollectionViewCell : PDAnimatableType
{
    func configuredAnimator() -> PDAnimator
    {
        // Initial center for the parallax image view
        let startingImageCenter       = CGPoint(x: parallaxImageView.center.x, y: parallaxImageView.center.y + 00.0)
        
        // Final center for the parallax image view
        let finalImageCenter          = CGPoint(x: parallaxImageView.center.x, y: parallaxImageView.center.y + 340.0)
        
        return PDAnimator.newVerticalAnimator { (animator) in
            
            animator.startEndState(for: contentView, { (s) in
                
                s.backgroundColor(transitioningBackgroundColor)
                
            }).startState(for: parallaxImageView, { (s) in
                
                s.center(startingImageCenter).easing(.inSine)
                
            }).endState(for: parallaxImageView, { (s) in
                
                s.center(finalImageCenter).easing(.inSine)
                s.alpha(0.0).easing(.inSine)
            
            // By attaching hte view, we are forwarding
            // the progress to the parallax imageview
            }).attachAnimatableView(parallaxImageView)
        }
    }
}
