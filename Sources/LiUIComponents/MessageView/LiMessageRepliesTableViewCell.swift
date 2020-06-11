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
import WebKit

class LiMessageRepliesTableViewCell: UITableViewCell, Reusable, WKNavigationDelegate {
    @IBOutlet weak var constrainWidthOfImage: NSLayoutConstraint!
    @IBOutlet weak var btnOptions: LiButton!
    @IBOutlet weak var constrainHeightOfWebView: NSLayoutConstraint!
    @IBOutlet weak var webViewMessageDetail: WKWebView!
    @IBOutlet weak var btnAcceptIcon: LiButton!
    @IBOutlet weak var btnAccept: LiButton!
    @IBOutlet weak var imgAuthor: UIImageView!
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var lblMessageAge: UILabel!
    @IBOutlet weak var btnKudo: LiButton!
    @IBOutlet weak var lblKudo: UILabel!
    var cellModel: LiMessageDetailTableViewCellModel? {
        didSet {
            guard let model = cellModel else {
                assert(cellModel == nil, "Cell model is not set")
                return
            }
            lblUsername.text = model.authorName
            lblMessageAge.text = model.messageAge
            if model.canKudo {
                btnKudo.isEnabled = true
                btnKudo.setImage(model.kudoIcon, for: .normal)
            } else {
                btnKudo.isEnabled = false
                btnKudo.setImage(model.kudoIcon, for: .normal)
            }
            lblKudo.text = model.kudoCount
            if model.canAccept {
                btnAccept.isHidden = false
                btnAcceptIcon.isHidden = false
                btnAccept.setTitle(model.acceptBtnText, for: .normal)
                btnAcceptIcon.setImage(model.acceptIcon, for: .normal)
            } else {
                btnAccept.isHidden = true
                btnAcceptIcon.isHidden = true
            }
            webViewMessageDetail.loadHTMLString(model.messageBodyHtml, baseURL: nil)
        }
    }
    weak var delegate: LiMessageActionsDelegate?
    var heightOfWebView: CGFloat = 0.0
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        webViewMessageDetail.navigationDelegate = self
    }
    func setupUI() {
        imgAuthor.layer.cornerRadius = constrainWidthOfImage.constant / 2
        imgAuthor.layer.masksToBounds = true
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
    @IBAction func onAccept(_ sender: UIButton) {
        guard let model = cellModel, let id = model.messageId else { return }
        if model.isSolution {
           return
        }
        delegate?.acceptSolution(messageId: id)
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        guard let index = cellModel?.indexPath else {return}
        guard let cellType = cellModel?.messageType  else { return }

        webView.evaluateJavaScript("document.readyState", completionHandler: { (complete, error) in
        if complete != nil {
            webView.evaluateJavaScript("document.body.scrollHeight", completionHandler: { (height, error) in
                self.delegate?.updateHeight(index: index, newHeight: height as! CGFloat, cellType: cellType)
            })
        }

        })
    }
}
