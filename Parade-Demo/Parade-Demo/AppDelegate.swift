//
//  AppDelegate.swift
//  PDAnimator-Demo
//
//  Created by Anton Doudarev on 3/14/18.
//  Copyright © 2018 ELEPHANT. All rights reserved.
//

import UIKit

public var preloadedImageCache = [String : UIImage]()

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var baseNavViewController: UINavigationController = UINavigationController()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
       
        UIScrollView.initializeParade()
        
        // Images are preloaded because
        // there are no async downloads
        preloadImages()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor : UIColor.white,
                                                             NSAttributedStringKey.font : UIFont(name: "HELVETICA", size: 14)!], for: .normal)
        let navigationBarAppearace = UINavigationBar.appearance()
        
        navigationBarAppearace.tintColor = UIColor.white
        navigationBarAppearace.barTintColor =  UIColor.color(forHex: 0x000000)
        navigationBarAppearace.backgroundColor = UIColor.color(forHex: 0x000000)
        navigationBarAppearace.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white,
                                                      NSAttributedStringKey.kern : 1.3,
                                                      NSAttributedStringKey.font : UIFont(name: "HELVETICA", size: 16)!]

        let homeViewController = ParallaxImageViewController()
        baseNavViewController.pushViewController(homeViewController, animated: false)
        window?.rootViewController = baseNavViewController
        window?.makeKeyAndVisible()
        
        return true
    }
    
    func preloadImages()
    {
        preloadedImageCache["elephant_logo"] = UIImage(named: "elephant_logo")!
        preloadedImageCache["elephant_logo_small"] = UIImage(named: "elephant_logo_small")
        preloadedImageCache["article_image_1"] = UIImage(named: "article_image_1")
        preloadedImageCache["article_image_2"] = UIImage(named: "article_image_2")
        preloadedImageCache["two-image-left"] = UIImage(named: "two-image-left")
        preloadedImageCache["two-image-right"] = UIImage(named: "two-image-right")
        preloadedImageCache["cross_air_1"] = UIImage(named: "cross_air")
        preloadedImageCache["cross_air_2"] = UIImage(named: "cross_air")
        preloadedImageCache["cross_air_3"] = UIImage(named: "cross_air")
        preloadedImageCache["cross_air_4"] = UIImage(named: "cross_air")
    }
}

