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

import Foundation
import LiCore
public protocol LiClientServiceProtocol {
    ///Method to handel API call success in ViewController
    /// - parameter client: LiClientType for the respective client.
    /// - parameter result: (optional) Data returned by the api.
    func success(client: LiClient, result: [LiBaseModel]?)
    ///Method to handel API call failure in ViewController
    /// - parameter client: (optional)LiClientType for the respective client.
    /// - parameter errorMessage: Error message to display.
    func failure(client: LiClient?, errorMessage: String)
}
public class LiClientService {
    static let sharedInstance = LiClientService()
    let sdkManager = LiSDKManager.shared()
    init() {}
    ///API call to get data about all the categories.
    public func getCategoriesData(delegate: LiClientServiceProtocol) {
        sdkManager.clientManager.request(client: LiClient.liCategoryClient) { (result: Result<[LiBrowse]>) in
            switch result {
            case .success(let data):
                delegate.success(client: .liCategoryClient, result: data)
            case .failure(let error):
                if let err = error as? LiBaseError {
                    delegate.failure(client: .liCategoryClient, errorMessage: err.errorMessage)
                } else {
                    delegate.failure(client: .liCategoryClient, errorMessage: error.localizedDescription)
                }
            }
        }
    }
    ///API call to get boards at given level.
    /// - parameter atLevel: Level at which the boards are required.
    public func getTopBoards(atLevel level: Int, delegate: LiClientServiceProtocol) {
        do {
            let requestParams = try LiBoardsByDepthClientRequestParams(depth: level)
            sdkManager.clientManager.request(client: .liBoardsByDepthClient(requestParams: requestParams), completionHandler: { (result: Result<[LiBrowse]>) in
                switch result {
                case .success(let data):
                    delegate.success(client: .liBoardsByDepthClient(requestParams: requestParams), result: data)
                case .failure(let error):
                    if let err = error as? LiBaseError {
                        delegate.failure(client: .liBoardsByDepthClient(requestParams: requestParams), errorMessage: err.errorMessage)
                    } else {
                        delegate.failure(client: .liBoardsByDepthClient(requestParams: requestParams), errorMessage: error.localizedDescription)
                    }
                }
            })
        } catch let error {
            switch error as! LiError {
            case .invalidArgument(let message):
                delegate.failure(client: nil, errorMessage: message)
            }
        }
    }
    ///API call to get boards for a given category.
    /// - parameter forCategory: Category for which the boards are requested.
    public func getBoards(forCategory category: String, delegate: LiClientServiceProtocol) {
        do {
            let requestParams = try LiCategoryBoardsClientRequestParams(categoryId: category)
            sdkManager.clientManager.request(client: .liCategoryBoardsClient(requestParams: requestParams), completionHandler: { (result: Result<[LiBrowse]>) in
                switch result {
                case .success(let data):
                    delegate.success(client: .liCategoryBoardsClient(requestParams: requestParams), result: data)
                case .failure(let error):
                    if let err = error as? LiBaseError {
                        delegate.failure(client: .liCategoryBoardsClient(requestParams: requestParams), errorMessage: err.errorMessage)
                    } else {
                        delegate.failure(client: .liCategoryBoardsClient(requestParams: requestParams), errorMessage: error.localizedDescription)
                    }
                }
            })
        } catch let error {
            switch error as! LiError {
            case .invalidArgument(let message):
                delegate.failure(client: nil, errorMessage: message)
            }
        }
    }
    ///API call to get all messages in a given board.
    /// - parameter forBoardId: Board id for which the messages are requested.
    public func getMessages(forBoardId boardId: String, delegate: LiClientServiceProtocol) {
        do {
            let requestParams = try LiMessagesByBoardIdClientRequestParams(boardId: boardId)
            sdkManager.clientManager.request(client: .liMessagesByBoardIdClient(requestParams: requestParams), completionHandler: { (result: Result<[LiMessage]>) in
                switch result {
                case .success(let data):
                    delegate.success(client: .liMessagesByBoardIdClient(requestParams: requestParams), result: data)
                case .failure(let error):
                    if let err = error as? LiBaseError {
                        delegate.failure(client: .liMessagesByBoardIdClient(requestParams: requestParams), errorMessage: err.errorMessage)
                    } else {
                        delegate.failure(client: .liMessagesByBoardIdClient(requestParams: requestParams), errorMessage: error.localizedDescription)
                    }
                }
            })
        } catch let error {
            switch error as! LiError {
            case .invalidArgument(let message):
                delegate.failure(client: nil, errorMessage: message)
            }
        }
    }
    ///API call to get floated messages in a given board.
    /// - parameter forBoardId: Board id for which the floated messages are requested.
    public func getFloatedMessages(forBoardId boardId: String, delegate: LiClientServiceProtocol) {
        do {
            let requestParams = try LiFloatedMessagesClientRequestParams(boardId: boardId, scope: LiFloatedMessagesClientRequestParams.Scope.local)
            sdkManager.clientManager.request(client: .liFloatedMessagesClient(requestParams: requestParams), completionHandler: { (result: Result<[LiFloatedMessage]>) in
                switch result {
                case .success(let data):
                    delegate.success(client: .liFloatedMessagesClient(requestParams: requestParams), result: data)
                case .failure(let error):
                    if let err = error as? LiBaseError {
                        delegate.failure(client: .liFloatedMessagesClient(requestParams: requestParams), errorMessage: err.errorMessage)
                    } else {
                        delegate.failure(client: .liFloatedMessagesClient(requestParams: requestParams), errorMessage: error.localizedDescription)
                    }
                }
            })
        } catch let error {
            switch error as! LiError {
            case .invalidArgument(let message):
                delegate.failure(client: nil, errorMessage: message)
            }
        }
    }
    ///API call to post a reply to a given message.
    /// - parameter messageModel: Details of the original message.
    /// - parameter messageBodyText: Text of the reply.
    /// - parameter imageId: (optional) Image id of the image that was uploaded corresponding to this reply.
    /// - parameter imageName: (optional) Filename of the image.
    public func postReply(messageModel: LiReply, messageBodyText: String, imageId: String?, imageName: String?, delegate: LiClientServiceProtocol) {
        do {
            let requestParams = try LiCreateReplyClientRequestParams(body: messageBodyText, messageId: messageModel.messageId, subject: "RE: \(messageModel.topic)", imageId: imageId, imageName: imageName)
            sdkManager.clientManager.request(client: .liCreateReplyClient(requestParams: requestParams), completionHandler: { (result: Result<[LiMessage]>) in
                switch result {
                case .success(_):
                    delegate.success(client: .liCreateReplyClient(requestParams: requestParams), result: nil)
                case .failure(let error):
                    if let err = error as? LiBaseError {
                        delegate.failure(client: .liCreateReplyClient(requestParams: requestParams), errorMessage: err.errorMessage)
                    } else {
                        delegate.failure(client: .liCreateReplyClient(requestParams: requestParams), errorMessage: error.localizedDescription)
                    }
                }
            })
        } catch let error {
            switch error as! LiError {
            case .invalidArgument(let message):
                delegate.failure(client: nil, errorMessage: message)
            }
        }
    }
    ///API call to post a new message to a given board.
    /// - parameter boardId: Board ID of the board to which this message should be posted.
    /// - parameter topic: Topic of the message.
    /// - parameter body: Body of the message.
    /// - parameter imageId: (optional) Image id of the image that was uploaded corresponding to this reply.
    /// - parameter imageName: (optional) Filename of the image.
    public func postNewMessage(boardId: String, topic: String, body: String?, imageId: String?, imageName: String?, delegate: LiClientServiceProtocol) {
        do {
            let requestParams = try LiCreateMessageClientRequestParams(subject: topic, body: body, boardId: boardId, imageId: imageId, imageName: imageName)
            sdkManager.clientManager.request(client: .liCreateMessageClient(requestParams: requestParams), completionHandler: { (result: Result<[LiMessage]>) in
                switch result {
                case .success(_):
                    delegate.success(client: .liCreateMessageClient(requestParams: requestParams), result: nil)
                case .failure(let error):
                    if let err = error as? LiBaseError {
                        delegate.failure(client: .liCreateMessageClient(requestParams: requestParams), errorMessage: err.errorMessage)
                    } else {
                        delegate.failure(client: .liCreateMessageClient(requestParams: requestParams), errorMessage: error.localizedDescription)
                    }
                }
            })
        } catch let error {
            switch error as! LiError {
            case .invalidArgument(let message):
                delegate.failure(client: nil, errorMessage: message)
            }
        }
    }
    ///API call to upload image.
    /// - parameter topic: Topic of the message corresponding to the image.
    /// - parameter image: Image to be uploaded.
    /// - parameter imageName: FileName of the image.
    public func uploadImage(topic: String, image: UIImage, imageName: String, delegate: LiClientServiceProtocol) {
        do {
            let requestParams = try LiUploadImageClientRequestParams(title: topic, description: "Uploaded from iOS", imageName: imageName, image: image)
            sdkManager.clientManager.request(client: .liUploadImageClient(requestParams: requestParams), completionHandler: { (result: Result<[LiImageResponse]>) in
                switch result {
                case .success(let data):
                    delegate.success(client: .liUploadImageClient(requestParams: requestParams), result: data)
                case .failure(let error):
                    if let err = error as? LiBaseError {
                        delegate.failure(client: .liUploadImageClient(requestParams: requestParams), errorMessage: err.errorMessage)
                    } else {
                        delegate.failure(client: .liUploadImageClient(requestParams: requestParams), errorMessage: error.localizedDescription)
                    }
                }
            })
        } catch let error {
            switch error as! LiError {
            case .invalidArgument(let message):
                delegate.failure(client: nil, errorMessage: message)
            }
        }
    }
    ///API to kudo a message.
    /// - parameter messageId: id of the message to kudo.
    public func kudoMessage(messageId: String, delegate: LiClientServiceProtocol) {
        do {
            let requestParams = try LiKudoClientRequestParams(messageId: messageId)
            sdkManager.clientManager.request(client: .liKudoClient(requestParams: requestParams), completionHandler: { (result: Result<[LiMessage]>) in
                switch result {
                case .success(let data):
                    delegate.success(client: .liKudoClient(requestParams: requestParams), result: data)
                case .failure(let error):
                    if let err = error as? LiBaseError {
                        delegate.failure(client: .liKudoClient(requestParams: requestParams), errorMessage: err.errorMessage)
                    } else {
                        delegate.failure(client: .liKudoClient(requestParams: requestParams), errorMessage: error.localizedDescription)
                    }
                }
            })
        } catch let error {
            switch error as! LiError {
            case .invalidArgument(let message):
                delegate.failure(client: nil, errorMessage: message)
            }
        }
    }
    ///API to unkudo a message.
    /// - parameter messageId: id of the message to unkudo.
    public func unKudoMessage(messageId: String, delegate: LiClientServiceProtocol) {
        do {
            let requestParams = try LiUnKudoClientRequestParams(messageId: messageId)
            sdkManager.clientManager.request(client: .liUnKudoClient(requestParams: requestParams), completionHandler: { (result: Result<[LiMessage]>) in
                switch result {
                case .success(let data):
                    delegate.success(client: .liUnKudoClient(requestParams: requestParams), result: data)
                case .failure(let error):
                    if let err = error as? LiBaseError {
                        delegate.failure(client: .liUnKudoClient(requestParams: requestParams), errorMessage: err.errorMessage)
                    } else {
                        delegate.failure(client: .liUnKudoClient(requestParams: requestParams), errorMessage: error.localizedDescription)
                    }
                }
            })
        } catch let error {
            switch error as! LiError {
            case .invalidArgument(let message):
                delegate.failure(client: nil, errorMessage: message)
            }
        }
    }
    ///API to accept a message as the correct answer.
    /// - parameter messageId: id of the message to accept.
    public func acceptAnswer(messageId: String, delegate: LiClientServiceProtocol) {
        do {
            let requestParams = try LiAcceptSolutionClientRequestParams(messageId: messageId)
            sdkManager.clientManager.request(client: .liAcceptSolutionClient(requestParams: requestParams), completionHandler: { (result: Result<[LiGenericQueryResponse]>) in
                switch result {
                case .success(let data):
                    delegate.success(client: .liAcceptSolutionClient(requestParams: requestParams), result: data)
                case .failure(let error):
                    if let err = error as? LiBaseError {
                        delegate.failure(client: .liAcceptSolutionClient(requestParams: requestParams), errorMessage: err.errorMessage)
                    } else {
                        delegate.failure(client: .liAcceptSolutionClient(requestParams: requestParams), errorMessage: error.localizedDescription)
                    }
                }
            })
        } catch let error {
            switch error as! LiError {
            case .invalidArgument(let message):
                delegate.failure(client: nil, errorMessage: message)
            }
        }
    }
    ///API to mark a message as abusive.
    /// - parameter messageId: id of the message to mark.
    /// - parameter userId: id of the user marking the message.
    /// - parameter body: message describing reason to mark the message as abusive.
    public func markAbuse(messageId: String, userId: String, body: String, delegate: LiClientServiceProtocol) {
        do {
            let requestParams = try LiReportAbuseClientRequestParams(messageId: messageId, userId: userId, body: body)
            sdkManager.clientManager.request(client: .liReportAbuseClient(requestParams: requestParams), completionHandler: { (result: Result<[LiGenericQueryResponse]>) in
                switch result {
                case .success(let data):
                    delegate.success(client: .liReportAbuseClient(requestParams: requestParams), result: data)
                case .failure(let error):
                    if let err = error as? LiBaseError {
                        delegate.failure(client: .liReportAbuseClient(requestParams: requestParams), errorMessage: err.errorMessage)
                    } else {
                        delegate.failure(client: .liReportAbuseClient(requestParams: requestParams), errorMessage: error.localizedDescription)
                    }
                }
            })
        } catch let error {
            switch error as! LiError {
            case .invalidArgument(let message):
                delegate.failure(client: nil, errorMessage: message)
            }
        }
    }
    ///API to subscribe to a message/board.
    /// - parameter targetId: id of the message/board to subscribe.
    /// - parameter targetType: the type of the target of the subscription, either a "message" or a "board".
    public func subscribeToTopic(targetId: String, targetType: LiSubscriptionPostClientRequestParams.TargetType, delegate: LiClientServiceProtocol) {
        do {
            let requestParams = try LiSubscriptionPostClientRequestParams(targetId: targetId, targetType: targetType)
            sdkManager.clientManager.request(client: .liSubscriptionPostClient(requestParams: requestParams), completionHandler: { (result: Result<[LiSubscriptions]>) in
                switch result {
                case .success(let data):
                    delegate.success(client: .liSubscriptionPostClient(requestParams: requestParams), result: data)
                case .failure(let error):
                    if let err = error as? LiBaseError {
                        delegate.failure(client: .liSubscriptionPostClient(requestParams: requestParams), errorMessage: err.errorMessage)
                    } else {
                        delegate.failure(client: .liSubscriptionPostClient(requestParams: requestParams), errorMessage: error.localizedDescription)
                    }
                }
            })
        } catch let error {
            switch error as! LiError {
            case .invalidArgument(let message):
                delegate.failure(client: nil, errorMessage: message)
            }
        }
    }
    ///API to call user activity.
    public func getUserActivity(delegate: LiClientServiceProtocol) {
        do {
            let userId = sdkManager.authState.userId ?? ""
            let requestParams = try LiUserMessagesClientRequestParams(authorId: userId, depth: 0)
            sdkManager.clientManager.request(client: .liUserMessagesClient(requestParams: requestParams), completionHandler: { (result: Result<[LiMessage]>) in
                switch result {
                case .success(let data):
                    delegate.success(client: .liUserMessagesClient(requestParams: requestParams), result: data)
                case .failure(let error):
                    if let err = error as? LiBaseError {
                        delegate.failure(client: .liUserMessagesClient(requestParams: requestParams), errorMessage: err.errorMessage)
                    } else {
                        delegate.failure(client: .liUserMessagesClient(requestParams: requestParams), errorMessage: error.localizedDescription)
                    }
                }
            })
        } catch let error {
            switch error as! LiError {
            case .invalidArgument(let message):
                delegate.failure(client: nil, errorMessage: message)
            }
        }
    }
    ///API to get messsages.
    public func getMessages(delegate: LiClientServiceProtocol) {
        sdkManager.clientManager.request(client: .liMessagesClient) { (result: Result<[LiMessage]>) in
            switch result {
            case .success(let data):
                delegate.success(client: .liMessagesClient, result: data)
            case .failure(let error):
                if let err = error as? LiBaseError {
                    delegate.failure(client: .liMessagesClient, errorMessage: err.errorMessage)
                } else {
                    delegate.failure(client: .liMessagesClient, errorMessage: error.localizedDescription)
                }
            }
        }
    }
    ///API to search messages.
    /// - parameter queryText: text to search for.
    public func search(queryText: String, delegate: LiClientServiceProtocol) {
        do {
            let requestParams = try LiSearchClientRequestParams(query: queryText)
            sdkManager.clientManager.request(client: .liSearchClient(requestParams: requestParams), completionHandler: { (result: Result<[LiMessage]>) in
                switch result {
                case .success(let data):
                    delegate.success(client: .liSearchClient(requestParams: requestParams), result: data)
                case .failure(let error):
                    if let err = error as? LiBaseError {
                        delegate.failure(client: .liSearchClient(requestParams: requestParams), errorMessage: err.errorMessage)
                    } else {
                        delegate.failure(client: .liSearchClient(requestParams: requestParams), errorMessage: error.localizedDescription)
                    }
                }
            })
        } catch let error {
            switch error as! LiError {
            case .invalidArgument(let message):
                delegate.failure(client: nil, errorMessage: message)
            }
        }
    }
    ///API to get replies for a messages
    /// - parameter messageId: Id of the message for which replies are requested.
    public func getReplies(messageId: String, delegate: LiClientServiceProtocol) {
        do {
            let requestParams = try LiRepliesClientRequestParams(parentId: messageId, limit: 25)
            sdkManager.clientManager.request(client: .liRepliesClient(requestParams: requestParams), completionHandler: { (result: Result<[LiMessage]>) in
                switch result {
                case .success(let data):
                    delegate.success(client: .liRepliesClient(requestParams: requestParams), result: data)
                case .failure(let error):
                    if let err = error as? LiBaseError {
                        delegate.failure(client: .liRepliesClient(requestParams: requestParams), errorMessage: err.errorMessage)
                    } else {
                        delegate.failure(client: .liRepliesClient(requestParams: requestParams), errorMessage: error.localizedDescription)
                    }
                }
            })
        } catch let error {
            switch error as! LiError {
            case .invalidArgument(let message):
                delegate.failure(client: nil, errorMessage: message)
            }
        }
    }
    ///API to get user details
    public func getUserDetails(delegate: LiClientServiceProtocol) {
        do {
            let requestParams = try LiUserDetailsClientRequestParams(userId: "self")
            sdkManager.clientManager.request(client: .liUserDetailsClient(requestParams: requestParams), completionHandler: { (result: Result<[LiUser]>) in
                switch result {
                case .success(let data):
                    delegate.success(client: .liUserDetailsClient(requestParams: requestParams), result: data)
                case .failure(let error):
                    if let err = error as? LiBaseError {
                        delegate.failure(client: .liUserDetailsClient(requestParams: requestParams), errorMessage: err.errorMessage)
                    } else {
                        delegate.failure(client: .liUserDetailsClient(requestParams: requestParams), errorMessage: error.localizedDescription)
                    }
                }
            })
        } catch let error {
            switch error as! LiError {
            case .invalidArgument(let message):
                delegate.failure(client: nil, errorMessage: message)
            }
        }
    }
    ///API to fire beacon events
    /// - parameter type: the type of page. Can be either user, conversation, category, board, or node.
    /// - parameter id: id of the page. Either the user id or conversation id as a string, or the board or category "display id".
    public func registerEvent(type: LiEventsType, id: String, delegate: LiClientServiceProtocol) {
        do {
            let requestParams = try LiBeaconClientRequestParams(type: type.rawValue, id: id)
            sdkManager.clientManager.request(client: .liBeaconClient(requestParams: requestParams), completionHandler: { (result: Result<[LiGenericQueryResponse]>) in
                switch result {
                case .success(_):
                    delegate.success(client: .liBeaconClient(requestParams: requestParams), result: nil)
                case .failure(let error):
                    if let err = error as? LiBaseError {
                        delegate.failure(client: .liBeaconClient(requestParams: requestParams), errorMessage: err.errorMessage)
                    } else {
                        delegate.failure(client: .liBeaconClient(requestParams: requestParams), errorMessage: error.localizedDescription)
                    }
                }
            })
        } catch let error {
            switch error as! LiError {
            case .invalidArgument(let message):
                delegate.failure(client: nil, errorMessage: message)
            }
        }
    }
    public func deleteMessage(messageId: String, includeReplies: Bool, delegate: LiClientServiceProtocol) {
        do {
            let requestParams = try LiMessageDeleteClientRequestParams(messageId: messageId, includeReplies: includeReplies)
            sdkManager.clientManager.request(client: .liMessageDeleteClient(requestParams: requestParams), completionHandler: { (result: Result<[LiGenericQueryResponse]>) in
                switch result {
                case .success(let data):
                    delegate.success(client: .liMessageDeleteClient(requestParams: requestParams), result: data)
                case .failure(let error):
                    if let err = error as? LiBaseError {
                        delegate.failure(client: .liMessageDeleteClient(requestParams: requestParams), errorMessage: err.errorMessage)
                    } else {
                        delegate.failure(client: .liMessageDeleteClient(requestParams: requestParams), errorMessage: error.localizedDescription)
                    }
                }
            })
        } catch let error {
            switch error as! LiError {
            case .invalidArgument(let message):
                delegate.failure(client: nil, errorMessage: message)
            }
        }
    }
}
