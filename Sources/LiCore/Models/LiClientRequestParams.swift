// Copyright 2018 Lithium Technologies 
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
import UIKit
public protocol LiClientRequestParams {}
/// Model used to create liMessagesByBoardIdClient request parameters.
public struct LiMessagesByBoardIdClientRequestParams: LiClientRequestParams {
    var boardId: String
    /// Creates LiMessagesByBoardIdClientRequestParams object to pass onto liMessagesByBoardIdClient.
    /// - parameter boardId: Board id of the board for which the messages are being requested.
    public init(boardId: String) throws {
        self.boardId = try LiUtils.nonEmptyStringCheck(value: boardId, errorMessage: "boardId should not be an empty string")
    }
}
/// Model used to create liSdkSettingsClient request parameters.
public struct LiSdkSettingsClientRequestParams: LiClientRequestParams {
    var clientId: String
    /// Creates LiSdkSettingsClientRequestParams object to pass onto liSdkSettingsClient.
    /// - parameter clientId: the client ID for the app generated in Community Admin > System > API Apps.
    public init(clientId: String) throws {
        self.clientId =  try LiUtils.nonEmptyStringCheck(value: clientId, errorMessage: "clientId should not be an empty string")
    }
}
/// Model used to create liCategoryBoardsClient request parameters.
public struct LiCategoryBoardsClientRequestParams: LiClientRequestParams {
    var categoryId: String
    /// Creates LiCategoryBoardsClientRequestParams object to pass onto liCategoryBoardsClient.
    /// - parameter categoryId: the ID of the category from which to fetch a board list.
    public init(categoryId: String) throws {
        self.categoryId = try LiUtils.nonEmptyStringCheck(value: categoryId, errorMessage: "categoryId should not be an empty string")
    }
}
/// Model used to create liBoardsByDepthClient request parameters.
public struct LiBoardsByDepthClientRequestParams: LiClientRequestParams {
    var depth: Int
    /// Creates LiBoardsByDepthClientRequestParams object to pass onto liBoardsByDepthClient.
    /// - parameter depth: the depth from which to pull boards from the Community structure.
    public init(depth: Int) throws {
        self.depth = try LiUtils.positiveIntegerCheck(value: depth, errorMessage: "depth should not be a negative number")
    }
}
/// Model used to create liRepliesClient request parameters.
public struct LiRepliesClientRequestParams: LiClientRequestParams {
    var parentId: String
    /// Creates LiRepliesClientRequestParams object to pass onto liRepliesClient2.
    /// - parameter parentId: the ID of the parent message.
    public init(parentId: String) throws {
        self.parentId = try LiUtils.nonEmptyStringCheck(value: parentId, errorMessage: "parentId should not be an empty string")
    }
}
/// Model used to create liSearchClient request parameters.
public struct LiSearchClientRequestParams: LiClientRequestParams {
    var query: String
    /// Creates LiSearchClientRequestParams object to pass onto liSearchClient.
    /// - parameter query: the search string to query. The query is compared against the body and subject of messages.
    public init(query: String) throws {
        self.query = try LiUtils.nonEmptyStringCheck(value: query, errorMessage: "query should not be an empty string")
    }
}
/// Model used to create liUserMessagesClient request parameters.
public struct LiUserMessagesClientRequestParams: LiClientRequestParams {
    var authorId: String
    var depth: String
    /// Creates LiUserMessagesClientRequestParams object to pass onto liUserMessagesClient.
    /// - parameter authorId: id of the author whose message are requested.
    /// - parameter depth: the location of messages in a thread, where 0 equals a topic message, 1 is a first-level reply or comment, and so on.
    //For now a query with conversation.last_post_time must also set depth = 0 (only root messages)
    public init(authorId: String, depth: Int) throws {
        self.authorId = try LiUtils.nonEmptyStringCheck(value: authorId, errorMessage: "authorId should not be an empty string")
        let intDepth = try LiUtils.positiveIntegerCheck(value: depth, errorMessage: "depth should not be a negative number")
        self.depth = "\(intDepth)"
    }
}
/// Model used to create liUserDetailsClient request parameters.
public struct LiUserDetailsClientRequestParams: LiClientRequestParams {
    var userId: String
    /// Creates LiUserDetailsClientRequestParams object to pass onto liUserDetailsClient.
    /// - parameter userId: the ID of the user for which to fetch details.
    public init(userId: String) throws {
        self.userId = try LiUtils.nonEmptyStringCheck(value: userId, errorMessage: "userId should not be an empty string")
    }
}
/// Model used to create liMessageClient request parameters.
public struct LiMessageClientRequestParams: LiClientRequestParams {
    var messageId: String
    /// Creates LiMessageClientRequestParams object to pass onto liMessageClient.
    /// - parameter messageId: the ID of the message to retrieve.
    public init(messageId: String) throws {
        self.messageId = try LiUtils.nonEmptyStringCheck(value: messageId, errorMessage: "messageId should not be an empty string")
    }
}
/// Model used to create liFloatedMessagesClient request parameters.
public struct LiFloatedMessagesClientRequestParams: LiClientRequestParams {
    var boardId: String
    var scope: String
    /// Creates LiFloatedMessagesClientRequestParams object to pass onto liFloatedMessagesClient.
    /// - parameter boardId:  the ID of the board from which to pull floated (or 'pinned') messages
    /// - parameter scope: the scope of floated messages to retreive. Supported value is 'local'. Local scope retrieves messages that the user in context floated/pinned, rather than an administrator who might have pinned a message to the top of a board globally for the community.
    @available(*, deprecated: 0.2.0)
    public init(boardId: String, scope: String) throws {
        self.boardId = try LiUtils.nonEmptyStringCheck(value: boardId, errorMessage: "boardId should not be an empty string")
        self.scope =  try LiUtils.nonEmptyStringCheck(value: scope, errorMessage: "scope should not be an empty string")
    }
    /// Creates LiFloatedMessagesClientRequestParams object to pass onto liFloatedMessagesClient.
    /// - parameter boardId:  the ID of the board from which to pull floated (or 'pinned') messages
    /// - parameter scope: the scope of floated messages to retreive. Supported value is 'local'. Local scope retrieves messages that the user in context floated/pinned, rather than an administrator who might have pinned a message to the top of a board globally for the community.
    public init(boardId: String, scope: Scope ) throws {
        self.boardId =  try LiUtils.nonEmptyStringCheck(value: boardId, errorMessage: "boardId should not be an empty string")
        self.scope = Scope.local.rawValue
    }
    public enum Scope: String {
        case local
    }
}
/// Model used to create liMessagesByIdsClient request parameters.
public struct LiMessagesByIdsClientRequestParams: LiClientRequestParams {
    var messageIds: [String]
    /// Creates LiMessagesByIdsClientRequestParams object to pass onto liMessagesByIdsClient.
    /// - parameter messageIds:  the IDs of the messages to retrieve, passed as a array of strings.
    public init(messageIds: [String]) throws {
        self.messageIds = try LiUtils.nonEmptyArrayCheck(value: messageIds, errorMessage: "messageIds should not be a empty array or contain an empty string as an element")
    }
}
/// Model used to create liKudoClient request parameters.
public struct LiKudoClientRequestParams: LiClientRequestParams {
    public var messageId: String
    /// Creates LiKudoClientRequestParams object to pass onto liKudoClient.
    /// - parameter messageId: the ID of the message to kudo.
    public init(messageId: String) throws {
        self.messageId = try LiUtils.nonEmptyStringCheck(value: messageId, errorMessage: "messageId should not be an empty string")
    }
    public func getPostParams() -> [String: Any] {
        let params: [String: Any] = ["type": LiQueryConstant.ResponseType.liKudoType, "message": ["id": messageId]]
        return params
    }
}
/// Model used to create liUnKudoClient request parameters.
public struct LiUnKudoClientRequestParams: LiClientRequestParams {
    public var messageId: String
    /// Creates LiUnKudoClientRequestParams object to pass onto liUnKudoClient.
    /// - parameter messageId: id of the message to unkudo.
    public init(messageId: String) throws{
        self.messageId = try LiUtils.nonEmptyStringCheck(value: messageId, errorMessage: "messageId should not be an empty string")
    }
}
/// Model used to create liMessageDeleteClient request parameters.
public struct LiMessageDeleteClientRequestParams: LiClientRequestParams {
    var messageId: String
    var includeReplies: Bool
    /// Creates LiMessageDeleteClientRequestParams object to pass onto liMessageDeleteClient.
    /// - parameter messageId: the ID of the message to delete
    /// - parameter includeReplies: whether or not to delete replies/comments to the message
    public init(messageId: String, includeReplies: Bool) throws {
        self.messageId = try LiUtils.nonEmptyStringCheck(value: messageId, errorMessage: "messageId should not be an empty string")
        self.includeReplies = includeReplies
    }
    func getPostParams() -> [String: String] {
        if includeReplies {
            return ["delete_message.include_replies": "true"]
        }
        return [:]
    }
}
/// Model used to create liAcceptSolutionClient request parameters.
public struct LiAcceptSolutionClientRequestParams: LiClientRequestParams {
    public var messageId: String
    /// Creates LiAcceptSolutionClientRequestParams object to pass onto liAcceptSolutionClient.
    /// - parameter messageId: the ID of the message to accept as a solution.
    public init(messageId: String) throws {
        self.messageId = try LiUtils.nonEmptyStringCheck(value: messageId, errorMessage: "messageId should not be an empty string")
    }
    public func getPostParams() -> [String: Any] {
        let params: [String: Any] = ["type": LiQueryConstant.ResponseType.liAcceptSolutionType, "message_id": messageId]
        return params
    }
}
/// Model used to create liCreateMessageClient request parameters.
public struct LiCreateMessageClientRequestParams: LiClientRequestParams {
    var subject: String
    var body: String?
    var boardId: String
    var imageId: String?
    var imageName: String?
    /// Creates LiCreateMessageClientRequestParams object to pass onto liCreateMessageClient.
    /// - parameter subject: the subject of the message.
    /// - parameter body: (optional) the body of the message.
    /// - parameter boardId: board Id of the board in which the message is posted to.
    /// - parameter imageId: (optional) the ID of the image included with the message, if one exists.
    /// - parameter imageName: (optional) the filename of the image included with the message, if one exists.
    public init(subject: String, body: String?, boardId: String, imageId: String?, imageName: String?) throws {
        self.subject = try LiUtils.nonEmptyStringCheck(value: subject, errorMessage: "subject should not be an empty string")
        self.body = body
        self.boardId =  try LiUtils.nonEmptyStringCheck(value: boardId, errorMessage: "boardId should not be an empty string")
        self.imageId = try LiUtils.nonEmptyStringCheck(value: imageId, errorMessage: "imageId should not be an empty string")
        self.imageName = try LiUtils.nonEmptyStringCheck(value: imageName, errorMessage: "imageName should not be an empty string")
    }
    /// Returns POST parameters for liCreateMessageClient client.
    /// - returns: [String: Any] containing post parameters
    public func getPostParams() -> [String: Any] {
        var embeddedBody: String = body ?? ""
        if let imageId = imageId, let imageName = imageName {
            embeddedBody = embedImageTag(body: embeddedBody, imageId: imageId, imageName: imageName)
        }
        let params: [String: Any] = ["type": LiQueryConstant.ResponseType.liMessageClientType, "body": embeddedBody, "subject": subject, "board": ["id": boardId]]
        return params
    }
}
/// Model used to create liUpdateMessageClient request parameters.
public struct LiUpdateMessageClientRequestParams: LiClientRequestParams {
    var messageId: String
    var subject: String
    var body: String?
    var imageId: String?
    var imageName: String?
    /// Creates LiUpdateMessageClientRequestParams object to pass onto liUpdateMessageClient.
    /// - parameter messageId: the ID of the message to update.
    /// - parameter subject: the subject of the message.
    /// - parameter body: (optional) the body of the message.
    /// - parameter imageId: (optional) the ID of the image included with the message, if one exists.
    /// - parameter imageName: (optional) the filename of the image included with the message, if one exists.
    public init(messageId: String, subject: String, body: String?, imageId: String?, imageName: String?) throws {
        self.messageId = try LiUtils.nonEmptyStringCheck(value: messageId, errorMessage: "messageId should not be an empty string")
        self.subject = try LiUtils.nonEmptyStringCheck(value: subject, errorMessage: "subject should not be an empty string")
        self.body = body
        self.imageId = try LiUtils.nonEmptyStringCheck(value: imageId, errorMessage: "imageId should not be an empty string")
        self.imageName = try LiUtils.nonEmptyStringCheck(value: imageName, errorMessage: "imageName should not be an empty string")
    }
    public func getPostParams() -> [String: Any] {
        var embeddedBody: String = body ?? ""
        if let imageId = imageId, let imageName = imageName {
            embeddedBody = embedImageTag(body: embeddedBody, imageId: imageId, imageName: imageName)
        }
        let params: [String: Any] = ["type": LiQueryConstant.ResponseType.liMessageClientType, "body": embeddedBody, "subject": subject]
        return params
    }
}
/// Embeds an image tag into the message body.
/// - parameter body: Text of the comment to embed the image in.
/// - parameter imageId: ID of the image.
/// - parameter imageName: Name of the image file that was uploaded.
/// - returns: String containg the macro embeded with the image id.
private func embedImageTag(body: String, imageId: String, imageName: String) -> String {
    var newBody = body
    if newBody == "" {
        newBody = "<p>&nbsp;</p>"
    }
    newBody += "\n" + String(format: LiQueryConstant.liInsertImageMacro, arguments: [imageId, imageName])
    return newBody
}
/// Model used to create liCreateReplyClient request parameters.
public struct LiCreateReplyClientRequestParams: LiClientRequestParams {
    var body: String
    var messageId: String
    var subject: String
    var imageId: String?
    var imageName: String?
    /// Creates LiCreateReplyClientRequestParams object to pass onto liCreateReplyClient.
    /// - parameter body: the body of the reply/comment.
    /// - parameter messageId: Message id of the original message.
    /// - parameter subject: the subject of the message.
    /// - parameter imageId: (optional) the ID of the image included with the reply/comment, if one exists.
    /// - parameter imageName: (optional) the filename of the image included with the reply/comment, if one exists.
    public init(body: String, messageId: String, subject: String, imageId: String?, imageName: String?) throws {
        self.body = try LiUtils.nonEmptyStringCheck(value: body, errorMessage: "body should not be an empty string")
        self.messageId = try LiUtils.nonEmptyStringCheck(value: messageId, errorMessage: "messageId should not be an empty string")
        self.subject = try LiUtils.nonEmptyStringCheck(value: subject, errorMessage: "subject should not be an empty string")
        self.imageId = try LiUtils.nonEmptyStringCheck(value: imageId, errorMessage: "imageId should not be an empty string")
        self.imageName = try LiUtils.nonEmptyStringCheck(value: imageName, errorMessage: "imageName should not be an empty string")
    }
    /// Returns POST parameters for liCreateReplyClient client.
    /// - returns: [String: Any] containing post parameters
    public func getPostParams() -> [String: Any] {
        var embeddedBody = body
        if let imageId = imageId, let imageName = imageName {
            embeddedBody = embedImageTag(body: embeddedBody, imageId: imageId, imageName: imageName)
        }
        let params: [String: Any] = ["type": LiQueryConstant.ResponseType.liMessageClientType, "body": embeddedBody, "parent": ["id": messageId], "subject": subject]
        return params
    }
}
/// Model used to create liUploadImageClient request parameters.
public struct LiUploadImageClientRequestParams: LiClientRequestParams {
    var title: String
    var description: String
    var imageName: String
    var image: Data
    ///Creates LiUploadImageClientRequestParams object to pass onto liUploadImageClient.
    /// - parameter title: the title of the image
    /// - parameter description: description of the image.
    /// - parameter imageName: the filename of the image.
    /// - parameter image: UIImage to be uploaded.
    public init(title: String, description: String, imageName: String, image: UIImage) throws {
        guard let imageData = image.jpeg() else {
            throw LiError.invalidArgument(errorMessage: "Failed to compress image")
        }
        self.title = try LiUtils.nonEmptyStringCheck(value: title, errorMessage: "title should not be an empty string")
        self.description = try LiUtils.nonEmptyStringCheck(value: description, errorMessage: "description should not be an empty string")
        self.image = imageData
        _ = try LiUtils.nonEmptyStringCheck(value: imageName, errorMessage: "imageName should not be an empty string")
        if !imageName.hasImageExtension(){
            self.imageName = imageName + ".jpg"
        } else {
            self.imageName = imageName
        }
    }
}
/// Model used to create liReportAbuseClient request parameters.
public struct LiReportAbuseClientRequestParams: LiClientRequestParams {
    var messageId: String
    var userId: String
    var body: String
    /// Creates LiReportAbuseClientRequestParams object to pass onto liReportAbuseClient.
    /// - parameter messageId: Id of the message to report.
    /// - parameter userId: Id of the user reporting the message.
    /// - parameter body: body of the messsage.
    public init(messageId: String, userId: String, body: String) throws {
        self.messageId = try LiUtils.nonEmptyStringCheck(value: messageId, errorMessage: "messageId should not be an empty string")
        self.userId = try LiUtils.nonEmptyStringCheck(value: userId, errorMessage: "userId should not be an empty string")
        self.body = try LiUtils.nonEmptyStringCheck(value: body, errorMessage: "body should not be an empty string")
    }
    /// Returns POST parameters for liCreateReplyClient client.
    /// - returns: [String: Any] containing post parameters
    public func getPostParams() -> [String: Any] {
        let params: [String: Any] = ["type": "abuse_report", "reporter": ["id": userId], "message": ["id": messageId], "body": body]
        return params
    }
}
/// Model used to create liDeviceIdFetchClient request parameters.
public struct LiDeviceIdFetchClientRequestParams: LiClientRequestParams {
    var deviceId: String
    var pushNotificationProvider: String
    /// Creates LiDeviceIdFetchClientRequestParams object to pass onto liDeviceIdFetchClient.
    /// - parameter deviceId: the device ID registered with the push notificaiton provider.
    /// - parameter pushNotificationProvider: the Global provider for push notification. Support values: "APNS" and "FIREBASE".
    @available(*, deprecated: 0.2.0)
    public init(deviceId: String, pushNotificationProvider: String) throws {
        self.deviceId = try LiUtils.nonEmptyStringCheck(value: deviceId, errorMessage: "deviceId should not be an empty string")
        self.pushNotificationProvider = try LiUtils.nonEmptyStringCheck(value: pushNotificationProvider, errorMessage: "pushNotificationProvider should not be an empty string")
    }
    /// Creates LiDeviceIdFetchClientRequestParams object to pass onto liDeviceIdFetchClient.
    /// - parameter deviceId: the device ID registered with the push notificaiton provider.
    /// - parameter pushNotificationProvider: the Global provider for push notification.
    public init(deviceId: String, pushNotificationProvider: NotificationProviders) throws {
        self.deviceId = try LiUtils.nonEmptyStringCheck(value: deviceId, errorMessage: "deviceId should not be an empty string")
        self.pushNotificationProvider = pushNotificationProvider.rawValue
    }
    public func getPostParams() -> [String: Any] {
        let params: [String: Any] = ["type": LiQueryConstant.ResponseType.liUserDeviceIdFetchType, "device_id": deviceId, "client_id": LiSDKManager.shared().appCredentials.clientId, "push_notification_provider": pushNotificationProvider, "application_type": LiQueryConstant.ResponseType.liApplicationType]
        return params
    }
}
/// Model used to create liDeviceIdUpdateClient request parameters.
public struct LiDeviceIdUpdateClientRequestParams: LiClientRequestParams {
    var deviceId: String
    var id: String
    /// Creates LiDeviceIdUpdateClientRequestParams object to pass onto liDeviceIdUpdateClient.
    /// - parameter deviceId: the device ID registered with the push notificaiton provider.
    /// - parameter id: the ID corresponding to device ID in the community
    public init(deviceId: String, id: String) throws {
        self.deviceId = try LiUtils.nonEmptyStringCheck(value: deviceId, errorMessage: "deviceId should not be an empty string")
        self.id = try LiUtils.nonEmptyStringCheck(value: id, errorMessage: "id should not be an empty string")
    }
    public func getPostParams() -> [String: Any] {
        let params: [String: Any] = ["type": LiQueryConstant.ResponseType.liUserDeviceIdFetchType, "device_id": deviceId]
        return params
    }
}
/// Model used to create liSubscriptionPostClient request parameters.
public struct LiSubscriptionPostClientRequestParams: LiClientRequestParams {
    var targetId: String
    var targetType: String
    /// Creates LiSubscriptionPostClientRequestParams object to pass onto liSubscriptionPostClient.
    /// - parameter targetId: the ID of the target of the subscription, either a message ID or a board ID.
    /// - parameter targetType: the type of the target of the subscription, either a "message" or a "board".
    @available(*, deprecated: 0.2.0)
    public init(targetId: String, targetType: String) throws {
        self.targetId = try LiUtils.nonEmptyStringCheck(value: targetId, errorMessage: "targetId should not be an empty string")
        self.targetType = try LiUtils.nonEmptyStringCheck(value: targetType, errorMessage: "targetType should not be an empty string")
    }
    /// Creates LiSubscriptionPostClientRequestParams object to pass onto liSubscriptionPostClient.
    /// - parameter targetId: the ID of the target of the subscription, either a message ID or a board ID.
    /// - parameter targetType: the type of the target of the subscription.
    public init(targetId: String, targetType: TargetType) throws {
        self.targetId = try LiUtils.nonEmptyStringCheck(value: targetId, errorMessage: "targetId should not be an empty string")
        self.targetType = targetType.rawValue
    }
    public func getPostParams() -> [String: Any] {
        let params: [String: Any] = ["type": LiQueryConstant.ResponseType.liSubscriptionsClientType, "target": ["type": targetType, "id": targetId]]
        return params
    }
    public enum TargetType: String {
        case message
        case board
    }
}
/// Model used to create liMarkMessagePostClient request parameters.
public struct LiMarkMessagePostClientRequestParams: LiClientRequestParams {
    var userId: String
    var messageId: String
    var markUnread: Bool
    /// Creates LiMarkMessagePostClientRequestParams object to pass onto liMarkMessagePostClient.
    /// - parameter userId: the ID of the user marking the message as read or unread.
    /// - parameter messageId: the ID of the message being marked read or unread.
    /// - parameter markUnread: pass 'true' to mark the message as unread, pass 'false' to mark as read.
    public init(userId: String, messageId: String, markUnread: Bool) throws {
        self.userId = try LiUtils.nonEmptyStringCheck(value: userId, errorMessage: "userId should not be an empty string")
        self.messageId = try LiUtils.nonEmptyStringCheck(value: messageId, errorMessage: "messageId should not be an empty string")
        self.markUnread = markUnread
    }
    public func getPostParams() -> [String: Any] {
        let params: [String: Any] = ["type": LiQueryConstant.ResponseType.liMarkMessageClientType, "mark_unread": markUnread, "message_id": messageId, "user": userId]
        return params
    }
}
/// Model used to create liMarkMessagesPostClient request parameters.
public struct LiMarkMessagesPostClientRequestParams: LiClientRequestParams {
    var userId: String
    var messageIds: String
    var markUnread: Bool
    /// Creates LiMarkMessagesPostClientRequestParams object to pass onto liMarkMessagesPostClient.
    /// - parameter userId: the ID of the user marking the message as read or unread.
    /// - parameter messageIds: the IDs of the messages being marked read or unread. Pass as array of String.
    /// - parameter markUnread: pass 'true' to mark the message as unread, pass 'false' to mark as read.
    public init(userId: String, messageIds: [String], markUnread: Bool) throws {
        self.userId = try LiUtils.nonEmptyStringCheck(value: userId, errorMessage: "userId should not be an empty string")
        let messageIdArray = try LiUtils.nonEmptyArrayCheck(value: messageIds, errorMessage: "messageIds should not be a empty array or contain an empty string as an element")
        self.messageIds = messageIdArray.joined(separator: ",")
        self.markUnread = markUnread
    }
    public func getPostParams() -> [String: Any] {
        let params: [String: Any] = ["type": LiQueryConstant.ResponseType.liMarkMessageClientType, "mark_unread": markUnread, "message_ids": messageIds, "user": userId]
        return params
    }
}
/// Model used to create liMarkTopicPostClient request parameters.
public struct LiMarkTopicPostClientRequestParams: LiClientRequestParams {
    var userId: String
    var topicId: String
    var markUnread: Bool
    /// Creates LiMarkTopicPostClientRequestParams object to pass onto liMarkTopicPostClient.
    /// - parameter userId: the ID of the user marking the message as read or unread.
    /// - parameter topicId: the ID of the topic being marked read or unread.
    /// - parameter markUnread: pass 'true' to mark the message as unread, pass 'false' to mark as read.
    public init(userId: String, topicId: String, markUnread: Bool) throws {
        self.userId = try LiUtils.nonEmptyStringCheck(value: userId, errorMessage: "userId should not be an empty string")
        self.topicId = try LiUtils.nonEmptyStringCheck(value: topicId, errorMessage: "topicId should not be an empty string")
        self.markUnread = markUnread
    }
    public func getPostParams() -> [String: Any] {
        let params: [String: Any] = ["type": LiQueryConstant.ResponseType.liMarkMessageClientType, "mark_unread": markUnread, "topic_id": topicId, "user": userId]
        return params
    }
}
/// Model used to create liSubscriptionDeleteClient request parameters.
public struct LiSubscriptionDeleteClientRequestParams: LiClientRequestParams {
    var subscriptionId: String
    /// Creates LiSubscriptionDeleteClientRequestParams object to pass onto liSubscriptionDeleteClient.
    /// - parameter subscriptionId: the ID of the subscription being deleted.
    public init(subscriptionId: String) throws {
        self.subscriptionId = try LiUtils.nonEmptyStringCheck(value: subscriptionId, errorMessage: "subscriptionId should not be an empty string")
    }
}
/// Model used to create liCreateUserClient request parameters.
public struct LiCreateUserClientRequestParams: LiClientRequestParams {
    var avatarUrl: String?
    var avatarImageId: String?
    var avatarExternal: String?
    var avatarInternal: String?
    var biography: String?
    var coverImage: String?
    var email: String
    var firstName: String?
    var lastName: String?
    var login: String
    var password: String
    /// Creates LiCreateUserClientRequestParams object to pass onto liCreateUserClient.
    /// - parameter email: the email address of the user being created
    /// - parameter firstName: Optional first name of the user.
    /// - parameter lastName: Optional last name of the user.
    /// - parameter login: the login of the user being created.
    /// - parameter password: password of the account.
    
