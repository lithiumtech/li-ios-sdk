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
/// TableViewCell to display the image added to the comment/post.
class LiImageTableViewCell: UITableViewCell, Reusable {
    weak var delegate: LiImagePostDelegate?
    var imgPostImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.isUserInteractionEnabled = true
        image.contentMode = .scaleAspectFit
        return image
    }()
    var btnClose: LiButton = {
        let button = LiButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let closeImage = UIImage(named: "li-closeIcon", in: Bundle(for: LiImageTableViewCell.self), compatibleWith: nil)
        button.setImage(closeImage, for: .normal)
        //button.tintColor = .red
        return button
    }()
    override init(style: CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // Initialization code
        setupUI()
        addUIConstrains()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupUI() {
        btnClose.addTarget(self, action: #selector(onCloseButton(_:)), for: .touchUpInside)
        contentView.addSubview(imgPostImageView)
        imgPostImageView.addSubview(btnClose)
    }
    func addUIConstrains() {
        // textViewPostDetails constrains
        imgPostImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        imgPostImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        imgPostImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        imgPostImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        //btn view
        btnClose.trailingAnchor.constraint(equalTo: imgPostImageView.trailingAnchor, constant: -15).isActive = true
        btnClose.topAnchor.constraint(equalTo: imgPostImageView.topAnchor, constant: 10).isActive = true
        btnClose.heightAnchor.constraint(equalToConstant: 30).isActive = true
        btnClose.widthAnchor.constraint(equalToConstant: 30).isActive = true
    }
    func addHeight(height: CGFloat) {
        self.contentView.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    @objc func onCloseButton(_ button: UIButton) {
        delegate?.onRemoveImage()
    }
}
