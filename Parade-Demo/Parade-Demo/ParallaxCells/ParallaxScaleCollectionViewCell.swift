//
//  ParallaxScaleCollectionViewCell.swift
//  PDAnimator-Demo
//
//  Created by Anton Doudarev on 3/30/18.
//  Copyright © 2018 ELEPHANT. All rights reserved.
//

import Foundation
import UIKit

#if ENV_TEST
import PDAnimator
#endif

class ParallaxScaleCollectionViewCell: UICollectionViewCell {

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
        clipsToBounds = false
        contentView.clipsToBounds = false
        
        contentView.backgroundColor = defaultBackgroundColor
        contentView.addSubview(scalingImageView)
        
        // Not the most efficient way to layout
        // content, but good enough for a demo
        
        scalingImageView.frame = CGRect(x: -2.0,
                                        y: 240.0,
                                        width: contentView.bounds.width + 4.0,
                                        height: ceil((contentView.bounds.width) * (9/16)))
    }
    
    // MARK: Lazy Loaded Views
    
    lazy var scalingImageView : UIImageView = {
        [unowned self] in
        let image = UIImageView(image: preloadedImageCache["article_image_2"]! )
        image.clipsToBounds = true
        image.backgroundColor = UIColor.yellow
        image.contentMode = .scaleAspectFill
        return image
        }()
}

// MARK: - PDAnimatableType
extension ParallaxScaleCollectionViewCell : PDAnimatableType
{
    func configuredAnimator() -> PDAnimator {
        
        // The offscreen image transform for appearence / disappearance
        let offScreenScaleTransform = CGAffineTransform.identity.scaledBy(x: 0.5, y: 0.5).translatedBy(x: 0, y: 150.0)
        
        // The offscreen image alpha for appearence / disappearance
        let offScreenAlpha          = CGFloat(0.0)
        
        // The custom animation range
        let animatioRange : ClosedRange<CGFloat> = 0.3...1.0
        
        return PDAnimator.newVerticalAnimator { (animator) in
            
            animator.startEndState(for: contentView, { (s) in
                
                s.backgroundColor(transitioningBackgroundColor)
                
            }).startEndState(for: scalingImageView, { (s) in
                
                s.alpha(offScreenAlpha).range(animatioRange).easing(.outSine)
                
            }).startEndState(for: scalingImageView, { (s) in
                
                s.transform(offScreenScaleTransform).range(animatioRange).easing(.inSine)
                
            })
        }
    }
}
