//
//  ParallaxDoubleImageCell.swift
//  PDAnimator-Demo
//
//  Created by Anton Doudarev on 3/29/18.
//  Copyright © 2018 ELEPHANT. All rights reserved.
//

import Foundation
import UIKit

#if ENV_TEST
import PDAnimator
#endif

class ParallaxDoubleImageCollectionViewCell: UICollectionViewCell
{    
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
        
        contentView.addSubview(parallaxContainerView)
        parallaxContainerView.addSubview(leftImageView)
        parallaxContainerView.addSubview(rightImageView)

        // Not the most efficient way to layout
        // content, but good enough for a demo
        
        parallaxContainerView.frame = CGRect(x      : 0,
                                     y      : 140.0,
                                     width  : contentView.bounds.width,
                                     height : contentView.bounds.width)
        
        let width = bounds.width * 0.42
        let height = bounds.width * 0.54

        leftImageView.frame = CGRect(x: (parallaxContainerView.bounds.width / 2.0) - (width),
                                     y: (parallaxContainerView.bounds.height -  height) / 2.0 + (height * 0.32),
                                     width : ceil(width),
                                     height : ceil(height))
        
        rightImageView.frame = CGRect(x: (parallaxContainerView.bounds.width / 2.0) + 1,
                                      y: (parallaxContainerView.bounds.height -  height) / 2.0,
                                      width : ceil(width),
                                      height : ceil(height))
    }

    
    // MARK: Lazy Loaded Views
    
    lazy var parallaxContainerView : UIView = {
        [unowned self] in
        let view = UIView(frame: CGRect.zero)
        view.backgroundColor = UIColor.clear
        view.clipsToBounds = false
        return view
        }()
    
    lazy var leftImageView : UIImageView = {
        [unowned self] in
        let image: UIImageView = UIImageView(image : preloadedImageCache["two-image-left"]!)
        image.backgroundColor = UIColor.clear
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.clipsToBounds = true
        return image
        }()
    
    lazy var rightImageView : UIImageView = {
        [unowned self] in
        let image: UIImageView =  UIImageView(image : preloadedImageCache["two-image-right"]!)
        image.backgroundColor = UIColor.clear
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.clipsToBounds = true
        return image
        }()
}


// MARK: - PDAnimatableType
extension ParallaxDoubleImageCollectionViewCell : PDAnimatableType
{
    func configuredAnimator() -> PDAnimator {
        
        // NOTE : The parallaxContainerView view contains the two views and
        //        is moved independently from the left adn right views
        
        // The offscreen container view transform for appearence
        let initialContainerTransform = CGAffineTransform.identity.translatedBy(x: 0.0, y: -80)
        
        // The offscreen container view transform for disappearence
        let finalContainertransform = CGAffineTransform.identity.translatedBy(x: 0.0, y: 280)
        
        // The offscreen right view center adjustment
        let offScreenRightViewTransform = CGAffineTransform.identity.translatedBy(x: 0.0, y: rightImageView.bounds.height / 4.0)
        
        // The offscreen left view center adjustment
        let offScreenLeftViewTransform = CGAffineTransform.identity.translatedBy(x: 0.0, y: -leftImageView.bounds.height / 2.0)
        
        // The offscreen alpha adjustment
        let offScreenAlpha           = CGFloat(0.0)
        
        return PDAnimator.newVerticalAnimator { (animator) in
            
            animator.startEndState(for: contentView, { (s) in
                
                s.backgroundColor(transitioningBackgroundColor)
                
            }).startState(for: parallaxContainerView, { (s) in
                
                s.transform(initialContainerTransform).easing(.outSine)
                s.alpha(offScreenAlpha).easing(.outSine)
                
            }).endState(for: parallaxContainerView, { (s) in
                
                s.transform(finalContainertransform).easing(.outSine)
                s.alpha(offScreenAlpha).easing(.outSine)
            
            }).startEndState(for: rightImageView, { (s) in
                
                s.transform(offScreenRightViewTransform).easing(.outSine)
                
            }).startEndState(for: leftImageView, { (s) in
                
                s.transform(offScreenLeftViewTransform).easing(.outSine)
            })
        }
    }
}
