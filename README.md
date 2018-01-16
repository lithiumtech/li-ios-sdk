# Lithium Community iOS SDK 

The Lithium Community iOS SDK helps application developers integrate Lithium Community into iOS applications, providing support for browsing boards, posting and interacting with messages, managing attachments, sending push notifications, and authenticating users. The library includes API providers and custom API providers to interact with the Community API.

All native Lithium Community implementations using the Community iOS SDK must use the li-ios-sdk-core library. This library delivers the basic capabilities of authenticating and interacting with a community while adding support for third-party push notification providers.

The SDK also includes an optional Support UI library. (See the li-ios-sdk-ui package and Readme.)

The SDK supports Lithium Registration authentication, LithiumSSO, and custom SSO implementations.

| Package | Provides |
| ------- | -------- |
| li-android-sdk-core	 | Authentication<br>API Providers<br>Custom API Providers<br>Push Notification Support (Firebase Cloud Messaging and Apple Push Notification Service) |

## Requirements
The Community iOS SDK requires:

* Access to a Lithium Community instance running version 17.12 or later
* A Community user account with the Manage API Apps permission grated
* Xcode version 8+
* iOS 9 and above 
* Swift version 3.1+ 
* Authorization credentials: App Key and Secret (generated in Community Admin > System > API Apps)

We recommend installing the SDK using CocoaPods or Carthage.

## Get Started
To get started with Community iOS SDK development, see the instructions in Getting Started with the Community iOS SDK. The guide will take you through generating credentials, building your project, and app initialization.

## License
Except as otherwise noted, the Community iOS SDK and the Lithium Community Reference app are licensed under the Apache 2.0 License.

Copyright 2018 Lithium Technologies

## Example app
The Lithium Community iOS SDK Example is a basic implementation of the Community iOS SDK. The reference application shows the fastest way to get a Lithium Community backed application running quickly. 

## Getting help
Visit the Developers Discussion forum on the Lithium Community to ask questions and talk with other members of the Lithium Developer community.

## Next steps
* Review our providers and models documentation
* Run through our tutorials
* Read about our Support UI components
* Learn about authentication options
* Create your app key and secret credentials
