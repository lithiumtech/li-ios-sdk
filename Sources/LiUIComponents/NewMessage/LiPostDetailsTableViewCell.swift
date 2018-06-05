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
/// TableViewCell to display/edit the body name.
class LiPostDetailsTableViewCell: UITableViewCell, Reusable, UITextViewDelegate {
    var textViewPostDetails: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 15)
        textView.isScrollEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // Initialization code
        setupUI()
        addUIConstrains()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupUI() {
        contentView.addSubview(textViewPostDetails)
    }
    func addUIConstrains() {
        let marginGuide = contentView.layoutMarginsGuide
        // textViewPostDetails constrains
        textViewPostDetails.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        textViewPostDetails.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        textViewPostDetails.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        textViewPostDetails.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
    }
}
