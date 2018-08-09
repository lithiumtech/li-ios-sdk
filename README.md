**The Lithium Community iOS SDK is currently in open beta**

The Lithium Community iOS SDK helps application developers integrate Lithium Community into iOS applications. The SDK provides support for browsing boards, posting and interacting with messages, managing attachments, sending push notifications, and authenticating users. The library includes APIs to interact with Community's APIs.
This guide provides information about:

* [Community iOS SDK modules](#community-ios-sdk-modules)
* [Compatibility](#compatibility)
* [License](#license)
* [Example app](#example-app)
* [Documentation and resources](#documentation-and-resources)

For advanced integration scenarios, you can use the SDK to interact with the [Community API v2](https://community.lithium.com/t5/Developer-Documentation/bd-p/dev-doc-portal?section=commv2&v2.main=gettingstarted).

The Lithium Community iOS SDK supports Lithium Registration, LithiumSSO, and custom SSO authentication implementations. See the [Community Authentication guides](https://community.lithium.com/t5/Developer-Documentation/bd-p/dev-doc-portal?section=authoverview#apiAuth) on our Developer Documentation Portal for information about authentication options.

## Community iOS SDK modules

The Community iOS SDK includes core, UI, and demo modules to support your Community integrations.


| Module | Description |
|---------|--------------|
| LiCore | This is the module that all native Lithium Community implementations will use. This library delivers the basic capabilities of authenticating and interacting with a community while adding support for third-party push notification providers. For advanced and/or custom integrations, you can use the SDK to interact with a Lithium community using the [Community API v1](https://community.lithium.com/t5/Developer-Documentation/bd-p/dev-doc-portal?section=commv1) & [Community API v2](https://community.lithium.com/t5/Developer-Documentation/bd-p/dev-doc-portal?section=commv2).<br>**Features**<br><ul><li>Authentication</li><li>Inialization</li><li>API Providers</li><li>Custom API Providers</li><li>Push Notification Support (Firebase GCM)</li></ul> |
| LiComponents (optional)  | This is an optional UI module that provides a general support experience with self-service components helping users post messages, search for solutions and content, and browse your community. This package provides the fastest path to using Lithium Community within your Android application. This UI provides customer support-focused components, including browse-based navigation, keyword search, message posting, and message lists (both board-level and subscription-based) for Forum and Blog discussion styles.<br>**Features**<br><ul><li>User and Subscriptions activities</li><li>Message List activity</li><li>Browse Navigation activity</li><li>Message View activity</li><li>Message Post activity</li><li>Keyword Search and Search Results activity</li><li>UI Component fragments</li></ul> |
| LithiumExample | This module is a sample application to test drive the Community iOS SDKs capabilities. |

**Note:** In order to create the best possible product and experience, we will continue to iterate on the SDK throughout the beta period. Features may change before the product is generally available. We will post updates and changes in the [Current Betas forum](https://community.lithium.com/t5/Current-Betas/bd-p/BetaCurrent).

The SDK is written in Swift and is designed to bring Lithium Community functionality to your iOS applications. How you use these modules will depend on the goals of your application.

The Lithium Community iOS SDK also supports Lithium Registration, LithiumSSO, and custom SSO [authentication](Authenticating-a-user) implementations. See the Community [Authentication guides](https://community.lithium.com/t5/Developer-Documentation/bd-p/dev-doc-portal?section=authoverview) on our Developer Documentation Portal for information about authentication options.


## Compatibility
The Community iOS SDK packages are compatible with iOS 9 and above.

We recommend installing the SDK using [CocoaPods](https://cocoapods.org/) or [Carthage](https://github.com/Carthage/Carthage).

## License
Except as otherwise noted, the Community iOS SDK is licensed under the Apache 2.0 License.

Copyright 2018 Lithium Technologies

## Documentation and resources

* [Getting Started](Getting-Started) - provides a quick start guide
* [API reference](API-Reference) - provides reference material for the API, utility methods, and examples for using, customizing, and creating your own APIs
* [Initializing the SDK](Initializing-the-SDK) - provides initialization examples
* [Authenticating a user](Authenticating-a-user) - describes the authentication options supported by the SDK
* [Setting up push notifications](Setting-up-push-notifications) - provides instructions for setting up push notifications for your Community integration
* [Tutorials](Tutorials) - provides tutorials on working with the API providers
