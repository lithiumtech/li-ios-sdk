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
import Alamofire
protocol Router: URLRequestConvertible {
    var image:(imageData: Data, imageName: String)? {get}
    func stubData(filePath: String) throws -> LiBaseResponse
}
public enum LiClient: Router {
    //MARK: - Internal
    //MARK: Login clients
    case liSSOTokenRequest(ssoToken: String)
    case getAccessToken(code: String)
    case refreshAccessToken
    case signout(deivceId: String)
    //MARK: Utility Providers
    case liSdkSettingsClient(requestParams: LiSdkSettingsClientRequestParams)
    case liDeviceIdFetchClient(requestParams: LiDeviceIdFetchClientRequestParams)
    case liDeviceIdUpdateClient(requestParams: LiDeviceIdUpdateClientRequestParams)
    case liBeaconClient(requestParams: LiBeaconClientRequestParams)
    //MARK: - Public
    //MARK: User Providers
    /// Use this client to get current logged in user's subscriptions.
    case liUserSubscriptionsClient
    /// Use this client to get messages authored by the user.
    case liUserMessagesClient(requestParams: LiUserMessagesClientRequestParams)
    /// Use this client to get user details.
    case liUserDetailsClient(requestParams: LiUserDetailsClientRequestParams)
    /// Use this client to create a new user.
    case liCreateUserClient(requestParams: LiCreateUserClientRequestParams)
    /// Use this client to update user details.
    case liUpdateUserClient(requestParams: LiUpdateUserClientRequestParams)
    //MARK: Message Providers
    /// Use this client to get messages from the community.
    case liMessagesClient
    /// Use this client to get messages for a particular board.
    case liMessagesByBoardIdClient(requestParams: LiMessagesByBoardIdClientRequestParams)
    /// Use this client to get details of a message and it's replies.
    case liRepliesClient(requestParams: LiRepliesClientRequestParams)
    /// Use this client to get messages with particular ids.
    case liMessagesByIdsClient(requestParams: LiMessagesByIdsClientRequestParams)
    /// Use this client to get pinned messaegs.
    case liFloatedMessagesClient(requestParams: LiFloatedMessagesClientRequestParams)
    /// Use this client to get a particular message.
    case liMessageClient(requestParams: LiMessageClientRequestParams)
    /// Use this client to search for messages using a search query text.
    case liSearchClient(requestParams: LiSearchClientRequestParams)
    //MARK: Message Action Providers
    /// Use this client to delete a particular message. You can also delete the replies made to the message.
    case liMessageDeleteClient(requestParams: LiMessageDeleteClientRequestParams)
    /// Use this client to kudo a particular message.
    case liKudoClient(requestParams: LiKudoClientRequestParams)
    /// Use this client to unkudo a particular message.
    case liUnKudoClient(requestParams: LiUnKudoClientRequestParams)
    /// Use this client to accept a reply as a solution.
    case liAcceptSolutionClient(requestParams: LiAcceptSolutionClientRequestParams)
    /// Use this client to create a new message.
    case liCreateMessageClient(requestParams: LiCreateMessageClientRequestParams)
    /// Use this client to reply to a message.
    case liCreateReplyClient(requestParams: LiCreateReplyClientRequestParams)
    /// Use this client to report a message to the community admins.
    case liReportAbuseClient(requestParams: LiReportAbuseClientRequestParams)
    /// Use this client to update an old message.
    case liUpdateMessageClient(requestParams: LiUpdateMessageClientRequestParams)
    /// Use this client to mark a particular message as read/unread.
    case liMarkMessagePostClient(requestParams: LiMarkMessagePostClientRequestParams)
    /// Use this client to mark one or multiole message as read/unread.
    case liMarkMessagesPostClient(requestParams: LiMarkMessagesPostClientRequestParams)
    /// Use this client to mark a particular topic as read/unread.
    case liMarkTopicPostClient(requestParams: LiMarkTopicPostClientRequestParams)
    /// Use this client to upload images for a message or reply.
    case liUploadImageClient(requestParams: LiUploadImageClientRequestParams)
    /// Use this client to subscribe to a message or board.
    case liSubscriptionPostClient(requestParams: LiSubscriptionPostClientRequestParams)
    /// Use this client to unsubscribe to a message or board.
    case liSubscriptionDeleteClient(requestParams: LiSubscriptionDeleteClientRequestParams)
    //MARK: Browse Providers
    /// Use this client to fetch boards in a category.
    case liCategoryBoardsClient(requestParams: LiCategoryBoardsClientRequestParams)
    /// Use this client to fetch boards at a particular depth in community structure.
    case liBoardsByDepthClient(requestParams: LiBoardsByDepthClientRequestParams)
    /// Use this client to all the categories in a community.
    case liCategoryClient
    //MARK: Generic Clients
    /// Use this client to make a generic post call.
    case liGenericPostClient(requestParams: LiGenericPostClientRequestParams)
    /// Use this client to make a generic get call.
    case liGenericGetClient(requestParams: LiGenericGetClientRequestParams)
    /// Use this client to make a generic delete call.
    case liGenericDeleteClient(requestParams: LiGenericDeleteClientRequestParams)
    /// Use this client to make a generic put call.
    case liGenericPutClient(requestParams: LiGenericPutClientRequestParams)
    /// Use this client to make a request using non-liql queries.
    case liNoLiqlClient(requestParams: LiNoLiqlClientRequestParams)
}

