//
//  ParallaxImageView.swift
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

class ParallaxImageView : UIView {
    
    var imageName = "" {
        didSet {
            if imageName != oldValue {
                scrollingImageView.image = UIImage(named: self.imageName)
            }
        }
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        clipsToBounds = true
        addSubview(scrollingImageView)
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        clipsToBounds = true
        addSubview(scrollingImageView)
    }

    override func layoutSubviews()
    {
        super.layoutSubviews()
        scrollingImageView.bounds.size = CGSize(width : ceil(bounds.width * 1.75), height : ceil(bounds.height * 1.75))
        scrollingImageView.center = CGPoint(x : bounds.width / 2.0 , y : bounds.height / 2.0)
    }

    lazy var scrollingImageView : UIImageView = {
        [unowned self] in
        let image = UIImageView(image:preloadedImageCache["article_image_1"]!)
        image.backgroundColor = UIColor.clear
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
        }()
}

// MARK: - PDAnimatableType

extension ParallaxImageView : PDAnimatableType
{
    func configuredAnimator() -> PDAnimator
    {
        let startingCenter       = CGPoint(x: scrollingImageView.center.x, y: scrollingImageView.center.y - bounds.height * (0.75 / 2.0))
        let finalCenter          = CGPoint(x: scrollingImageView.center.x, y: scrollingImageView.center.y - bounds.height * (0.75 / 2.0))
        
        return PDAnimator.newVerticalAnimator { (animator) in
            
            animator.startState(for: scrollingImageView, { (s) in
                
                s.center(startingCenter).easing(.inSine)
                
            }).endState(for: scrollingImageView, { (s) in
                
                s.center(finalCenter).easing(.outSine)
                
            })
        }
    }
}
