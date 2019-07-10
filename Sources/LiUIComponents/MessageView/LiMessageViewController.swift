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
import LiCore
open class LiMessageViewController: UIViewController {
    @IBOutlet weak var btnShare: LiBarButton!
    @IBOutlet weak var btnReply: LiBarButton!
    @IBOutlet weak var toolbar: UIToolbar!
    var originalMessageId: String?
    var messageObject: LiMessageViewModel?
    var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    open override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        setupActivityIndicator()
        getData()
    }
    func setupActivityIndicator() {
        activityIndicatorView = UIActivityIndicatorView(style: .gray)
        activityIndicatorView.hidesWhenStopped = true
    }
    func startActivityIndicator() {
        tableView.backgroundView = activityIndicatorView
        activityIndicatorView.startAnimating()
    }
    func stopActivityIndicator() {
        activityIndicatorView.stopAnimating()
    }
    func setupUI() {
        self.title = LiHelperFunctions.localizedString(for: "messages")
        tableView.tableFooterView = UIView(frame: .zero)
        toolbar.tintColor = LiUISDKManager.sharedInstance.globalTintColor
    }
    func getData() {
        if let messageId = originalMessageId {
            startActivityIndicator()
            LiClientService.sharedInstance.getReplies(messageId: messageId, delegate: self)
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    func postDataUISetup() {
        let messageText = LiHelperFunctions.localizedString(for: "messages")
        self.title = "\(messageObject?.messages.count ?? 0) " + messageText
        stopActivityIndicator()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = false
        tableView.registerReusableCellWithNib(LiMessageDetailTableViewCell.self)
        tableView.registerReusableCellWithNib(LiMessageRepliesTableViewCell.self)
        tableView.registerReusableHeaderFooterViewWithNib(LiMessageDetailTableViewHeader.self)
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rowHeight = UITableView.automaticDimension
        self.reloadTable()
    }
    //MARK:- Button actions
    @IBAction func onAction(_ sender: UIBarButtonItem) {
        if let shareURL = URL(string: self.messageObject?.originalMessage.viewHref ?? "") {
            let vc = UIActivityViewController(activityItems: [shareURL], applicationActivities: [])
            self.present(vc, animated: true)
        }
    }
    @IBAction func onReply(_ sender: UIBarButtonItem) {
        performReplyAction(id: originalMessageId!)
    }
    func performReplyAction(id: String)  {
        let model = LiReply(messageId: id, topic: messageObject?.originalMessage.subject ?? "")
        let  vc = LiReplyViewController(model: model)
        let navController = UINavigationController(rootViewController: vc)
        self.present(navController, animated: true, completion: nil)
    }
}
// MARK :- LiMessageActionsDelegate
extension LiMessageViewController: LiMessageActionsDelegate {
    func acceptSolution(messageId: String) {
        LiClientService.sharedInstance.acceptAnswer(messageId: messageId, delegate: self)
    }
    func updateHeight(index: IndexPath, newHeight: CGFloat, cellType: LiMessageType) {
        guard let msgObj = messageObject else {
            return
        }
        switch cellType {
        case .originalMessage:
            if msgObj.contentHeightsOriginalMessage[index.row] != 0.0 {
                return
            }
            msgObj.contentHeightsOriginalMessage[index.row] = newHeight
        case .accepted:
            if msgObj.contentHeightsAcceptedSolutions[index.row] != 0.0 && msgObj.contentHeightsAcceptedSolutions[index.row] == newHeight {
                return
            }
            msgObj.contentHeightsAcceptedSolutions[index.row] = newHeight
        case .discussion:
            if msgObj.contentHeightsDiscussion[index.row] != 0.0 && msgObj.contentHeightsDiscussion[index.row] == newHeight {
                return
            }
            msgObj.contentHeightsDiscussion[index.row] = newHeight
        }
        tableView.beginUpdates()
        tableView.reloadRows(at: [index], with: .automatic)
        tableView.endUpdates()
    }
    func perform(kudo: Bool, messageId: String) {
        if kudo {
            LiClientService.sharedInstance.kudoMessage(messageId: messageId, delegate: self)
        } else {
            LiClientService.sharedInstance.unKudoMessage(messageId: messageId, delegate: self)
        }
    }
    func openOptionsMenuFor(messageId: String) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: LiHelperFunctions.localizedString(for: "Cancel"), style: .cancel) { _ in }
        alertController.addAction(cancelAction)
        let shareAction = UIAlertAction(title: LiHelperFunctions.localizedString(for: "Share post"), style: .default) { _ in
            if let shareURL = URL(string: self.messageObject?.originalMessage.viewHref ?? "") {
                let vc = UIActivityViewController(activityItems: [shareURL], applicationActivities: [])
                self.present(vc, animated: true)
            }
        }
        let replyAction = UIAlertAction(title: LiHelperFunctions.localizedString(for: "Reply to post"), style: .default) { _ in
            self.performReplyAction(id: messageId)
        }
        if LiSDKManager.shared().authManager.isUserLoggedIn() {
            if let userId = LiSDKManager.shared().authState.userId {
                let reportAction = UIAlertAction(title: LiHelperFunctions.localizedString(for: "Report inappropriate content"), style: .default) { _ in
                    let vc = LiReportAbuseViewController(messageId: messageId, userId: userId)
                    let navC = UINavigationController(rootViewController: vc)
                    self.present(navC, animated: true, completion: nil)
                }
                if let _ = messageObject?.canDeleteMessage(messageId: messageId) {
                    let deleteAction = UIAlertAction(title: LiHelperFunctions.localizedString(for: "Delete"), style: .destructive) { _ in
                        self.onDelete(messageId: messageId)
                    }
                    alertController.addAction(deleteAction)
                }
                alertController.addAction(reportAction)
            }
        }
        alertController.addAction(replyAction)
        alertController.addAction(shareAction)
        self.present(alertController, animated: true)
        alertController.view.tintColor = LiUISDKManager.sharedInstance.globalTintColor
    }
    
    func onDelete(messageId: String) {
        let alertController = UIAlertController(title: LiHelperFunctions.localizedString(for: "Delete message"), message: LiHelperFunctions.localizedString(for: "Are you sure you want to delete this message?"), preferredStyle: .alert)
        let yesAction = UIAlertAction(title: LiHelperFunctions.localizedString(for: "Yes"), style: .default) { (action:UIAlertAction!) in
            LiClientService.sharedInstance.deleteMessage(messageId: messageId, includeReplies: messageId == self.originalMessageId ? true : false, delegate: self)
        }
        alertController.addAction(yesAction)
        let noAction = UIAlertAction(title: LiHelperFunctions.localizedString(for: "No"), style: .cancel) { (action:UIAlertAction!) in
        }
        alertController.addAction(noAction)
        self.present(alertController, animated: true, completion:nil)
    }
}

