# Installation

### Manual Install

1. Clone the [Parade](https://github.com/HelloElephant/Parade.git) repository
2. Add the contents of ***/Parade/Sources/***


****
### CocoaPods

1. Edit the project's podfile, and save

```
pod 'Elephant-Parade', :git => 'https://github.com/HelloElephant/Parade.git', :tag => '1.0.0'
```
2. Install Parade by running

```
pod install
```
****
### Carthage

The installation instruction below for iOS and AppleTV

#### Installation

1. Create/Update the Cartfile with with the following

```

#Parade
git "https://github.com/HelloElephant/Parade.git" >= 1.0.0
```
2. Run `carthage update`. This will fetch dependencies into a [Carthage/Checkouts][] folder, then build each one.
3. In the application targets’ “General” settings tab, in the “Embedded Binaries” section, drag and drop each framework for use from the Carthage/Build folder on disk.
4. Follow the installation instruction above. Once complete, perform the following steps
(If you have setup a carthage build task for iOS already skip to Step 6)
5. Navigate to the targets’ “Build Phases” settings tab, click the “+” icon and choose “New Run Script Phase”. Create a Run Script with the following content:

```
/usr/local/bin/carthage copy-frameworks
```

6. Add the paths to the frameworks you want to use under “Input Files” within the carthage build phase as follows e.g.:

```
// iOS
$(SRCROOT)/Carthage/Build/iOS/Parade.framework

 or

// tvOS
$(SRCROOT)/Carthage/Build/tvOS/Parade.framework
```
