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

// swiftlint:disable empty_count
struct LiTopicCellModel {
    var isRead: Bool
    var isPinned: Bool
    var isSolved: Bool
    var imgPinOrAcceptIcon: UIImage?
    var usernameLabelText: String
    var kudoCountLabelText: String
    var messageLabelText: String
    var arrowImage: UIImage?
    var timeSinceMessageLabelText: String
    var numerOfRepliesLabelText: String
    init(message: LiMessage) {
        usernameLabelText = message.author?.login ?? "anonymous"
        if let count = message.kudos?.weight, count > 0 {
            kudoCountLabelText = "\(count) kudos"
        } else {
            kudoCountLabelText = ""
        }
        self.messageLabelText = message.subject ?? ""
        if let count = message.replyCount, count > 0 {
            numerOfRepliesLabelText = "\(count)"
            arrowImage = UIImage(named: "li-chevron-right-multi", in: Bundle(for: LiMessageDetailTableViewCell.self), compatibleWith: nil)!
        } else {
            numerOfRepliesLabelText = ""
            arrowImage = UIImage(named: "li-chevron-right", in: Bundle(for: LiMessageDetailTableViewCell.self), compatibleWith: nil)!
        }
        timeSinceMessageLabelText = LiHelperFunctions.timeSince(post: message.postTime)
        if let readStatus = message.userContext?.isRead {
            isRead = readStatus
        } else {
            isRead = true
        }
        if let hasSolution = message.conversation?.isSolved {
            isSolved = hasSolution
        } else {
            imgPinOrAcceptIcon = nil
            isSolved = false
        }
        if let isFloated = message.isFloating {
            isPinned = isFloated
        } else {
            isPinned = false
        }
        if isSolved {
            imgPinOrAcceptIcon = UIImage(named: "li-icon_accept_solution_selected", in: Bundle(for: LiMessageDetailTableViewCell.self), compatibleWith: nil)!
        } else if isPinned {
             imgPinOrAcceptIcon = UIImage(named: "li-pin", in: Bundle(for: LiMessageDetailTableViewCell.self), compatibleWith: nil)!
        } else {
            imgPinOrAcceptIcon = nil
        }
    }
}

open class LiTopicTableViewCell: UITableViewCell, Reusable {
    @IBOutlet weak var viewUnReadMessage: UIView!
    @IBOutlet weak var imgUserImage: UIImageView!
    @IBOutlet weak var imgPinOrAcceptIcon: UIImageView!
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var imgKudoIcon: UIImageView!
    @IBOutlet weak var lblKudoCount: UILabel!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var lblNumberOfComments: UILabel!
    @IBOutlet weak var lblTimeSinceMessage: UILabel!
    @IBOutlet weak var constrainPinOrAcceptIconWidth: NSLayoutConstraint!
    @IBOutlet weak var constrainPinOrAcceptIconHeight: NSLayoutConstraint!
    @IBOutlet weak var constrainHorizontalDistanceBetweenMessageAndIcon: NSLayoutConstraint!
    var model: LiTopicCellModel! {
        didSet {
            lblMessage.text = model.messageLabelText
            lblUsername.text = model.usernameLabelText
            lblKudoCount.text = model.kudoCountLabelText
            lblTimeSinceMessage.text = model.timeSinceMessageLabelText
            lblNumberOfComments.text = model.numerOfRepliesLabelText
           // imgArrowIcon.image = model.arrowImage
            accessoryView = UIImageView(image: model.arrowImage)
            if model.isRead {
                markAsRead()
            } else {
                markAsUnread()
            }
            if model.isSolved {
                postIsSolved()
            } else if model.isPinned {
                postIsPinned()
            } else {
                postIsNitherSolvedOrPinned()
            }
        }
    }
    override open func awakeFromNib() {
        super.awakeFromNib()
        imageSetup()
    }
    func postIsPinned() {
        constrainPinOrAcceptIconWidth.constant = 11.0
        constrainPinOrAcceptIconHeight.constant = 16.0
        constrainHorizontalDistanceBetweenMessageAndIcon.constant = 5.0
        imgPinOrAcceptIcon.image = model.imgPinOrAcceptIcon
    }
    func postIsSolved() {
        constrainPinOrAcceptIconWidth.constant = 18.0
        constrainPinOrAcceptIconHeight.constant = 16.0
        constrainHorizontalDistanceBetweenMessageAndIcon.constant = 5.0
        imgPinOrAcceptIcon.image = model.imgPinOrAcceptIcon
    }
    func postIsNitherSolvedOrPinned() {
        constrainPinOrAcceptIconWidth.constant = 0.0
        constrainHorizontalDistanceBetweenMessageAndIcon.constant = 0
        imgPinOrAcceptIcon.image = nil
    }
    func imageSetup() {
        imgUserImage.layer.borderWidth = 1.0
        imgUserImage.layer.masksToBounds = false
        imgUserImage.layer.borderColor = UIColor.white.cgColor
        imgUserImage.layer.cornerRadius = imgUserImage.frame.size.width / 2
        imgUserImage.clipsToBounds = true
    }
    func markAsUnread() {
        viewUnReadMessage.layer.cornerRadius = viewUnReadMessage.frame.size.width / 2
        viewUnReadMessage.backgroundColor = LiUISDKManager.sharedInstance.globalTintColor
        viewUnReadMessage.isHidden = false
    }
    func markAsRead() {
        viewUnReadMessage.isHidden = true
    }
}
