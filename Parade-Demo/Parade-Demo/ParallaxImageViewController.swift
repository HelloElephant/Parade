//
//  ParallaxImageViewController.swift
//  PDAnimator-Demo
//
//  Created by Anton Doudarev on 3/22/18.
//  Copyright © 2018 ELEPHANT. All rights reserved.
//

import Foundation
import UIKit

public let defaultBlackColor            = UIColor.color(forHex: 0x000000)
public let defaultBackgroundColor       = UIColor.color(forHex: 0x000000)
public let transitioningBackgroundColor = UIColor.color(forHex: 0x050505)

class ParallaxImageViewController : UIViewController {
    
    override func viewWillAppear(_ animated : Bool)
    {
        super.viewWillAppear(animated)
        self.additionalSafeAreaInsets = UIEdgeInsets.zero
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        UIApplication.shared.isStatusBarHidden = true
        if #available(iOS 11.0, *)
        {
            collectionView.contentInsetAdjustmentBehavior = .never
        }
        
        setupInterface()
    }
    
    func setupInterface()
    {
        view.clipsToBounds = true
        view.backgroundColor = defaultBackgroundColor
        view.addSubview(collectionView)
        
        registerCells()
        
        // Not the most efficient way to layout
        // content, but good enough for a demo
        
        collectionView.frame = view.bounds
    }
    
    lazy var collectionView : UICollectionView = {
        [unowned self] in
        
        let layout = PagingCollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        var collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.clipsToBounds = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = defaultBlackColor
        collectionView.alwaysBounceVertical = false
        collectionView.decelerationRate = UIScrollViewDecelerationRateNormal
        collectionView.delegate = self
        collectionView.bounces = true
        collectionView.dataSource = self
        collectionView.contentInsetAdjustmentBehavior = .never
        return collectionView
        }()
}


// MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout

extension ParallaxImageViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {

    func registerCells()
    {
        collectionView.register(ParallaxIntroCollectionViewCell.self, forCellWithReuseIdentifier: "ParallaxIntroCollectionViewCell")
        collectionView.register(ParallaxScaleCollectionViewCell.self, forCellWithReuseIdentifier: "ParallaxScaleCollectionViewCell")
        collectionView.register(ParallaxDoubleImageCollectionViewCell.self, forCellWithReuseIdentifier: "ParallaxDoubleImageCollectionViewCell")
        collectionView.register(ParallaxImageCollectionViewCell.self, forCellWithReuseIdentifier: "ParallaxImageCollectionViewCell")
        collectionView.register(ParallaxImageAppearCollectionViewCell.self, forCellWithReuseIdentifier: "ParallaxImageAppearCollectionViewCell")
        collectionView.register(ParallaxTheEndCollectionViewCell.self, forCellWithReuseIdentifier: "ParallaxTheEndCollectionViewCell")
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        switch indexPath.row {
        case 0:
            return collectionView.dequeueReusableCell(withReuseIdentifier: "ParallaxIntroCollectionViewCell",
                                                      for: indexPath) as! ParallaxIntroCollectionViewCell
        case 1:
            return collectionView.dequeueReusableCell(withReuseIdentifier: "ParallaxScaleCollectionViewCell",
                                                      for: indexPath) as! ParallaxScaleCollectionViewCell
        case 2:
            return collectionView.dequeueReusableCell(withReuseIdentifier: "ParallaxDoubleImageCollectionViewCell",
                                                      for: indexPath) as! ParallaxDoubleImageCollectionViewCell
        case 4:
            return collectionView.dequeueReusableCell(withReuseIdentifier: "ParallaxImageAppearCollectionViewCell",
                                                      for: indexPath) as! ParallaxImageAppearCollectionViewCell
        case 5:
            return collectionView.dequeueReusableCell(withReuseIdentifier: "ParallaxTheEndCollectionViewCell",
                                                      for: indexPath) as! ParallaxTheEndCollectionViewCell
        default:
            return collectionView.dequeueReusableCell(withReuseIdentifier: "ParallaxImageCollectionViewCell",
                                                      for: indexPath) as! ParallaxImageCollectionViewCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) { }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width : collectionView.bounds.size.width, height : collectionView.bounds.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        return CGFloat(0.0)
    }
}
