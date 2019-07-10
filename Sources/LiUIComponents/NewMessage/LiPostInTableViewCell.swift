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
public struct LiPostInTableViewCellModel {
    var boardName: String?
    var boardId: String?
}
/// TableViewCell to display information about the Board the message will get posted to.
public class LiPostInTableViewCell: UITableViewCell, Reusable {
    var cellModel: LiPostInTableViewCellModel? {
        didSet {
            if let boardName = cellModel?.boardName {
                lblBoardName.textColor = .black
                lblBoardName.text = boardName
            } else {
                lblBoardName.text = LiHelperFunctions.localizedString(for: "Select board")
                lblBoardName.textColor = LiUISDKManager.sharedInstance.globalTintColor
            }
            accessoryType = .disclosureIndicator
        }
    }
    var lblPostIn: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.lightGray
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "Post in:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var lblBoardName: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 1
        label.text = ""
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        addUIConstrains()
    }
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupUI() {
        contentView.addSubview(lblPostIn)
        contentView.addSubview(lblBoardName)
    }
    func addUIConstrains() {
        let marginGuide = contentView.layoutMarginsGuide
        // lblPostIn constrains
        lblPostIn.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        lblPostIn.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        lblPostIn.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
        contentView.heightAnchor.constraint(equalToConstant: 44).isActive = true //determines the height of the cell
        // lblBoardName constrains
        lblBoardName.leadingAnchor.constraint(equalTo: lblPostIn.trailingAnchor, constant: 8).isActive = true
        lblBoardName.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
}
