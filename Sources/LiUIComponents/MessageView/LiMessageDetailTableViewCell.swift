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

protocol LiMessageActionsDelegate: class {
    func acceptSolution(messageId: String)
    func updateHeight(index: IndexPath, newHeight: CGFloat, cellType: LiMessageType)
    func perform(kudo: Bool, messageId: String)
    func openOptionsMenuFor(messageId: String)
}
enum LiMessageType {
    case originalMessage
    case accepted
    case discussion
}
public struct LiMessageDetailTableViewCellModel {
    var messageId: String?
    var authorName: String
    var messageAge: String
    var messageTitle: String
    var messageBodyHtml: String
    var canKudo: Bool
    var didKudo: Bool
    var kudoIcon: UIImage
    var kudoCount: String
    var canAccept: Bool
    var isSolution: Bool
    var acceptIcon: UIImage?
    var acceptBtnText: String?
    var boardId: String?
    var messageType: LiMessageType
    var indexPath: IndexPath
    init(data: LiMessage, type: LiMessageType, index: IndexPath) {
        messageTitle = data.subject ?? ""
        authorName = data.author?.login ?? ""
        if authorName == "" {
            authorName = LiHelperFunctions.localizedString(for: "anonymous")
        }
        messageAge = LiHelperFunctions.timeSince(post: data.postTime)
        kudoCount = "\(data.kudos?.weight ?? 0)"
        indexPath = index
        messageType = type
        canKudo = data.userContext?.canKudo ?? false
        if canKudo {
            if let kudoDone = data.userContext?.kudo, kudoDone {
                self.didKudo = kudoDone
                kudoIcon = UIImage(named: "li-unKudo", in: Bundle(for: LiMessageDetailTableViewCell.self), compatibleWith: nil)!
            } else {
                self.didKudo = false
                kudoIcon = UIImage(named: "li-Kudo", in: Bundle(for: LiMessageDetailTableViewCell.self), compatibleWith: nil)!
            }
        } else {
            self.didKudo = false
            kudoIcon = UIImage(named: "li-Kudo", in: Bundle(for: LiMessageDetailTableViewCell.self), compatibleWith: nil)!
        }
        canAccept = data.canAcceptSolution ?? false
        if canAccept {
            if let isSolution = data.isAcceptedSolution, isSolution {
                self.isSolution = isSolution
                acceptIcon = UIImage(named: "li-icon_accept_solution_selected", in: Bundle(for: LiMessageDetailTableViewCell.self), compatibleWith: nil)
                acceptBtnText = LiHelperFunctions.localizedString(for: "Accepted Solution")
            } else {
                self.isSolution = false
                acceptIcon = UIImage(named: "li-icon_accept_solution", in: Bundle(for: LiMessageDetailTableViewCell.self), compatibleWith: nil)
                acceptBtnText = LiHelperFunctions.localizedString(for: "Accept as Solution")
            }
        } else {
            self.isSolution = false
        }
        self.messageId = data.id
        if let filepath = Bundle(for: LiMessageDetailTableViewCell.self).path(forResource: "li_message_template", ofType: "html") {
            do {
                let contents = try String(contentsOfFile: filepath)
                messageBodyHtml = contents.replacingOccurrences(of: "%1$s", with: data.body ?? "")
            } catch let error {
                print(error.localizedDescription)
                messageBodyHtml = data.body ?? ""
            }
        } else {
            messageBodyHtml = data.body ?? ""
            print("message_template file not found")
        }
    }
}
class LiMessageDetailTableViewCell: UITableViewCell, Reusable, UIWebViewDelegate {
    @IBOutlet weak var imgAuthorImage: UIImageView!
    @IBOutlet weak var lblMessageTitle: UILabel!
    @IBOutlet weak var webViewMessageDetail: UIWebView!
    @IBOutlet weak var lblAuthorName: UILabel!
    @IBOutlet weak var lblMessageAge: UILabel!
    @IBOutlet weak var constrainHeightOfWebView: NSLayoutConstraint!
    @IBOutlet weak var constrainAuthorImageWidth: NSLayoutConstraint!
    @IBOutlet weak var lblKudo: UILabel!
    @IBOutlet weak var btnKudo: LiButton!
    @IBOutlet weak var constrainSpaceFromTitleToAuthorLabel: NSLayoutConstraint!
    var constrainVerticalSpacingBetweenSuperviweTopAndAutherLabel: NSLayoutConstraint!
    var cellModel: LiMessageDetailTableViewCellModel? {
        didSet {
            guard let model = cellModel else {
                assert(cellModel == nil, "Cell model is not set")
                return
            }
            lblMessageTitle.text = model.messageTitle
            lblAuthorName.text = model.authorName
            lblMessageAge.text = model.messageAge
            if model.canKudo {
                btnKudo.isEnabled = true
                btnKudo.setImage(model.kudoIcon, for: .normal)
            } else {
                btnKudo.isEnabled = false
                btnKudo.setImage(model.kudoIcon, for: .normal)
            }
            lblKudo.text = model.kudoCount
            webViewMessageDetail.loadHTMLString(model.messageBodyHtml, baseURL: nil)
        }
    }
    weak var delegate: LiMessageActionsDelegate?
    var heightOfWebView: CGFloat = 0.0
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        webViewMessageDetail.delegate = self
    }
    func setupUI() {
        imgAuthorImage.layer.cornerRadius = constrainAuthorImageWidth.constant / 2
        imgAuthorImage.layer.masksToBounds = true
        lblMessageTitle.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight(rawValue: 0.65))
        lblMessageAge.textColor = .lightGray
        webViewMessageDetail.scrollView.bounces = false
    }
    func updateHeightConstrain() {
        constrainHeightOfWebView.constant = heightOfWebView
        self.layoutSubviews()
    }
    //MARK:- Button actions
    @IBAction func onKudo(_ sender: UIButton) {
        guard let model = cellModel else {
            assert(cellModel == nil, "Cell model is not set")
            return
        }
        guard let id = model.messageId else {
            assert(model.messageId == nil, "messege id cannot be nil")
            return
        }
        sender.isEnabled = false
        delegate?.perform(kudo: !model.didKudo, messageId: id)
    }
    @IBAction func onOptions(_ sender: UIButton) {
        guard let model = cellModel, let id = model.messageId else { return }
        delegate?.openOptionsMenuFor(messageId: id)
    }
    //MARK:- WEBVIEW DELEGATE
    func webViewDidFinishLoad(_ webView: UIWebView) {
        let heightInString = webView.stringByEvaluatingJavaScript(from: "document.body.scrollHeight") ?? ""
        guard let heightInFloat = Float(heightInString) else { return }
        guard let index = cellModel?.indexPath else {return}
        guard let cellType = cellModel?.messageType  else { return }
        delegate?.updateHeight(index: index, newHeight: CGFloat(heightInFloat), cellType: cellType)
    }
}
