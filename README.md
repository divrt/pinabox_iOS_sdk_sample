# DIVRT Pinabox Gateway SDK for iOS
The divrt Pinabox is a system used to control entry and exit of vehicles into a parking lot using their mobile. It consists of hardware components such as the divrt pinabox gateway as well as software components that run on a mobile. The divrt Pinabox SDK for IOS is a software module that when integrated into an IOS application can interact with the divrt Pinabox gateway hardware.

[![CI Status](https://img.shields.io/travis/anvesh.t@divrt.co/PINABOX.svg?style=flat)](https://travis-ci.org/anvesh.t@divrt.co/PINABOX)
[![Version](https://img.shields.io/cocoapods/v/PINABOX.svg?style=flat)](https://cocoapods.org/pods/PINABOX)
[![Platform](https://img.shields.io/cocoapods/p/PINABOX.svg?style=flat)](https://cocoapods.org/pods/PINABOX)

# Features

1. Integration with a wide array of gate hardware
1. Works in tandem with divrt LPR system on any IP based LPR camera
1. Accurate lane detection to handle multi lane entries/exists seamlessly  
1. Simple software integration that gets your existing parking app **"Pinabox enabled"** within minutes


# Try the sample application
### PinaboxDemoApp 
In order to demonstrate the simplicity of integration and usage of the pinabox sdk, a sample app has been created. This app can be downloaded and tested using the following steps.
#### Download and Compile


1. Download the sample project repo [PinaboxDemoApp](https://github.com/divrt/pinabox_ios_sdk.git)
1. Open terminal window and navigate to project folder
1. Run `pod install`
1. Open `PinaboxDemoApp.xcworkspace` and run the project on selected device or simulator

#### Testing the SDK 
The SDK works in tandem with the pinabox gateway. Since the developer may not have the hardware handy, the SDK is built with a demo mode option. In order to activate the simulation mode, navigate to the viewcontroller.swift in the project just downloaded and uncomment the simulation mode as shown below.



```swift
var pinaConfig = PinaConfig()
pinaConfig.simulationMode = true    // <== UNCOMMENT THIS LINE
pinaConfig.gateType = .ENTRY //Incase of Exit gate make sure of the Enum to be .EXIT
```
1. Compile and run the sample app
2. In the demo mode, the gate open buttons would turn green in ~2 seconds. Click the button to open the gate in simulation mode.
3. The SDK would provide the results of the gate open operation by invoking the onSuccess call back method in the sample app.

# How do I integrate the SDK into my app 

## Installation of SDK

### Requirements
- iOS 11.0+ 
- Xcode 11+
- Swift 5.1+
- iOS device to install app

### Steps to integrate

#### Using CocoaPods
1. Contact divrt () to get access to the SDK
2. To install it, simply add the following line to your Podfile
```ruby 
pod 'DivrtPinabox' 
```
3. On terminal, navigate to your project folder and run the command below  
``` java
pod install 
```
NOTE: Please ensure that the latest version of sdk is installed (<<latest_version>>).

4. The SDK requires the following permissions that need to be enabled in the info.plist file. These permissions are described below, specific to your IOS version
* Location services
* Bluetooth
* NFC

##
### Requesting Permission to access Location Services
Pinabox requests location permission to access location services 

##### iOS 9 and above
* Starting with iOS 9, you **must** provide a description for how your app uses location services by setting a string for the key [`NSLocationWhenInUseUsageDescription`](https://developer.apple.com/library/ios/documentation/General/Reference/InfoPlistKeyReference/Articles/CocoaKeys.html#//apple_ref/doc/uid/TP40009251-SW26) or [`NSLocationAlwaysUsageDescription`](https://developer.apple.com/library/ios/documentation/General/Reference/InfoPlistKeyReference/Articles/CocoaKeys.html#//apple_ref/doc/uid/TP40009251-SW18) in your app's `Info.plist` file. Pinabox determines which level of permissions to request based on which description key is present. You should only request the minimum permission level that your app requires, therefore it is recommended that you use the "When In Use" level unless you require more access. If you provide values for both description keys, the more permissive "Always" level is requested.

##### iOS 11 Location Specific
* Starting with iOS 11, you **must** provide a description for how your app uses location services by setting a string for the key `NSLocationAlwaysAndWhenInUseUsageDescription` in your app's `Info.plist` file.

### Requesting Permission to access Bluetooth
##### iOS 13 Bluetooth Specific
* Starting with iOS 13, you **must** provide a description for how your app uses bluetooth services by setting a string for the key `NSBluetoothAlwaysUsageDescription` in your app's `Info.plist` file.

### Requesting Permission to access NFC
##### iOS NFC Specific

* Add `Near Field Communication Tag Reading` capabilty in your `Entitlements.plist`
```xml
<key>com.apple.developer.nfc.readersession.formats</key>
<array>
    <string>NDEF</string>
    <string>TAG</string>
</array>
```

* you **must** provide a description for how your app uses NFC services by setting a string for the key `NFCReaderUsageDescription` in your app's `Info.plist` file.

![alt Info.plist](https://github.com/divrt/pinabox_ios_sdk/blob/master/InfoPlist.png)

##
5. Next in your ViewController source, add the following lines to import the pinabox sdk 
```swift
import DivrtPinabox
```
6. When ready to open the gate, such as a button click event, initialize ``` PinaConfig ``` class object with appropriate configuration data and launch the SDK. the SDK will open in the form of a pop-up window 

```swift
let pinaConfig = PinaConfig()
pinaConfig.zoneID = 3
pinaConfig.gateType = .ENTRY
pinaConfig.infoText = "Welcome to ABC garage"

PinaSDK.shared.pinaInterface(viewController:self, pinaConfig: pinaConfig) 
```
For detailed information on all PinaConfig parameters, refer to XYZ section of DivrtPinabox-swift.h


7. Implement callback methods "onSuccess" and "onFailure" methods to handle success/failure of gate open event.
```swift

```

NOTE: You need iPhone 7 or above devices to use the NFC feature 

## Author

anvesh.t@divrt.co
 
