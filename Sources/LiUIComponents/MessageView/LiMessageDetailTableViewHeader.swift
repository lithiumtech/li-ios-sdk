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
// Class for header view for the LiMessageDetailViewController Cells.
class LiMessageDetailTableViewHeader: UITableViewHeaderFooterView, Reusable {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var constrainIconWidth: NSLayoutConstraint!
    func setupAcceptedSolutionsHeader() {
        let headerText = NSLocalizedString("Accepted Solution", comment: "")
        lblTitle.text = headerText
        imgIcon.image = UIImage(named: "li-icon_accept_solution_selected", in: Bundle(for: LiMessageDetailTableViewHeader.self), compatibleWith: nil)
        constrainIconWidth.constant = 25.0
    }
    func setupDiscussionHeader() {
        let headerText = NSLocalizedString("Discussion", comment: "")
        lblTitle.text = headerText
        imgIcon.image = UIImage(named: "li-discussion", in: Bundle(for: LiMessageDetailTableViewHeader.self), compatibleWith: nil)
        constrainIconWidth.constant = 20.0
    }
}
