//
//  PDAnimatorViewMaker.swift
//  PDAnimator-Demo
//
//  Created by Anton Doudarev on 4/3/18.
//  Copyright © 2018 ELEPHANT. All rights reserved.
//

import Foundation
import UIKit

public class PDAnimatorViewMaker
{
    
    /// All the View property states that are being created for a view by the view state maker
    /// and used to constrcut the final state with properties by the animation maker
    internal var propertyStates : [String : PDAnimatablePropertyMaker] = [String :  PDAnimatablePropertyMaker]()
    
    
    /// This method returns a constrcuted PDAnimatorViewState
    ///
    /// - Returns: constucted instance of an PDAnimatorViewState
    internal func constructedState() -> PDAnimatorViewState?
    {
        guard propertyStates.keys.count > 0 else {
            return nil
        }
        
        let animationState = PDAnimatorViewState()
        
        for (key, propertyState) in propertyStates
        {
            animationState.animatableProperties[key] = propertyState.constructedPropertyState()
        }
        
        return animationState
    }
    
    
    /// Generic method to create a property maker to build on
    ///
    /// - Parameters:
    ///   - value: the values for the property
    ///   - key: the KVC key for the property that will be set on the view or layer
    /// - Returns: returns self, to recursively continue the building process
    @discardableResult public func viewValue(_ value : Any?, forKey key : String)  -> PDAnimatablePropertyMaker
    {
        if propertyStates[key] == nil
        {
            let stateProperty = PDAnimatablePropertyMaker()
            
            stateProperty.propertyValue = value
            stateProperty.propertyKey = key
            stateProperty.propertyType = .viewValue
            propertyStates[key] = stateProperty
        }
        
        return propertyStates[key]!
    }
    
    /// Generic method to create a property maker to build on
    ///
    /// - Parameters:
    ///   - value: the values for the property
    ///   - key: the KVC key for the property that will be set on the view or layer
    /// - Returns: returns self, to recursively continue the building process
    @discardableResult public func layerValue(_ value : Any?, forKey key : String)  -> PDAnimatablePropertyMaker
    {
        if propertyStates[key] == nil
        {
            let stateProperty = PDAnimatablePropertyMaker()
            
            stateProperty.propertyValue = value
            stateProperty.propertyKey = key
            stateProperty.propertyType = .layerValue
            propertyStates[key] = stateProperty
        }
        
        return propertyStates[key]!
    }
}


// MARK: - View Property Setters
extension PDAnimatorViewMaker
{
    @discardableResult public func alpha(_ value : CGFloat) -> PDAnimatablePropertyMaker
    {
        return viewValue(value, forKey: "alpha")
    }
    
    @discardableResult public func backgroundColor(_ value : UIColor) -> PDAnimatablePropertyMaker
    {
        return viewValue(value, forKey: "backgroundColor")
    }
    
    @discardableResult public func bounds(_ value : CGRect) -> PDAnimatablePropertyMaker
    {
        return viewValue(value, forKey: "bounds")
    }
    
    @discardableResult public func center(_ value : CGPoint) -> PDAnimatablePropertyMaker
    {
        return viewValue(value, forKey: "center")
    }
    
    @discardableResult public func size(_ value : CGSize) -> PDAnimatablePropertyMaker
    {
        return viewValue(CGRect(origin: CGPoint.zero, size: value), forKey: "bounds")
    }
    
    @discardableResult public func transform(_ value : CGAffineTransform) -> PDAnimatablePropertyMaker
    {
        return viewValue(value, forKey: "transform")
    }
}

// MARK: - CALayer Property Setters
extension PDAnimatorViewMaker
{
    @discardableResult public func borderColor(_ value : CGColor) -> PDAnimatablePropertyMaker
    {
        return layerValue(value, forKey: "borderColor")
    }
    
    @discardableResult public func borderWidth(_ value : CGFloat) -> PDAnimatablePropertyMaker
    {
        return layerValue(value, forKey: "borderWidth")
    }
    
    @discardableResult public func contentsRect(_ value : CGRect) -> PDAnimatablePropertyMaker
    {
        return layerValue(value, forKey: "contentsRect")
    }
    
    @discardableResult public func cornerRadius(_ value : CGFloat) -> PDAnimatablePropertyMaker
    {
        return layerValue(value, forKey: "cornerRadius")
    }
    
    @discardableResult public func shadowColor(_ value : CGColor) -> PDAnimatablePropertyMaker
    {
        return layerValue(value, forKey: "shadowColor")
    }
    
    @discardableResult public func shadowOffset(_ value : CGSize) -> PDAnimatablePropertyMaker
    {
        return layerValue(value, forKey: "shadowOffset")
    }
    
    @discardableResult public func shadowOpacity(_ value : CGFloat) -> PDAnimatablePropertyMaker
    {
        return layerValue(value, forKey: "shadowOpacity")
    }
    
    @discardableResult public func shadowRadius(_ value : CGFloat) -> PDAnimatablePropertyMaker
    {
        return layerValue(value, forKey: "shadowRadius")
    }
    
    @discardableResult public func transform3D(_ value : CATransform3D) -> PDAnimatablePropertyMaker
    {
        return layerValue(value, forKey: "transform3D")
    }
    
    @discardableResult public func zPosition(_ value : CGFloat) -> PDAnimatablePropertyMaker
    {
        return layerValue(value, forKey: "zPosition")
    }
}
