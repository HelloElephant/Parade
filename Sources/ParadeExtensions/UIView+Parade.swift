//
//  UIView+PDAnimation.swift
//  PDAnimator
//
//  Created by Anton Doudarev on 4/5/18.
//  Copyright © 2018 ELEPHANT. All rights reserved.
//

import Foundation
import UIKit

private struct PDAssociatedKey {
    static var progressAnimator = "cachedProgressAnimator"
}

internal extension UIView {
    
    var cachedProgressAnimator: PDAnimator?
    {
        get
        {
            return fa_getAssociatedObject(self, associativeKey: &PDAssociatedKey.progressAnimator)
        }
        set
        {
            if let value = newValue
            {
                fa_setAssociatedObject(self, value: value,
                                       associativeKey: &PDAssociatedKey.progressAnimator,
                                       policy: objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
    
    func fa_setAssociatedObject<T>(_ object: AnyObject,
                                   value: T,
                                   associativeKey: UnsafeRawPointer,
                                   policy: objc_AssociationPolicy)
    {
        if T.self is AnyObject.Type {
            objc_setAssociatedObject(object, associativeKey, value as AnyObject,  policy)
        }
    }
    
    func fa_getAssociatedObject<T>(_ object: AnyObject, associativeKey: UnsafeRawPointer) -> T?
    {
        if let v = objc_getAssociatedObject(object, associativeKey) as? T {
            return v
        }
        
        return nil
    }
}
