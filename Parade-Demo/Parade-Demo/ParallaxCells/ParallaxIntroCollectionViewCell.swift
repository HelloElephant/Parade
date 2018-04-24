//
//  ParallaxIntroCollectionViewCell.swift
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

class ParallaxIntroCollectionViewCell: UICollectionViewCell {

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
        contentView.backgroundColor = defaultBlackColor
        
        contentView.addSubview(logoImageView)
        contentView.addSubview(progressView)
        contentView.addSubview(arrowImageView)
      
        // Not the most efficient way to layout
        // content, but good enough for a demo
        
        logoImageView.frame = CGRect(origin: CGPoint(x: (contentView.bounds.width / 2.0) - 120, y: 130),
                                     size: CGSize(width: 240, height : 240))
        
        arrowImageView.frame = CGRect(origin: CGPoint(x: (contentView.bounds.width / 2.0) - 40,
                                                     y: (contentView.bounds.height) - 130),
                                     size: CGSize(width: 80, height : 46))
        
        
        progressView.frame = CGRect(origin: CGPoint(x: (contentView.bounds.width / 2.0) - 2, y: contentView.bounds.height - 254),
                                    size: CGSize(width: 4, height : 80))
    }
    
    // MARK: Lazy Loaded Views
    
    lazy var logoImageView : UIImageView = {
        [unowned self] in
        let image: UIImageView = UIImageView(image :  preloadedImageCache["elephant_logo"]!)
        image.backgroundColor = UIColor.clear
        image.contentMode = .scaleAspectFit
        return image
        }()
    
    lazy var progressView : ProgressDotView = {
        [unowned self] in
        let view = ProgressDotView(frame:CGRect.zero)
        view.backgroundColor = UIColor.clear
        return view
        }()
    
    lazy var arrowImageView : UIImageView = {
        [unowned self] in
        let image: UIImageView = UIImageView(image :UIImage(named: "down_arrow"))
        image.backgroundColor = UIColor.clear
        image.contentMode = .scaleAspectFit
        image.alpha = 0.8
        return image
        }()
}


// MARK: - PDAnimatableType

extension ParallaxIntroCollectionViewCell: PDAnimatableType
{
    func configuredAnimator() -> PDAnimator
    {
        // The logo transform for appearence / disappearance
        let offScreenLogoTransform      = CGAffineTransform.identity.scaledBy(x: 1.6, y: 1.6).translatedBy(x: 0, y: 50.0)
       
        // The arrow transform for appearence / disappearance
        let offScreenArrowTransform     = CGAffineTransform.identity.scaledBy(x: 0.1, y: 0.1).translatedBy(x: 0, y: 160.0)
        
        // The progress dots view transform for appearence / disappearance
        let offScreenDotsViewTransform  = CGAffineTransform.identity.translatedBy(x: 0, y: -10.0).scaledBy(x: 0.8, y: 1.0)
        
        // The alpha for appearence / disappearance of all elements
        let offScreenAlpha              = CGFloat(0.0)
        
        // The size for dots view for appearence / disappearance
        // Size is used so that it redraws the view and does not stretch it
        let offScreenDotViewSize         = progressView.bounds.size.scaledValue(width: 0.8, height : 3.0)
        
        return PDAnimator.newVerticalAnimator { (animator) in
            
            animator.endState(for: logoImageView, { (s) in
                
                s.alpha(offScreenAlpha).easing(.inSine)
                s.transform(offScreenLogoTransform)
                
            }).endState(for: arrowImageView, { (s) in
                
                s.alpha(offScreenAlpha).easing(.inSine)
                s.transform(offScreenArrowTransform)
                
            }).endState(for: contentView, { (s) in
                
                s.backgroundColor(transitioningBackgroundColor)
                
            }).endState(for: progressView, { (s) in
                
                s.alpha(offScreenAlpha).easing(.inSine)
                s.transform(offScreenDotsViewTransform).easing(.inSine)
                
            }).startEndState(for: progressView, { (s) in
             
                s.size(offScreenDotViewSize).easing(.inSine)
            
            })
        }
    }
}

