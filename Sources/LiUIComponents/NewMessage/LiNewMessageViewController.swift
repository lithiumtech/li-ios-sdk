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
///View Controller for New Post.
open class LiNewMessageViewController: LiBaseNewMessageViewController {
    var model: LiNewPost
    init(model: LiNewPost) {
        self.model = model
        super.init()
    }
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override open func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
        registerCells()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.keyboardDismissMode = .interactive
        tableView.tableFooterView = UIView(frame: .zero)
        setupToolbar()
    }
    override func registerCells() {
        super.registerCells()
        tableView.registerReusableCell(LiPostInTableViewCell.self)
    }
    func setupNavigationController() {
        self.navigationItem.title = LiHelperFunctions.localizedString(for: "New Message")
        self.navigationController?.navigationBar.tintColor = LiUISDKManager.sharedInstance.globalTintColor
        let cancelItem = LiBarButton(barButtonSystemItem: .cancel, target: self, action: #selector(LiBaseNewMessageViewController.onCancel))
        let postItem = LiBarButton(title: LiHelperFunctions.localizedString(for: "Post"), style: .plain, target: self, action: #selector(LiNewMessageViewController.onPost))
        self.navigationItem.setLeftBarButton(cancelItem, animated: true)
        self.navigationItem.setRightBarButton(postItem, animated: true)
        tableView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor).isActive = true
    }
    func setupToolbar() {
        inputAccessoryToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 50))
        let barButton = LiBarButton(barButtonSystemItem: UIBarButtonSystemItem.camera, target: self, action: #selector(LiNewMessageViewController.onAddImage))
        inputAccessoryToolbar?.tintColor = LiUISDKManager.sharedInstance.globalTintColor
        inputAccessoryToolbar?.backgroundColor = UIColor.clear
        inputAccessoryToolbar?.items = [barButton]
    }
    override func onTap(_ sender: UITapGestureRecognizer) {
        super.onTap(sender)
        let cell = tableView.cellForRow(at: IndexPath(row: 2, section: 0)) as?LiPostDetailsTableViewCell
        cell?.textViewPostDetails.becomeFirstResponder()
    }
    //Post the message.
    func onPost() {
        guard let boardId = model.boardId else {
            let alert = UIAlertController(title: LiHelperFunctions.localizedString(for: "Form incomplete"), message: LiHelperFunctions.localizedString(for: "Please select the board you want to post the message in."), preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: LiHelperFunctions.localizedString(for: "Ok"), style: .cancel, handler: nil)
            alert.addAction(cancelAction)
            self.present(alert, animated: true, completion: nil)
            return

        }
        guard model.topic != "" else {
            let alert = UIAlertController(title: LiHelperFunctions.localizedString(for: "Form incomplete"), message: LiHelperFunctions.localizedString(for: "Topic cannot be empty."), preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: LiHelperFunctions.localizedString(for: "Ok"), style: .cancel, handler: nil)
            alert.addAction(cancelAction)
            self.present(alert, animated: true, completion: nil)
            return
        }
        guard let text = textViewText, text != "" else {
            let alert = UIAlertController(title: LiHelperFunctions.localizedString(for: "Form incomplete"), message: LiHelperFunctions.localizedString(for: "Post body cannot be empty."), preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: LiHelperFunctions.localizedString(for: "Ok"), style: .cancel, handler: nil)
            alert.addAction(cancelAction)
            self.present(alert, animated: true, completion: nil)
            return
        }
        self.resignFirstResponder()
        view.startActivityIndicator(isBlocking: true)
        if imageAdded {
            LiClientService.sharedInstance.uploadImage(topic: model.topic, image: selectedImage!, imageName: imageFileName, delegate: self)
        } else {
            LiClientService.sharedInstance.postNewMessage(boardId: boardId, topic: model.topic, body: text, imageId: nil, imageName: nil, delegate: self)
        }
    }
    func postWithImage(imageId: String) {
        self.view.startActivityIndicator(isBlocking: true)
        LiClientService.sharedInstance.postNewMessage(boardId: model.boardId!, topic: model.topic, body: textViewText!, imageId: imageId, imageName: imageFileName, delegate: self)
    }
}
extension LiNewMessageViewController: LiClientServiceProtocol {
    public func success(client: LiClient, result: [LiBaseModel]?) {
        switch client {
        case .liCreateMessageClient:
            self.dismiss(animated: true, completion: nil)
        case .liUploadImageClient:
            if let imageObj = result?.first as? LiImageResponse, let imageId = imageObj.id {
                postWithImage(imageId: imageId)
            }
        case .liBeaconClient:
            return
        default:
            break
        }
        self.view.stopActivityIndicator()
    }
    public func failure(client: LiClient?, errorMessage: String) {
        self.view.stopActivityIndicator()
        self.popupAlertWithSingleAction(title: LiHelperFunctions.localizedString(for: "Error"), message: errorMessage, actionTitle: LiHelperFunctions.localizedString(for: "Ok")) { (_) in }
    }
}

extension LiNewMessageViewController: UITableViewDataSource {
    open func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageAdded ? 4:3
    }
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(indexPath: indexPath) as LiPostInTableViewCell
            cell.cellModel = LiPostInTableViewCellModel(boardName: model.boardName, boardId: model.boardId)
            cell.selectionStyle = .none
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(indexPath: indexPath) as LiTopicNameTableViewCell
            cell.cellModel = LiTopicNameTableViewCellModel(topicText: model.topic, isReply: model.isReply)
            cell.selectionStyle = .none
            cell.txtTopicName.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(indexPath: indexPath) as LiImageTableViewCell
            cell.imgPostImageView.image = selectedImage
            cell.separatorInset = UIEdgeInsets(top: 0, left: 10000, bottom: 0, right: 0)
            cell.addHeight(height: heightOfImage ?? 0)
            cell.delegate = self
            cell.selectionStyle = .none
            return cell
        default:
            let cell = tableView.dequeueReusableCell(indexPath: indexPath) as LiPostDetailsTableViewCell
            cell.separatorInset = UIEdgeInsets(top: 0, left: 10000, bottom: 0, right: 0)
            cell.selectionStyle = .none
            if imageAdded {
                cell.textViewPostDetails.inputAccessoryView = nil
                cell.textViewPostDetails.text = textViewText
            } else {
                cell.textViewPostDetails.inputAccessoryView = inputAccessoryToolbar
            }
            cell.textViewPostDetails.delegate = self
            textView = cell.textViewPostDetails
            return cell
        }
    }
}

extension LiNewMessageViewController {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let vc = LiChooseBoardViewController()
            vc.boardSelectDelegate = self
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension LiNewMessageViewController {
    func textFieldDidChange(textField: UITextField) {
        model.topic = textField.text ?? ""
    }
    public override func textViewDidChange(_ textView: UITextView) {
        super.textViewDidChange(textView)
        tableView.scrollToRow(at: IndexPath(row: 2, section: 0), at: .bottom, animated: true)
    }
}

extension LiNewMessageViewController: LiBoardSelectDelegate {
    public func didSelectBoard(boardId: String, boardName: String) {
        model.boardId = boardId.replacingOccurrences(of: "board:", with: "")
        model.boardName = boardName
        tableView.reloadData()
    }
}
