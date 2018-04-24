//
//  ParallaxImageAppearCollectionViewCell.swift
//  PDAnimator-Demo
//
//  Created by Anton Doudarev on 3/31/18.
//  Copyright © 2018 ELEPHANT. All rights reserved.
//

import Foundation
import UIKit

#if ENV_TEST
import PDAnimator
#endif

class ParallaxImageAppearCollectionViewCell: UICollectionViewCell {

    let defaultAlpha              = CGFloat(1.0)
    let defaultTransform          = CGAffineTransform.identity
    
    let horizontalOffset : CGFloat = 40.0
    let topOffset        : CGFloat = 260.0
    let bottomInset      : CGFloat = 260.0
    let crossAirSize     : CGSize  = CGSize(width:30, height:30)

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
        contentView.addSubview(adjustableImage)
        contentView.addSubview(topLeftCrossAir)
        contentView.addSubview(topRightCrossAir)
        contentView.addSubview(bottomLeftCrossAir)
        contentView.addSubview(bottomRightCrossAir)
        
        // Not the most efficient way to layout
        // content, but good enough for a demo
        
        topLeftCrossAir.bounds.size     = crossAirSize
        topRightCrossAir.bounds.size    = crossAirSize
        bottomLeftCrossAir.bounds.size  = crossAirSize
        bottomRightCrossAir.bounds.size = crossAirSize
        
        adjustableImage.frame       = CGRect(x: contentView.bounds.width * 0.2,
                                             y: (contentView.bounds.height * 0.5) - contentView.bounds.width * 0.3,
                                             width: contentView.bounds.width * 0.6,
                                             height: contentView.bounds.width * 0.6)
        
        topLeftCrossAir.center      = CGPoint(x : adjustableImage.frame.minX - 20.0, y : adjustableImage.frame.minY)
        topRightCrossAir.center     = CGPoint(x : adjustableImage.frame.maxX + 20.0, y : adjustableImage.frame.minY)
        bottomLeftCrossAir.center   = CGPoint(x : adjustableImage.frame.minX - 20.0, y : adjustableImage.frame.maxY)
        bottomRightCrossAir.center  = CGPoint(x : adjustableImage.frame.maxX + 20.0, y : adjustableImage.frame.maxY)
        adjustableImage.transform   = CGAffineTransform.identity.scaledBy(x: 0.95, y: 0.95)
    }

    // MARK: Lazy Loaded Views
    
    lazy var topLeftCrossAir : UIImageView = {
        let image = self.newCrossAirImageView("cross_air_1")
        return image
    }()
    
    lazy var topRightCrossAir : UIImageView = {
        let image = self.newCrossAirImageView("cross_air_2")
        return image
    }()
    
    lazy var bottomLeftCrossAir : UIImageView = {
        let image = self.newCrossAirImageView("cross_air_3")
        return image
    }()
    
    lazy var bottomRightCrossAir : UIImageView = {
        let image = self.newCrossAirImageView("cross_air_4")
        return image
    }()
    
    func newCrossAirImageView(_ imageName : String) -> UIImageView {
        let view = UIImageView(image :preloadedImageCache[imageName]!)
        view.backgroundColor = UIColor.clear
        view.alpha = 0.8
        view.contentMode = .scaleAspectFit
        return view
    }
    
    lazy var adjustableImage : UIImageView = {
        [unowned self] in
        let image: UIImageView = UIImageView(image : preloadedImageCache["elephant_logo_small"]!)
        image.backgroundColor = UIColor.clear
        image.contentMode = .scaleAspectFill
        
        image.clipsToBounds = false
        return image
        }()
}


// MARK: - PDAnimatableType
extension ParallaxImageAppearCollectionViewCell : PDAnimatableType
{
    func configuredAnimator() -> PDAnimator
    {
        let animatedCrossairs       = [topLeftCrossAir, bottomLeftCrossAir, topRightCrossAir, bottomRightCrossAir]
        let leftAnimatedCrossairs   = [topLeftCrossAir, bottomLeftCrossAir]
        let rightAnimatedCrossairs  = [topRightCrossAir, bottomRightCrossAir]
        
        let crossairAlphaRange : ClosedRange<CGFloat>   = 0.0...0.4
        let animationRange : ClosedRange<CGFloat>       = 0.6...1.0
        
        let startingCenter       = CGPoint(x : contentView.bounds.width / 2.0, y : -100)
        let finalCenter          = CGPoint(x : contentView.bounds.width / 2.0, y : 700)
        
        let rightFinalTransform  = CGAffineTransform.identity.scaledBy(x: 0.0, y: 0.0).rotated(by: -CGFloat(Float.pi / 2.0))
        let leftFinalTransform   = CGAffineTransform.identity.scaledBy(x: 0.0, y: 0.0).rotated(by: CGFloat(Float.pi / 2.0))
        let zeroScaleTransform   = CGAffineTransform.identity.scaledBy(x: 0.0, y: 0.0).rotated(by: CGFloat(Float.pi / 2.0))
        
        let finalAlpha           = CGFloat(0.0)
        
        return PDAnimator.newVerticalAnimator({ (animator) in
            
            animator.startEndState(for: contentView, { (s) in
                
                s.backgroundColor(transitioningBackgroundColor)
                
            }).startState(forViews: animatedCrossairs, { (s) in
                
                s.center(startingCenter).range(animationRange).easing(.outSine)
                
            }).endState(forViews: animatedCrossairs, { (s) in
                
                s.center(finalCenter).range(animationRange).easing(.outSine)
                
            }).startEndState(forViews: leftAnimatedCrossairs, { (s) in
                
                s.transform(leftFinalTransform).range(animationRange)
                s.alpha(finalAlpha).range(crossairAlphaRange).easing(.outSine)
                
            }).startEndState(forViews: rightAnimatedCrossairs, { (s) in
                
                s.transform(rightFinalTransform).range(animationRange)
                s.alpha(finalAlpha).range(crossairAlphaRange).easing(.outSine)
                
            }).startState(for: adjustableImage, { (s) in
                
                s.center(startingCenter).range(animationRange).easing(.outSine)
                s.transform(zeroScaleTransform).range(animationRange).easing(.inSine)
                s.alpha(finalAlpha).range(animationRange).range(animationRange).easing(.inSine)
                
            }).endState(for: adjustableImage, { (s) in
                
                s.center(finalCenter).range(animationRange).easing(.outSine)
                s.transform(zeroScaleTransform).range(animationRange).easing(.inSine)
                s.alpha(finalAlpha).range(animationRange).easing(.inSine)
                
            })
        })
    }

}
