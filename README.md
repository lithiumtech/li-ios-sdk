# Lithium Community iOS SDK 

**The Lithium Community iOS SDK is currently in Open Beta**

The Lithium Community iOS SDK helps application developers integrate Lithium Community into iOS applications, providing support for browsing boards, posting and interacting with messages, managing attachments, sending push notifications, and authenticating users. The library includes API providers and custom API providers to interact with the Community API.

All native Lithium Community implementations using the Community iOS SDK must use the `li-ios-sdk-core` library. This library delivers the basic capabilities of authenticating and interacting with a community while adding support for third-party push notification providers.

The SDK also includes an optional Support UI library (See the `li-ios-sdk-ui` [package and readme](https://github.com/lithiumtech/li-ios-sdk-ui).)

The SDK supports Lithium Registration authentication, LithiumSSO, and custom SSO implementations.

| Package | Provides |
| ------- | -------- |
| li-ios-sdk-core	 | Authentication<br>API Providers<br>Custom API Providers<br>Push Notification Support (Firebase Cloud Messaging and Apple Push Notification Service) |

## Requirements
The Community iOS SDK requires:

* Access to a Lithium Community instance running version 17.12 or later
* A Community user account with the **Manage API Apps** permission grated
* Xcode version 8+
* iOS 9 and above 
* Swift version 3.1+ 
* Authorization credentials generated in **Community Admin > System > API Apps**

We recommend installing the SDK using [CocoaPods](https://cocoapods.org/) or [Carthage](https://github.com/Carthage/Carthage).

## Get Started
To get started with Community iOS SDK development, see the instructions in [Getting Started with the Community iOS SDK](https://github.com/lithiumtech/li-ios-sdk-core/wiki/Getting-Started-with-the-Community-iOS-SDK). The guide will take you through generating credentials, building your project, and app initialization.

**Note:** In order to create the best possible product and experience, we will continue to iterate on the SDK throughout the beta period. Features may change before the product is generally available. We will post updates and changes in the [Current Betas forum](https://community.lithium.com/t5/Current-Betas/bd-p/BetaCurrent).

## License
Except as otherwise noted, the Community iOS SDK is licensed under the Apache 2.0 License.

Copyright 2018 Lithium Technologies

## Example app
The [Lithium Community iOS SDK Example](https://github.com/lithiumtech/li-ios-sdk-example) is a basic implementation of the Community iOS SDK. The example application shows the fastest way to get a Lithium Community-backed application running quickly. 

## Getting help
Visit the [Developers Discussion forum](https://community.lithium.com/t5/Developer-Discussion/bd-p/studio) on the Lithium Community to ask questions and talk with other members of the Lithium Developer community. This is a great forum for asking questions about the Community API and Lithium platform. For Community iOS SDK-specific questions, write a post in our [Current Betas](https://community.lithium.com/t5/Current-Betas/bd-p/BetaCurrent) forum. 

## Next steps
* Review our [API reference documentation](https://github.com/lithiumtech/li-ios-sdk-core/wiki/Community-iOS-SDK-API-reference)
* Checkout out our [tutorials](https://github.com/lithiumtech/li-ios-sdk-core/wiki/Tutorials)
* Read about our [Support UI](https://github.com/lithiumtech/li-ios-sdk-ui/wiki/Community-iOS-SDK-UI-Overview)
* Learn about [authentication options](https://github.com/lithiumtech/li-ios-sdk-core/wiki/Authenticating-a-user)
* Walk through our [Getting Started guide](https://github.com/lithiumtech/li-ios-sdk-core/wiki/Getting-Started-with-the-Community-iOS-SDK)
