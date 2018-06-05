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
public struct LiTopicNameTableViewCellModel {
    let topicText: String?
    let isReply: Bool
}

public enum LiUIError: Error {
    case cellModelNotSet
    case userIdCannotBeNil
    case homeViewControllerFailedToLoad
}
/// TableViewCell to display/edit the topic name.
class LiTopicNameTableViewCell: UITableViewCell, Reusable, UITextFieldDelegate {
    var cellModel: LiTopicNameTableViewCellModel? {
        didSet {
            guard let model = cellModel else {
                assert(cellModel == nil, "Cell model is not set")
                return
            }
            txtTopicName.text = model.topicText
            if model.isReply {
                txtTopicName.isEnabled = false
                txtTopicName.textColor = LiUIConstants.Colors.fadedGray
            }
        }
    }
    var lblTopic: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.lightGray
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = LiHelperFunctions.localizedString(for: "Topic:")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentHuggingPriority(1000, for: .horizontal)
        return label
    }()
    var txtTopicName: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.placeholder = LiHelperFunctions.localizedString(for: "Topic name")
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        addUIConstrains()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupUI() {
        contentView.addSubview(lblTopic)
        contentView.addSubview(txtTopicName)
    }
    func addUIConstrains() {
        let marginGuide = contentView.layoutMarginsGuide
        // lblTopic constrains
        lblTopic.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        lblTopic.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        lblTopic.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
        contentView.heightAnchor.constraint(equalToConstant: 44).isActive = true //determines the height of the cell
        // txtTopicName constrains
        txtTopicName.leadingAnchor.constraint(equalTo: lblTopic.trailingAnchor, constant: 8).isActive = true
        txtTopicName.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        txtTopicName.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        txtTopicName.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
    }
}
