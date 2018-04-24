//
//  ParallaxTheEndCollectionViewCell.swift
//  PDAnimator-Demo
//
//  Created by Anton Doudarev on 4/4/18.
//  Copyright © 2018 ELEPHANT. All rights reserved.
//

import Foundation
import UIKit

#if ENV_TEST
import PDAnimator
#endif

class ParallaxTheEndCollectionViewCell: UICollectionViewCell {
    
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
        contentView.addSubview(scallingLabel)
        
        let font = UIFont(name: "Helvetica", size: 48)
        var attributes = Dictionary<NSAttributedStringKey , AnyObject>()
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        paragraphStyle.lineBreakMode = .byWordWrapping
        
        attributes[NSAttributedStringKey.paragraphStyle] = paragraphStyle
        attributes[NSAttributedStringKey.foregroundColor] = UIColor.white
        attributes[NSAttributedStringKey.font] = UIFont(descriptor: font!.fontDescriptor.withSymbolicTraits(.traitBold)!, size: font!.pointSize)
        attributes[NSAttributedStringKey.kern] =  (font!.pointSize * 200 / CGFloat(1000.0) as AnyObject?)

        // Not the most effiecient way to layout
        // content, but good enought for a demo
        
        scallingLabel.frame = CGRect(x: -10.0, y: 240.0,
                                     width: contentView.bounds.width + 20.0,
                                     height: (contentView.bounds.width + 20.0) * (9/16))
        
        scallingLabel.attributedText =  NSAttributedString(string: "THE END", attributes: attributes)
    }
    
    // MARK: Lazy Loaded Views
    
    lazy var scallingLabel : UILabel  = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 0
        label.backgroundColor = UIColor.clear
        label.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        return label
    }()

    lazy var scalingImageView : UIImageView = {
        [unowned self] in
        let image = UIImageView(image: UIImage(named: "article_image_2")!)
        image.backgroundColor = UIColor.yellow
        image.contentMode = .scaleAspectFill
        return image
        }()
}

extension ParallaxTheEndCollectionViewCell : PDAnimatableType
{
    func configuredAnimator() -> PDAnimator
    {
        let startingAlpha                   = CGFloat(0.0)
        
        var rotationAndPerspectiveTransform = CATransform3DIdentity
        rotationAndPerspectiveTransform.m34 = 1.0 / -1000;
        rotationAndPerspectiveTransform     = CATransform3DTranslate(rotationAndPerspectiveTransform, 0, -200, 200)
        rotationAndPerspectiveTransform     = CATransform3DScale(rotationAndPerspectiveTransform, 0.0, 0.0, 0)
        rotationAndPerspectiveTransform     = CATransform3DRotate(rotationAndPerspectiveTransform, 280.0 * CGFloat.pi / 180.0, 1.0, 0.0, 0);
        
        let alphaAnimationRange    : ClosedRange<CGFloat>       = 0.4...1.0
        
        return PDAnimator.newVerticalAnimator { (animator) in
            
            animator.startState(for: contentView, { (s) in
                
                s.backgroundColor(defaultBlackColor)
                
            }).startState(for: scallingLabel, { (s) in
                
                s.alpha(startingAlpha).range(alphaAnimationRange).easing(.inSine)
                s.transform3D(rotationAndPerspectiveTransform).easing(.outSine)
                
            })
        }
    }
}