extension LiMessageViewController: LiClientServiceProtocol {
    func reloadTable() {
        self.tableView.reloadData()
    }
    public func success(client: LiClient, result: [LiBaseModel]?) {
        switch client {
        case .liMessageDeleteClient(_):
            self.getData()
        case .liRepliesClient:
            guard let data = result as? [LiMessage], data.count > 0 else {
                self.navigationController?.popViewController(animated: true)
                return
            }
            if let messageId = originalMessageId {
                LiClientService.sharedInstance.registerEvent(type: LiEventsType.conversation, id: messageId, delegate: self)
            }
            self.messageObject = LiMessageViewModel(data: data)
            self.postDataUISetup()
        case .liKudoClient(let requestParams):
            guard let message = result?.first as? LiMessage else {
                return
            }
            DispatchQueue.main.async {
                let indexPath =  self.messageObject?.kudoSolution(messageId: requestParams.messageId, kudo: true, weight: message.weight ?? 1)
                self.tableView.reloadRows(at: [indexPath!], with: .none)
            }
        case .liUnKudoClient(let requestParams):
            guard let message = result?.first as? LiMessage else {
                return
            }
            DispatchQueue.main.async {
                let indexPath = self.messageObject?.kudoSolution(messageId: requestParams.messageId, kudo: false, weight: message.weight ?? 1)
                self.tableView.reloadRows(at: [indexPath!], with: .none)
            }
        case .liAcceptSolutionClient(let requestParams):
            messageObject?.acceptSolution(messageId: requestParams.messageId)
            self.reloadTable()
        case .liReportAbuseClient:
            let alertController = UIAlertController(title: nil, message: LiHelperFunctions.localizedString(for: "Message successfully reported."), preferredStyle: .alert)
            let action = UIAlertAction(title: LiHelperFunctions.localizedString(for: "Ok"), style: .default, handler: { _ in
                self.getData()
            })
            alertController.addAction(action)
            self.present(alertController, animated: true)
        case .liBeaconClient:
            return
        default:
            break
        }
    }
    public func failure(client: LiClient?, errorMessage: String) {
        guard let client = client else {
            stopActivityIndicator()
            self.popupAlertWithSingleAction(title: "", message: errorMessage, actionTitle: LiHelperFunctions.localizedString(for: "Ok")) { (_) in }
            return
        }
        switch client {
        case .liBeaconClient(_):
            print("Beacon call failed with error - \(errorMessage)")
            break
        default:
            stopActivityIndicator()
            self.popupAlertWithSingleAction(title: "", message: errorMessage, actionTitle: LiHelperFunctions.localizedString(for: "Ok")) { (_) in }
        }
    }
}
