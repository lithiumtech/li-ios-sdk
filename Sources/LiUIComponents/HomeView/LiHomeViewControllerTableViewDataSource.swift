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
extension LiHomeViewController: UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return model != nil ? 3 : 0
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.numberOfCells(inSection: section) ?? 0
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = UITableViewCell(style: .default, reuseIdentifier: reuseIdentifier)
            cell.textLabel?.text =  LiHelperFunctions.localizedString(for: "Browse community")
            cell.textLabel?.font = UIFont.systemFont(ofSize: 20)
            cell.accessoryType = .disclosureIndicator
            return cell
        case 1:
            guard let messages = model?.userMessages else {
                break
            }
            let cell = tableView.dequeueReusableCell(indexPath: indexPath) as LiTopicTableViewCell
            cell.model = LiTopicCellModel(message: messages[indexPath.row])
            if let urlString = messages[indexPath.row].author?.avatar?.profile {
                let authorImageUrl = urlString.validateHttps()
                LiImageLoader.sharedInstance.obtainImageWithUrl(imageUrl: authorImageUrl) { (image, error) in
                    if let err = error {
                        print(err)
                    }
                    if let updateCell = tableView.cellForRow(at: indexPath) as? LiTopicTableViewCell {
                        DispatchQueue.main.async {
                            updateCell.imgUserImage.image = image
                        }
                    }
                }
            } else {
                cell.imgUserImage.image = LiUIConstants.defaultProfileImage
            }
            return cell
        case 2:
            guard let messages = model?.messages else {
                break
            }
            let cell = tableView.dequeueReusableCell(indexPath: indexPath) as LiTopicTableViewCell
            cell.model = LiTopicCellModel(message: messages[indexPath.row])
            if let urlString = messages[indexPath.row].author?.avatar?.profile {
                let authorImageUrl = urlString.validateHttps()
                LiImageLoader.sharedInstance.obtainImageWithUrl(imageUrl: authorImageUrl) { (image, error) in
                    if let err = error {
                        print(err)
                    }
                    DispatchQueue.main.async {
                        if let updateCell = tableView.cellForRow(at: indexPath) as? LiTopicTableViewCell {
                            updateCell.imgUserImage.image = image
                        }
                    }
                }
            } else {
                cell.imgUserImage.image = LiUIConstants.defaultProfileImage
            }
            return cell
        default:
            break
        }
        let cell = UITableViewCell()
        return cell
    }
}
