# Parade

[![Build Status](https://travis-ci.org/HelloElephant/Parade.svg?branch=master)](https://travis-ci.org/HelloElephant/Parade)
[![codecov.io](https://codecov.io/gh/HelloElephant/Parade/branch/master/graphs/badge.svg)](https://codecov.io/gh/HelloElephant/Parade/branch/master)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)]()
[![Cocoapods Compatible](https://img.shields.io/badge/pod-v1.0.0-blue.svg)]()
[![Platform](https://img.shields.io/badge/platform-ios%20%7C%20tvos-lightgrey.svg)]()
[![License](https://img.shields.io/badge/license-MIT-343434.svg)]()

# Introduction

Communicating to cells inside of UICollectionViews, UITableViews, or UIScrollViews, has always been a challenge. It almost always relies on a messy process of trying to relay the scroll to progress to cells in triggering special scrolling effects. We’ve designed this framework to minimize the effort needed to animate views. With a simple blocks-based builder we’ve made it easy to define view states—**from** where they appear and where they will disappear **to**.

<p align="center">
  <img align="center"  src="/Documentation/assets/03_state_changes_intro.png?raw=true"/>
  </p>

# Features

  - Supports UICollectionView, UITableView, UIScrollview
  - Simple Blocks-Based Syntax
  - Minimal Integration Requirements
  - Supports Chaining Animatable Views
  - Adjustable Progress Ranges
  - 46 Different Parametric Curves


# Interactive Demo

There is a demo app included as part of the project that contains the following implemented examples for the following scrolling effects within the animated gif below.

|  | Included Examples |
| ------------- | ------------- |
|![alt tag](/Documentation/assets/08_animated_demo.gif?raw=true)|The demo contains a single ``ParallaxImageViewController`` as the root, and displays these cells as examples in the following order:<br/><br/>- [``ParallaxIntroCollectionViewCell``](https://github.com/HelloElephant/Parade/blob/master/Parade-Demo/Parade-Demo/ParallaxCells/ParallaxIntroCollectionViewCell.swift#L87) : Scale / Transform / Alpha<br/><br/>- [``ParallaxScaleCollectionViewCell``](https://github.com/HelloElephant/Parade/blob/master/Parade-Demo/Parade-Demo/ParallaxCells/ParallaxScaleCollectionViewCell.swift#L62) : Scale / Center<br/><br/>- [``ParallaxDoubleImageCollectionViewCell``](https://github.com/HelloElephant/Parade/blob/master/Parade-Demo/Parade-Demo/ParallaxCells/ParallaxDoubleImageCollectionViewCell.swift#L98) : Center / Transform<br/><br/>- [``ParallaxImageAppearCollectionViewCell``](https://github.com/HelloElephant/Parade/blob/master/Parade-Demo/Parade-Demo/ParallaxCells/ParallaxImageAppearCollectionViewCell.swift#L115) : Animation Chain Parallax<br/><br/>- [``ParallaxImageCollectionViewCell``](https://github.com/HelloElephant/Parade/blob/master/Parade-Demo/Parade-Demo/ParallaxCells/ParallaxImageCollectionViewCell.swift#L61) : Scale / Alpha / Transform <br/><br/>- [``ParallaxTheEndCollectionViewCell``](https://github.com/HelloElephant/Parade/blob/master/Parade-Demo/Parade-Demo/ParallaxCells/ParallaxTheEndCollectionViewCell.swift#L81) : Transform 3D<br/><br/>Note: The examples also  contain custom ranges discussed later in the documentation.<br/>|

# Installation

* **Requirements** : XCode 9.0+, iOS 10.0+, tvOS 10.0+
* [Installation Instructions](/Documentation/installation.md)
* [Release Notes](/Documentation/release_notes.md)

# Communication

- If you **found a bug**, or **have a feature request**, open an issue.
- If you **want to contribute**, review the [Contribution Guidelines](/Documentation/CONTRIBUTING.md), and submit a pull request.
- If you **contribute**, please ensure that the there is **100%** code coverage

# Basic Use

At its core, this framework defines **start** and **end** states for your animatable views—with the scroll view interpolating between the states accordingly. The **start** state defines where views appear from as they scroll onto screen—while **end** state defines where views will disappear.

The only requirements beyond defining the states is to implement the PDAnimatableType on views to animate, the rest is seamless. Each animation consists of a **start** or **end** state which is defined by the developer—plus a **snapshot** state that is automatically configured the first time the view begins to scroll.

Before creating, consider the diagram below to get a sense of the coordinate space that the progress is calculated against. Progress is relative to the bounds of the scrollview itself. When scrolling horizontally—the difference in X value to the center point of the viewport is equal to the width of the scrollview itself. Just as the difference in Y value when scrolling vertically, as demonstrated below.


![alt tag](/Documentation/assets/02_all_ranges.png?raw=true)

**NOTE :** There is control to adjust these ranges, and instructions can be found in the *Bounding Progress Range* section below.

## Initialization

Initialize the Parade in ``application(:didFinishLaunchingWithOptions:)`` when the application is launched. Once initialized, the base UIScrollView will begin communicating scrolling progress to animatable views contained within.

```swift
UIScrollView.initializeParade()
```

## Create Animatable View

The first step is to make a view animatable by implement the ``PDAnimatableType`` protocol, and the scrollview will begin to communicate progress to it's subviews accordingly.

```swift
public protocol PDAnimatableType {

    // The progress animator definition that
    // interpolates over animatable properties
    func configuredAnimator() -> PDAnimator;
}
```

Any of the following views, and their subviews, can implement the ``PDAnimatableType`` and be animated:

- `UICollectionViewCell`
- `UITableViewCell`
- `UIScrollView`'s subviews

But before the scrollview can communicate the progress, define an animator with the relative scroll direction that the scrollview will be tracking against. Bundled with the framework is recursive blocks based builder, that allows for simple creation of complex animations to interpolate against while scrolling.

#### Vertical Direction Scroll Animator

The following is an example to create a vertical animator for scrolling vertically. The closure returns an animator that can be used to create from, and to, state for any specific view within the hierarchy.

```swift
func configuredAnimator() -> PDAnimator {

   /* Create a vertical tracking animator call this class method */
   return PDAnimator.newVerticalAnimator { (animator) in

   }
}
```
#### Horizontal Direction Scroll Animator

The following is an example to create a horizontal animator for scrolling horizontally. The closure returns an animator that can be used to create from, and to, state for any specific view within the hierarchy.

```swift
func configuredAnimator() -> PDAnimator {

   /* Create a horizontal tracking animator with this class method */
   return PDAnimator.newHorizontalAnimator { (animator) in

   }
}
```

The closure returns an animator that can be used to create from, and to, states for a specific view accordingly.

## Configuring Animation States

#### Configure End State

To have a view fade in relative to the scrolling progress, define a start state by calling the `startState(for:)` method as follows. Each time a state is added, it returns a state maker that can be used to append multiple properties to interpolate over.

```swift
func configuredAnimator() -> PDAnimator {

    let offScreenAlpha : CGFloat = 0.0

    return PDAnimator.newVerticalAnimator { (animator) in

        animator.startState(for: animatedImageView, { (s) in
          s.alpha(offScreenAlpha)
        })
     }
}
```
#### Configure End State

Building on the last example, to have a view fade out relative to the scrolling progress off the screen, define an end state by calling the `endState(for:)` method as follows.

```swift
func configuredAnimator() -> PDAnimator {

    let offScreenAlpha : CGFloat = 0.0

    return PDAnimator.newVerticalAnimator { (animator) in

        animator.startState(for: animatedImageView, { (s) in
          s.alpha(offScreenAlpha)
        }).endState(for: animatedImageView, { (s) in
          s.alpha(offScreenAlpha)
        })
     }
}
```

#### Configure Start & End State

Building on the prior example, it appears that the appearing and disappearing alpha is the same. In the case both **start**, and **end** state values are the same, use the `startEndState(for:)` method to set the value for both states simultaneously.

```swift
func configuredAnimator() -> PDAnimator {

    let offScreenAlpha : CGFloat = 0.0

    return PDAnimator.newVerticalAnimator { (animator) in

        animator.startEndState(for: animatedImageView, { (s) in
          s.alpha(offScreenAlpha)
        })
     }
}
```

#### Start & End State for Multiple Views

In the case there are multiple views that need to perform the same animation, helper methods have been defined for creating animations for an array of views too. The following is an example of how these can be used.

```swift
func configuredAnimator() -> PDAnimator {

    var animatedViews = [view1, view2, view3, view4]

    let offScreenAlpha : CGFloat = 0.0

    return PDAnimator.newVerticalAnimator { (animator) in

        animator.startEndState(forViews: animatedViews, { (s) in
          s.alpha(offScreenAlpha)
        })
     }
}
```

The following can also be used with multiple views.

```swift
func startState(forViews views:  [UIView], _ callback : ... )    -> PDAnimationMaker
func endState(forViews views:  [UIView], _ callback : ... )      -> PDAnimationMaker
func startEndState(forViews views:  [UIView], _ callback : ... ) -> PDAnimationMaker
```

#### State Properties

The framework provides quite a few helpers to define state properties for views, and/or, their backing layer with ease.

```swift   
/* View Property Setters */

public func alpha(_ value : CGFloat)               -> PDAnimatablePropertyMaker
public func backgroundColor(_ value : UIColor)     -> PDAnimatablePropertyMaker
public func bounds(_ value : CGSize)               -> PDAnimatablePropertyMaker
public func center(_ value : CGPoint)              -> PDAnimatablePropertyMaker
public func size(_ value : CGSize)                 -> PDAnimatablePropertyMaker
public func transform(_ value : CGAffineTransform) -> PDAnimatablePropertyMaker

/* Layer Property Setters */

public func borderColor(_ value : UIColor)         -> PDAnimatablePropertyMaker
public func borderWidth(_ value : CGFloat)         -> PDAnimatablePropertyMaker
public func contentsRect(_ value : CGRect)         -> PDAnimatablePropertyMaker
public func cornerRadius(_ value : CGFloat)        -> PDAnimatablePropertyMaker
public func shadowColor(_ value : UIColor)         -> PDAnimatablePropertyMaker
public func shadowOffset(_ value : CGSize)         -> PDAnimatablePropertyMaker
public func shadowOpacity(_ value : CGFloat)       -> PDAnimatablePropertyMaker
public func shadowRadius(_ value : CGFloat)        -> PDAnimatablePropertyMaker
public func transform3D(_ value : CATransform3D)   -> PDAnimatablePropertyMaker
public func zPosition(_ value : CGFloat)           -> PDAnimatablePropertyMaker
```

In the case a setter is not defined, and there is a need to set a specific property to interpolate between, there are two defined setters that use KVC for views, and/or, their backing layer accordingly.

```swift
public func viewValue(_ value : Any?, forKey key : String)    -> PDAnimatablePropertyMaker
public func layerValue(_ value : Any?, forKey key : String)   -> PDAnimatablePropertyMaker
```
#### Parametric Easing

There are 46 different parametric curves that can be applied to the interpolation of uniquely per property. The framework comes bundled with the following supported parametric curves that can be applied to each property individually.

<table>
  <tbody>
    <tr>
      	<td>
       		 .inSine<br>
       		 .inOutSine<br>
       		 .outSine<br>
       		 .outInSine</td>
      	<td>
       		 .inQuadratic<br>
       		 .inOutQuadratic<br>
       		 .outQuadratic<br>
      		 .outInQuadratic</td>
   	  	<td>
   	  		 .inCubic<br>
   	  		 .inOutCubic<br>
   	  		 .outCubic<br>
   	  		 .outInCubic</td>
        <td>
      		 .inQuartic<br>
      		 .inOutQuartic<br>
      		 .outQuartic<br>
      		 .outInQuartic</td>
       <td>
      		 .inQuintic <br>
      		 .inOutQuintic<br>
      		 .outQuintic<br>
      		 .outInQuintic</td>
       <td>
         .inAtan<br>
    		 .inOutAtan<br>
         .outAtan<br>*</td>
    </tr>
    <tr>    	
      	<td>
    		   .inExponential<br>
     		   .inOutExponential<br>
    		   .outExponential<br>
    		   .outInExponential</td>
       <td>
      		 .inCircular <br>
      		 .inOutCircular<br>
      		 .outCircular<br>
      		 .outInCircular</td>
    	<td>
    		 .inBack <br>
    		 .inOutBack<br>
    		 .outBack<br>
    		 .outInBack</td>
       <td>
    		 .inElastic <br>
    		 .inOutElastic<br>
    		 .outElastic<br>
    		 .outInElastic </td>
       <td>
     		 .inBounce<br>
     		 .inOutBounce<br>
      	 .outBounce<br>
      	 .outInBounce</td>
      <td>
      	 .linear<br>
      	 .smoothStep<br>
      	 .smootherStep<br>*</td>
    </tr>
  </tbody>
</table>

Just append it to the state's property definition while building the view's state. A good reference for some of the supported parametric curves can be found [here](http://easings.net/)

```swift
func configuredAnimator() -> PDAnimator {

    let offScreenAlpha : CGFloat = 0.0
    let offScreenTransform = CGAffineTransform.identity.scaledBy(x: 0.5, y: 0.5)

    return PDAnimator.newVerticalAnimator { (animator) in

        animator.startEndState(for: animatedImageView, { (s) in
          s.alpha(offScreenAlpha).easing.(.inSine)
          s.transform(offScreenTransform).easing(.inOutCubic)
        })
     }
}
```
## Advanced View Animations

#### Chaining Animations

Animation progress does not have to apply only to the top level view that is being scrolled. If a subview implements the ``PDAnimatableType``, and is part of the subview hierarchy, attaching it to the animator can create a chain.

The animator will then communicate the progress to the subview's animator, subviews can be attached to subviews, or even have the subviews attach to their subviews, to create chains that can traverse multiple levels in the end to make some fun effects. To attach an animatable view, call the `attachAnimatableView(:)` method as follows.

```swift
func configuredAnimator() -> PDAnimator {

    let offScreenAlpha : CGFloat = 0.0
    let offScreenTransform = CGAffineTransform.identity.translatedBy(x: 0.0, y: 100.0)

    return PDAnimator.newVerticalAnimator { (animator) in

        animator.startEndState(for: animatedImageView, { (s) in
          s.transform(offScreenTransform).easing(.inOutCubic)
        }).attachAnimatableView(animatedImageView)
     }
}
```

#### Bounding Progress Range

There is sometimes a need to adjust where the progress actually takes place. This is especially useful when animatable view is smaller than the bounding size of the scrollview. Observe the examples of the ranges defined, and how it effects the progress. By defining a range, this is basically telling the scrollview where the progress counts from 0 to 100.

![alt tag](/Documentation/assets/03_range_progress.png?raw=true)

Ranges can be defined on a per property basis just like easing – thus allowing for different properties interpolating over different coordinate spaces. The following example defines two different ranges for each property, and can visually be referenced above as to where the interpolation will take place.


```swift
func configuredAnimator() -> PDAnimator {

    let offScreenAlpha : CGFloat = 0.0
    let offScreenTransform = CGAffineTransform.identity.translatedBy(x: 0.0, y: 100.0)

    return PDAnimator.newVerticalAnimator { (animator) in

        animator.startState(for: animatedImageView, { (s) in
          s.transform(offScreenTransform).easing(.inOutCubic).range(0.5...1.0)
          s.alpha(offScreenTransform).easing(.inOutCubic).range(0.25...0.75)
        })
     }
}
```

## License

*Parade is released under the MIT license. See [License](https://github.com/HelloElephant/Parade/blob/master/LICENSE) for details.*