    public init(email: String, firstName: String?, lastName: String?, login: String, password: String, avatarUrl: String?, avatarImageId: String?, avatarExternal: String?, avatarInternal: String?, biography: String?, coverImage: String?) throws {
        self.avatarUrl = avatarUrl
        self.avatarImageId = avatarImageId
        self.avatarExternal = avatarExternal
        self.avatarInternal = avatarInternal
        self.biography = biography
        self.coverImage = coverImage
        self.email = try LiUtils.emailValidation(email: email)
        self.firstName = firstName
        self.lastName = lastName
        self.login = try LiUtils.nonEmptyStringCheck(value: login, errorMessage: "login should not be an empty string")
        self.password = try LiUtils.nonEmptyStringCheck(value: password, errorMessage: "password should not be an empty string")
    }
    /// Returns POST parameters for liCreateUser client.
    /// - returns: [String: Any] containing post parameters
    public func getPostParams() -> [String: Any] {
        var params: [String: Any] = ["type": LiQueryConstant.ResponseType.liUserDetailsClientType, "email": email, "login": login, "password": password]
        if let fname = firstName {
            params["first_name"] = fname
        }
        if let lname = lastName {
            params["last_name"] = lname
        }
        if let bio = biography {
            params["biography"] = bio
        }
        if let coverImg = coverImage {
            params["cover_image"] = coverImg
        }
        var avatar: [String: String] = [:]
        if let url = avatarUrl {
            avatar["url"] = url
        }
        if let avatarId = avatarImageId {
            avatar["id"] = avatarId
        }
        if let avatarExt = avatarExternal {
            avatar["external"] = avatarExt
        }
        if let avatarInt = avatarInternal {
            avatar["internal"] = avatarInt
        }
        params["avatar"] = avatar
        return params
    }
}
/// Model used to create liUpdateUserClient request parameters.
public struct LiUpdateUserClientRequestParams: LiClientRequestParams {
    var avatarUrl: String?
    var avatarImageId: String?
    var avatarExternal: String?
    var avatarInternal: String?
    var biography: String?
    var coverImage: String?
    var email: String?
    var firstName: String?
    var lastName: String?
    var login: String?
    var id: String
    /// Creates LiUpdateUserClientRequestParams object to pass onto liUpdateUserClient.
    public init(id: String, email: String?, firstName: String?, lastName: String?, login: String?, avatarUrl: String?, avatarImageId: String?, avatarExternal: String?, avatarInternal: String?, biography: String?, coverImage: String?) throws {
        self.avatarUrl = avatarUrl
        self.avatarImageId = avatarImageId
        self.avatarExternal = avatarExternal
        self.avatarInternal = avatarInternal
        self.biography = biography
        self.coverImage = coverImage
        if let email = email {
            self.email = try LiUtils.emailValidation(email: email)
        }
        self.firstName = firstName
        self.lastName = lastName
        self.login = try LiUtils.nonEmptyStringCheck(value: login, errorMessage: "login should not be an empty string")
        self.id = try LiUtils.nonEmptyStringCheck(value: id, errorMessage: "id should not be an empty string")
    }
    /// Returns POST parameters for liUpdateUser client.
    /// - returns: [String: Any] containing post parameters
    public func getPostParams() -> [String: Any] {
        var params: [String: Any] = ["type": LiQueryConstant.ResponseType.liUserDetailsClientType, "id": id]
        if let email = email {
            params["email"] = email
        }
        if let login = login {
            params["login"] = login
        }
        if let fname = firstName {
            params["first_name"] = fname
        }
        if let lname = lastName {
            params["last_name"] = lname
        }
        if let bio = biography {
            params["biography"] = bio
        }
        if let coverImg = coverImage {
            params["cover_image"] = coverImg
        }
        var avatar: [String: String] = [:]
        if let url = avatarUrl {
            avatar["url"] = url
        }
        if let avatarId = avatarImageId {
            avatar["id"] = avatarId
        }
        if let avatarExt = avatarExternal {
            avatar["external"] = avatarExt
        }
        if let avatarInt = avatarInternal {
            avatar["internal"] = avatarInt
        }
        params["avatar"] = avatar
        return params
    }
}
/// Model used to create liGenericPostClient request parameters.
public struct LiGenericPostClientRequestParams: LiClientRequestParams {
    var path: String
    var requestBody: [String: Any]
    var additionalHttpHeaders: [String: String]?
    ///Creates LiGenericPostClientRequestParams object to pass onto liGenericPostClient.
    /// - parameter path: the endpoint path. Begin path after the /community/2.0/<tenant_ID>/ portion of the URI. This first portion of the URL is generated automatically for you. For example, for the endpoint /community/2.0/<tenant_id>/messages, pass "messages".
    /// - parameter requestBody: a [String: Any] object representing the request body.
    /// - parameter additionalHttpHeaders: (optional) a [String: String] object representing additional http headers.
    public init(path: String, requestBody: [String: Any], additionalHttpHeaders: [String: String]?) throws {
        if !requestBody.keys.isEmpty {
            _ = try LiUtils.nonEmptyArrayCheck(value: Array(requestBody.keys), errorMessage: "requestBody should not be a empty array or contain an empty element")
        }
        if let additionalHeaders = additionalHttpHeaders, !additionalHeaders.keys.isEmpty {
            _ = try LiUtils.nonEmptyArrayCheck(value: Array(additionalHeaders.keys), errorMessage: "additionalHeaders should not be a empty array or contain an empty element")
        }
        self.path = try LiUtils.nonEmptyStringCheck(value: path, errorMessage: "path should not be an empty string")
        self.requestBody = requestBody
        self.additionalHttpHeaders = additionalHttpHeaders
    }
}
/// Model used to create liGenericPutClient request parameters.
public struct LiGenericPutClientRequestParams: LiClientRequestParams {
    var path: String
    var requestBody: [String: Any]
    var additionalHttpHeaders: [String: String]?
    ///Creates LiGenericPutClientRequestParams object to pass onto liGenericPutClient.
    /// - parameter path: the endpoint path. Begin path after the /community/2.0/<tenant_ID>/ portion of the URI. This first portion of the URL is generated automatically for you. For example, for the endpoint /community/2.0/<tenant_id>/messages, pass "messages".
    /// - parameter requestBody: a [String: Any] object representing the request body.
    /// - parameter additionalHttpHeaders: (optional) a [String: String] object representing additional http headers.
    public init(path: String, requestBody: [String: Any], additionalHttpHeaders: [String: String]?) throws {
        if !requestBody.keys.isEmpty {
            _ = try LiUtils.nonEmptyArrayCheck(value: Array(requestBody.keys), errorMessage: "requestBody should not be a empty array or contain an empty element")
        }
        if let additionalHeaders = additionalHttpHeaders, !additionalHeaders.keys.isEmpty {
            _ = try LiUtils.nonEmptyArrayCheck(value: Array(additionalHeaders.keys), errorMessage: "additionalHttpHeaders should not be a empty array or contain an empty element")
        }
        self.path = try LiUtils.nonEmptyStringCheck(value: path, errorMessage: "path should not be an empty string")
        self.requestBody = requestBody
        self.additionalHttpHeaders = additionalHttpHeaders
    }
}
/// Model used to create `liGenericGetClient` request parameters.
public struct LiGenericGetClientRequestParams: LiClientRequestParams {
    var liQuery: String
    ///Creates LiGenericGetClientRequestParams object to pass onto liGenericGetClient.
    /// - parameter liQuery: the LiQL query to run, e.g. "SELECT subject, body FROM messages LIMIT 10".
    public init(liQuery: String) throws {
        self.liQuery = try LiUtils.nonEmptyStringCheck(value: liQuery, errorMessage: "liQuery should not be an empty string")
    }
}
/// Model used to create liGenericDeleteClient request parameters.
public struct LiGenericDeleteClientRequestParams: LiClientRequestParams {
    var liQueryRequestParams: [String: String]?
    var id: String
    var collectionsType: CollectionsType
    var subResourcePath: String?
    ///Creates LiGenericDeleteClientRequestParams object to pass onto liGenericDeleteClient.
    /// - parameter liQueryRequestParams: (optional) query parameters for the delete query.
    /// - parameter id: the ID of the item being deleted.
    /// - parameter collectionsType: the collection type of the item being deleted.
    /// - parameter subResourcePath: (optional) This will be appended after `id` in the delete url.
    public init(liQueryRequestParams: [String: String]?, id: String, collectionsType: CollectionsType, subResourcePath: String?) throws {
        if let liQueryRequestParams = liQueryRequestParams, !liQueryRequestParams.keys.isEmpty {
            _ = try LiUtils.nonEmptyArrayCheck(value: Array(liQueryRequestParams.keys), errorMessage: "liQueryRequestParams should not be a empty array or contain an empty element")
        }
        self.liQueryRequestParams = liQueryRequestParams
        self.id = try LiUtils.nonEmptyStringCheck(value: id, errorMessage: "id should not be an empty string")
        self.collectionsType = collectionsType
        self.subResourcePath = try LiUtils.nonEmptyStringCheck(value: subResourcePath, errorMessage: "subResourcePath should not be an empty string")
    }
    public enum CollectionsType: String {
        case messages
        case subscriptions
    }
}
/// Model used to create liBeaconClient request parameters.
public struct LiBeaconClientRequestParams: LiClientRequestParams {
    var type: String
    var id: String
    ///Creates LiBeaconClientRequestParams object to pass onto liBeaconClient.
    /// - parameter type: the type of page. Can be either user, conversation, category, board, or node
    /// - parameter id: id of the page. Either the user id or conversation id as a string, or the board or category "display id".
    public init(type: String, id: String) throws {
        self.type = try LiUtils.nonEmptyStringCheck(value: type, errorMessage: "type should not be an empty string")
        self.id = try LiUtils.nonEmptyStringCheck(value: id, errorMessage: "id should not be an empty string")
    }
    internal func getPostParams() -> [String: Any] {
        let params: [String: String] = ["type": type, "id": id]
        return params
    }
}
/// Model used to create liNoLiqlClient request parameters.
public struct LiNoLiqlClientRequestParams: LiClientRequestParams {
    var path: String
    var queryParameters: String
    ///Creates LiNoLiqlClientRequestParams object to pass onto liNoLiqlClient.
    /// - parameter path: Path for the call.
    /// - parameter queryParameters: Parameters for the query.
    public init(path: String, queryParameters: String) throws {
        self.path = try LiUtils.nonEmptyStringCheck(value: path, errorMessage: "path should not be an empty string")
        self.queryParameters = try LiUtils.nonEmptyStringCheck(value: queryParameters, errorMessage: "queryParmeter should not be an empty string")
    }
}