extension LiClient {
    internal var activityLIQL: String {
        return LiClientConfig.getBaseQuery(client: self)
    }
    internal var responseType: String {
        return LiClientConfig.getType(client: self)
    }
    internal var querySettingType: String {
        return LiClientConfig.getQuerySettingType(client: self)
    }
    internal var image: (imageData: Data, imageName: String)? {
        switch self {
        case .liUploadImageClient(let requestParams):
            return (requestParams.image, requestParams.imageName)
        default:
            return nil
        }
    }
}

extension LiClient {
    internal var baseURL: String { return LiUrlConstructor.getBaseURL(client: self) }
    internal var path: String {
        switch self {
        case .getAccessToken:
            return "auth/accessToken"
        case .refreshAccessToken:
            return "auth/refreshToken"
        case .signout:
            return "auth/signout"
        case .liSSOTokenRequest:
            return "/" + LiSDKManager.shared().appCredentials.tenantID + "/api/2.0/auth/authorize"
        case .liKudoClient(let requestParams):
            return "messages/" + requestParams.messageId  + "/kudos"
        case .liUploadImageClient:
            return "images"
        case .liCreateReplyClient, .liCreateMessageClient:
            return "messages"
        case .liSearchClient, .liMessagesClient, .liRepliesClient, .liCategoryClient, .liBoardsByDepthClient, .liCategoryBoardsClient,
             .liMessagesByBoardIdClient, .liFloatedMessagesClient, .liSdkSettingsClient, .liUserSubscriptionsClient, .liUserMessagesClient, .liUserDetailsClient, .liMessageClient, .liMessagesByIdsClient, .liGenericGetClient:
            return "search"
        case .liBeaconClient:
            return "beacon"
        case .liNoLiqlClient(let requestParams):
            return requestParams.path + "?" + requestParams.queryParameters
        case .liAcceptSolutionClient:
            return "solutions_data"
        case .liReportAbuseClient:
            return "abuse_reports"
        case .liDeviceIdFetchClient:
            return "user_device_data"
        case .liCreateUserClient:
            return "users"
        case .liSubscriptionPostClient:
            return "subscriptions"
        case .liSubscriptionDeleteClient(let requestParams):
            return "subscriptions/" + requestParams.subscriptionId
        case .liMarkMessagesPostClient, .liMarkMessagePostClient, .liMarkTopicPostClient:
            return "messages_read"
        case .liUpdateMessageClient(let requestParams):
            return "messages/" + requestParams.messageId
        case .liUpdateUserClient(let requestParams):
            return "users/" + requestParams.id
        case .liGenericPutClient(let requestParams):
            return requestParams.path
        case .liGenericPostClient(let requestParams):
            return requestParams.path
        case .liDeviceIdUpdateClient(let requestParams):
            return "user_device_data/" + requestParams.id
        case .liGenericDeleteClient(let requestParams):
            var path = requestParams.collectionsType.rawValue + "/" + requestParams.id
            if let extraPathAfterId = requestParams.subResourcePath {
                path += "/" + extraPathAfterId
            }
            return path
        case .liMessageDeleteClient(let requestParams):
            return "messages/" + requestParams.messageId
        case .liUnKudoClient(let requestParams):
            return "messages/" + requestParams.messageId + "/kudos"
        }
    }
    internal var method: HTTPMethod {
        switch self {
        case .liMessagesClient, .liMessagesByBoardIdClient, .liSdkSettingsClient, .liUserSubscriptionsClient, .liCategoryBoardsClient, .liBoardsByDepthClient, .liRepliesClient, .liSearchClient, .liUserMessagesClient, .liCategoryClient, .liUserDetailsClient, .liMessageClient, .liFloatedMessagesClient, .liMessagesByIdsClient, .liGenericGetClient, .liNoLiqlClient:
            return .get
        case .getAccessToken, .refreshAccessToken, .signout, .liSSOTokenRequest, .liKudoClient, .liAcceptSolutionClient, .liCreateMessageClient, .liCreateReplyClient, .liUploadImageClient, .liReportAbuseClient, .liDeviceIdFetchClient, .liDeviceIdUpdateClient, .liCreateUserClient, .liMarkMessagePostClient, .liMarkMessagesPostClient, .liMarkTopicPostClient, .liSubscriptionPostClient, .liGenericPostClient, .liBeaconClient:
            return .post
        case .liUnKudoClient, .liSubscriptionDeleteClient, .liGenericDeleteClient, .liMessageDeleteClient:
            return .delete
        case .liUpdateMessageClient, .liUpdateUserClient, .liGenericPutClient:
            return .put
        }
    }
    internal var headers: HTTPHeaders {
        let clientID = LiSDKManager.shared().appCredentials.clientId
        let clientAppName = LiSDKManager.shared().appCredentials.clientAppName
        let visitorId = LiSDKManager.shared().visitorId ?? ""
        var headers: [String: String] = ["client-id": clientID, "Visitor-Id": visitorId, "Application-Identifier": clientAppName, "Application-Version": LiQueryConstant.apiVersion, "Content-Type": "application/json" ]
        switch self {
        case .liGenericPutClient(let requestParams):
            if let additionalHttpHeaders = requestParams.additionalHttpHeaders {
                headers.update(other: additionalHttpHeaders)
            }
        case .liGenericPostClient(let requestParams):
            if let additionalHttpHeaders = requestParams.additionalHttpHeaders {
                headers.update(other: additionalHttpHeaders)
            }
        case .liBeaconClient:
            if let visitLastIssueTime = LiSDKManager.shared().authState.visitLastIssueTime {
                headers["Visit-Last-Issue-Time"] = visitLastIssueTime
            }
            if let visitOriginTime = LiSDKManager.shared().authState.visitOriginTime {
                headers["Visit-Origin-Time"] = visitOriginTime
            }
        default:
            break
        }
        return headers
    }
    internal var parameters: Parameters? {
        let clientID =  LiSDKManager.shared().appCredentials.clientId
        let clientSecret = LiSDKManager.shared().appCredentials.clientSecret
        let redirectUri = LiSDKManager.shared().appCredentials.redirectURL
        switch self {
        case .getAccessToken(let code):
            return ["code": code,
                    "client_id": clientID,
                    "redirect_uri": redirectUri,
                    "client_secret": clientSecret,
                    "grant_type": "authorization_code"]
        case .refreshAccessToken:
            let refreshToken = LiSDKManager.shared().authState.refreshToken
            return ["refresh_token": refreshToken ?? "",
                    "client_id": clientID,
                    "client_secret": clientSecret,
                    "grant_type": "refresh_token"]
        case .liSSOTokenRequest(let ssoToken):
            let state = String(Date.timeIntervalSinceReferenceDate)
            let jwt = ssoToken
            return ["jwt": jwt,
                    "clientID": clientID,
                    "redirectUri": redirectUri,
                    "state": state,
                    "deviceGroup": "iOS"]
        case .signout(let deivceId):
            return ["data": ["deviceId": deivceId]]
        case .liKudoClient(let requestParams):
            return ["data": requestParams.getPostParams()]
        case .liCreateReplyClient(let requestParams):
            return ["data": requestParams.getPostParams()]
        case .liCreateMessageClient(let requestParams):
            return ["data": requestParams.getPostParams()]
        case .liAcceptSolutionClient(let requestParams):
            return ["data": requestParams.getPostParams()]
        case .liReportAbuseClient(let requestParam):
            return ["data": requestParam.getPostParams()]
        case .liDeviceIdFetchClient(let requestParams):
            return ["data": requestParams.getPostParams()]
        case .liCreateUserClient(let requestParams):
            return ["data": requestParams.getPostParams()]
        case .liSubscriptionPostClient(let requestParams):
            return ["data": requestParams.getPostParams()]
        case .liMarkMessagePostClient(let requestParams):
            return ["data": requestParams.getPostParams()]
        case .liMarkMessagesPostClient(let requestParams):
            return ["data": requestParams.getPostParams()]
        case .liMarkTopicPostClient(let requestParams):
            return ["data": requestParams.getPostParams()]
        case .liUpdateMessageClient(let requestParams):
            return ["data": requestParams.getPostParams()]
        case .liUpdateUserClient(let requestParams):
            return ["data": requestParams.getPostParams()]
        case .liGenericPutClient(let requestParams):
            return ["data": requestParams.requestBody]
        case .liGenericPostClient(let requestParams):
            return ["data": requestParams.requestBody]
        case .liDeviceIdUpdateClient(let requestParams):
            return ["data": requestParams.getPostParams()]
        case .liUploadImageClient:
            return [:]
        case .liRepliesClient(let requestParams):
            return [LiQueryConstant.liMarkAsRead: "true", "q": LiUrlConstructor.getLiqlQuery(client: self).replacingOccurrences(of: "##", with: requestParams.parentId).replacingOccurrences(of: "&&", with: "\(requestParams.offset)")]
        case .liMessagesClient:
            return ["q": LiUrlConstructor.getLiqlQuery(client: self).replacingOccurrences(of: "##", with: "0")]
        case .liSearchClient(let requestParams):
            return [LiQueryConstant.liForUISearch: "true", "q": LiUrlConstructor.getLiqlQuery(client: self).replacingOccurrences(of: "##", with:  requestParams.query)]
        case .liBeaconClient(let requestParams):
            return ["target": requestParams.getPostParams()]
        case .liCategoryClient:
            return ["q": LiUrlConstructor.getLiqlQuery(client: self)]
        case .liBoardsByDepthClient(let requestParams):
            return ["q": LiUrlConstructor.getLiqlQuery(client: self).replacingOccurrences(of: "##", with: "\(requestParams.depth)")]
        case .liCategoryBoardsClient(let requestParams):
            return ["q": LiUrlConstructor.getLiqlQuery(client: self).replacingOccurrences(of: "##", with: requestParams.categoryId)]
        case .liMessagesByBoardIdClient(let requestParams):
            return ["q": LiUrlConstructor.getLiqlQuery(client: self).replacingOccurrences(of: "##", with: requestParams.boardId).replacingOccurrences(of: "&&", with: "0")]
        case .liFloatedMessagesClient(let requestParams):
            return ["q": LiUrlConstructor.getLiqlQuery(client: self).replacingOccurrences(of: "##", with: requestParams.boardId).replacingOccurrences(of: "&&", with: requestParams.scope)]
        case .liSdkSettingsClient(let requestParams):
            return ["q": LiUrlConstructor.getLiqlQuery(client: self).replacingOccurrences(of: "##", with: requestParams.clientId)]
        case .liUserSubscriptionsClient:
            return ["q": LiUrlConstructor.getLiqlQuery(client: self)]
        case .liUserMessagesClient(let requestParams):
            return ["q": LiUrlConstructor.getLiqlQuery(client: self).replacingOccurrences(of: "##", with: requestParams.authorId).replacingOccurrences(of: "&&", with: requestParams.depth)]
        case .liUserDetailsClient(let requestParams):
            return ["q": LiUrlConstructor.getLiqlQuery(client: self).replacingOccurrences(of: "##", with: requestParams.userId)]
        case .liMessageClient(let requestParams):
            return ["q": LiUrlConstructor.getLiqlQuery(client: self).replacingOccurrences(of: "##", with: requestParams.messageId)]
        case .liMessagesByIdsClient(let requestParams):
            var idsString: String = ""
            var first = true
            for id in requestParams.messageIds {
                if !first {
                    idsString.append(",")
                } else {
                    first = false
                }
                idsString.append("'")
                idsString.append(id)
                idsString.append("'")
            }
            return ["q": LiUrlConstructor.getLiqlQuery(client: self).replacingOccurrences(of: "##", with: idsString)]
        case .liGenericGetClient(let requestParams):
            return ["q": requestParams.liQuery]
        case .liGenericDeleteClient(let requestParams):
            return requestParams.liQueryRequestParams ?? [:]
        case .liMessageDeleteClient(let requestParams):
            return requestParams.getPostParams()
        default:
            return nil
        }
    }
    internal var encoding: ParameterEncoding {
        switch  self {
        case .liMessagesClient, .liMessagesByBoardIdClient, .liSdkSettingsClient, .liUserSubscriptionsClient, .liCategoryBoardsClient, .liBoardsByDepthClient, .liRepliesClient, .liSearchClient, .liUserMessagesClient, .liCategoryClient, .liUserDetailsClient, .liMessageClient, .liFloatedMessagesClient, .liMessagesByIdsClient, .liGenericGetClient, .liUnKudoClient, .liSubscriptionDeleteClient, .liGenericDeleteClient, .liMessageDeleteClient, .liNoLiqlClient:
            return URLEncoding.queryString
        case .getAccessToken, .refreshAccessToken, .liSSOTokenRequest, .signout, .liKudoClient, .liAcceptSolutionClient, .liCreateMessageClient, .liCreateReplyClient, .liUploadImageClient, .liReportAbuseClient, .liDeviceIdFetchClient, .liDeviceIdUpdateClient, .liCreateUserClient, .liMarkMessagePostClient, .liMarkMessagesPostClient, .liMarkTopicPostClient, .liSubscriptionPostClient, .liGenericPostClient, .liUpdateMessageClient, .liUpdateUserClient, .liGenericPutClient, .liBeaconClient:
            return JSONEncoding.prettyPrinted
        }
    }
    // MARK: - URLRequestConvertable
    public func asURLRequest() throws -> URLRequest {
        do {
            let url = try baseURL.asURL()
            var urlRequest = URLRequest(url: url.appendingPathComponent(path))
            urlRequest.allHTTPHeaderFields = headers
            urlRequest.httpMethod = method.rawValue
            switch self {
            case .liUploadImageClient: break
            default:
                urlRequest = try encoding.encode(urlRequest, with: parameters)
                break
            }
            return urlRequest
        } catch let error {
            throw error
        }
    }
    // MARK: - Router = Method to return stubbed data for testing
    internal func stubData(filePath: String) throws -> LiBaseResponse {
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: filePath), options: .alwaysMapped)
            let response = try LiBaseResponse(responseData: data)
            return response
        } catch let error {
            throw error
        }
    }
}
