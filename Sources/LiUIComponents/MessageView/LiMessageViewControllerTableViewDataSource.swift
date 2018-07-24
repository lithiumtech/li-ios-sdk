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
extension LiMessageViewController: UITableViewDataSource {
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let msgObj = messageObject else {
            fatalError("messageObject is nil in LiMessageViewcontroller")
        }
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(indexPath: indexPath) as LiMessageDetailTableViewCell
            cell.delegate = self
            return originalMessageCell(cell: cell, indexPath: indexPath, messageObject: msgObj)
        case 1:
            let cell = tableView.dequeueReusableCell(indexPath: indexPath) as LiMessageRepliesTableViewCell
            cell.delegate = self
            if msgObj.hasSolution() {
                return acceptedSolutionCell(cell: cell, indexPath: indexPath, messageObject: msgObj)
            }
            return discussionCell(cell: cell, indexPath: indexPath, messageObject: msgObj)
        default:
            let cell = tableView.dequeueReusableCell(indexPath: indexPath) as LiMessageRepliesTableViewCell
            cell.delegate = self
            return discussionCell(cell: cell, indexPath: indexPath, messageObject: msgObj)
        }
    }
    open func numberOfSections(in tableView: UITableView) -> Int {
        return messageObject?.getNumberOfSections() ?? 0
    }
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageObject?.numberOfRowsInSection(section: section) ?? 0
    }
    private func originalMessageCell(cell: LiMessageDetailTableViewCell, indexPath: IndexPath, messageObject: LiMessageViewModel) -> LiMessageDetailTableViewCell {
        cell.cellModel = LiMessageDetailTableViewCellModel(data: messageObject.originalMessage, type: .originalMessage, index: indexPath)
        cell.heightOfWebView = messageObject.contentHeightsOriginalMessage[indexPath.row]
        if messageObject.contentHeightsOriginalMessage[indexPath.row] != 0.0 {
            cell.updateHeightConstrain()
        }
        if let urlString = messageObject.originalMessage.author?.avatar?.profile {
            let authorImageUrl = urlString.validateHttps()
            LiImageLoader.sharedInstance.obtainImageWithUrl(imageUrl: authorImageUrl) { [weak self] (image, error) in
                if let err = error {
                    print(err)
                }
                if let updateCell = self?.tableView.cellForRow(at: indexPath) as? LiMessageDetailTableViewCell {
                    DispatchQueue.main.async {
                        updateCell.imgAuthorImage.image = image
                    }
                }
            }
        } else {
            cell.imgAuthorImage.image = LiUIConstants.defaultProfileImage
        }
        return cell
    }
    private func acceptedSolutionCell(cell: LiMessageRepliesTableViewCell, indexPath: IndexPath, messageObject: LiMessageViewModel) -> LiMessageRepliesTableViewCell {
        cell.cellModel = LiMessageDetailTableViewCellModel(data:  messageObject.acceptedSolutions[indexPath.row], type: .accepted, index: indexPath)
        cell.heightOfWebView = messageObject.contentHeightsAcceptedSolutions[indexPath.row]
        if messageObject.contentHeightsAcceptedSolutions[indexPath.row] != 0.0 {
            cell.updateHeightConstrain()
        }
        if let urlString = messageObject.acceptedSolutions[indexPath.row].author?.avatar?.profile {
            let authorImageUrl = urlString.validateHttps()
            LiImageLoader.sharedInstance.obtainImageWithUrl(imageUrl: authorImageUrl) { [weak self] (image, error) in
                if let err = error {
                    print(err)
                }
                if let updateCell = self?.tableView.cellForRow(at: indexPath) as? LiMessageRepliesTableViewCell {
                    DispatchQueue.main.async {
                        updateCell.imgAuthor.image = image
                    }
                }
            }
        } else {
            cell.imgAuthor.image = LiUIConstants.defaultProfileImage
        }
        return cell
    }
    private func discussionCell(cell: LiMessageRepliesTableViewCell, indexPath: IndexPath, messageObject: LiMessageViewModel) -> LiMessageRepliesTableViewCell {
        cell.cellModel = LiMessageDetailTableViewCellModel(data:  messageObject.discussion[indexPath.row], type: .discussion, index: indexPath)
        cell.heightOfWebView = messageObject.contentHeightsDiscussion[indexPath.row]
        if messageObject.contentHeightsDiscussion[indexPath.row] != 0.0 {
            cell.updateHeightConstrain()
        }
        if let urlString = messageObject.discussion[indexPath.row].author?.avatar?.profile {
            let authorImageUrl = urlString.validateHttps()
            LiImageLoader.sharedInstance.obtainImageWithUrl(imageUrl: authorImageUrl) { [weak self] (image, error) in
                if let err = error {
                    print(err)
                }
                if let updateCell = self?.tableView.cellForRow(at: indexPath) as? LiMessageRepliesTableViewCell {
                    DispatchQueue.main.async {
                        updateCell.imgAuthor.image = image
                    }
                }
            }
        } else {
            cell.imgAuthor.image = LiUIConstants.defaultProfileImage
        }
        return cell
    }
}
