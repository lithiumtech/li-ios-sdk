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

import Foundation
import LiCore
///ViewModel for the LiBrowseTableViewCell
public struct LiBrowseTableViewCellModel {
    let text: String?
    let image: UIImage?
    public init(data: LiBrowseModel?, indexPath: IndexPath, currentLevel: String) {
        switch indexPath.section {
        case 0:
            self.text = data?.categories[currentLevel]?[indexPath.row].title
            self.image = UIImage(named: "li-folder", in: Bundle(for: LiImageTableViewCell.self), compatibleWith: nil)
        default:
            self.text = data?.boards[currentLevel]?[indexPath.row].title
            self.image = UIImage(named: "li-discussion", in: Bundle(for: LiImageTableViewCell.self), compatibleWith: nil)
        }
    }
}
///LiBrowseTableViewCell
public class LiBrowseTableViewCell: UITableViewCell, Reusable {
    var cellModel: LiBrowseTableViewCellModel? {
        didSet {
            guard let model = cellModel, let text = model.text, let image = model.image else {
                assert(cellModel != nil, "Invalid cellModel")
                return
            }
            textLabel?.text = text
            imageView?.image = image
            accessoryType = .disclosureIndicator
        }
    }
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
