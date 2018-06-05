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
public struct LiProfileTableViewCellModel {
    var username: String
}

class LiProfileTableViewCell: UITableViewCell, Reusable {
    var imageWidth: CGFloat = 64.0
    var cellModel: LiProfileTableViewCellModel? {
        didSet {
            lblUsername.text = cellModel?.username
        }
    }
    var lblUsername: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 1
        label.text = ""
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var imgProfile: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        addConstrains()
        imageSetup()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupUI() {
        contentView.addSubview(lblUsername)
        contentView.addSubview(imgProfile)
    }
    func addConstrains() {
        let marginGuide = contentView.layoutMarginsGuide
        imgProfile.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor, constant: 16).isActive = true
        imgProfile.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16).isActive = true
        imgProfile.widthAnchor.constraint(equalToConstant: imageWidth).isActive = true
        imgProfile.heightAnchor.constraint(equalToConstant: 64).isActive = true
        imgProfile.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16).isActive = true
        //Lable constrains
        lblUsername.leadingAnchor.constraint(equalTo: imgProfile.trailingAnchor, constant: 16).isActive = true
        lblUsername.centerYAnchor.constraint(equalTo: imgProfile.centerYAnchor).isActive = true
    }
    func imageSetup() {
        imgProfile.layer.borderWidth = 1.0
        imgProfile.layer.masksToBounds = false
        imgProfile.layer.borderColor = UIColor.white.cgColor
        imgProfile.layer.cornerRadius = imageWidth / 2
        imgProfile.clipsToBounds = true
    }
}
