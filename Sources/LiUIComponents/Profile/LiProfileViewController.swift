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
public class LiProfileViewController: UIViewController {
    var profileTableView: UITableView!
    var activityIndicatorView: UIActivityIndicatorView!
    var model: LiHomeModel?
    var user: LiUser?
    var isSSOLogin = false
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    init(user: LiUser) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override public func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        addTableViewConstrains()
        setupNavigationController()
        registerCells()
        setupActivityIndicator()
    }
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getData()
        model = LiHomeModel()
    }
    func setupActivityIndicator() {
        activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityIndicatorView.hidesWhenStopped = true
    }
    func startActivityIndicator() {
        profileTableView.backgroundView = activityIndicatorView
        activityIndicatorView.startAnimating()
    }
    func stopActivityIndicator() {
        activityIndicatorView.stopAnimating()
    }
    func getData() {
        startActivityIndicator()
        LiClientService.sharedInstance.getUserActivity(delegate: self)
        if user == nil {
            LiClientService.sharedInstance.getUserDetails(delegate: self)
        } else {
            if let userId = user?.id {
                LiClientService.sharedInstance.registerEvent(type: .user, id: "\(userId)", delegate: self)
            }
        }
    }
    func registerCells() {
        profileTableView.registerReusableCell(LiProfileTableViewCell.self)
        profileTableView.registerReusableCellWithNib(LiTopicTableViewCell.self)
    }
    func setupTableView() {
        profileTableView = UITableView()
        self.view.addSubview(profileTableView)
        profileTableView.dataSource = self
        profileTableView.delegate = self
        profileTableView.estimatedRowHeight = 64.0
        profileTableView.rowHeight = UITableViewAutomaticDimension
    }
    func addTableViewConstrains() {
        profileTableView.translatesAutoresizingMaskIntoConstraints = false
        profileTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        profileTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        profileTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    func setupNavigationController() {
        self.navigationItem.title = LiHelperFunctions.localizedString(for: "Profile")
        self.navigationController?.navigationBar.tintColor = LiUISDKManager.sharedInstance.globalTintColor
        let cancelItem = LiBarButton(barButtonSystemItem: .cancel, target: self, action: #selector(LiProfileViewController.onCancel))
        let signOutItem = LiBarButton(title: LiHelperFunctions.localizedString(for: "Sign out"), style: .plain, target: self, action: #selector(LiProfileViewController.onSignOut))
        self.navigationItem.setLeftBarButton(cancelItem, animated: true)
        if !isSSOLogin {
            self.navigationItem.setRightBarButton(signOutItem, animated: true)
        }
        profileTableView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor).isActive = true
    }
    func onCancel() {
        self.dismiss(animated: true, completion: nil)
    }
    func onSignOut() {
        LiSDKManager.shared().authManager.logoutUser()
        self.dismiss(animated: true, completion: nil)
    }
}

extension LiProfileViewController: UITableViewDataSource, UITableViewDelegate {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return model?.userMessages?.count ?? 0
        }
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(indexPath: indexPath) as LiProfileTableViewCell
            if let userName = user?.login {
                cell.cellModel = LiProfileTableViewCellModel(username: userName)
                if let urlString = user?.avatar?.profile {
                    let authorImageUrl = urlString.validateHttps()
                    LiImageLoader.sharedInstance.obtainImageWithUrl(imageUrl: authorImageUrl) { (image, error) in
                        if let updateCell = tableView.cellForRow(at: indexPath) as? LiProfileTableViewCell {
                            if let err = error {
                                print(err)
                            }
                            DispatchQueue.main.async {
                                updateCell.imgProfile.image = image
                            }
                        }
                    }
                }
            }
            return cell
        } else {
            guard let messages = model?.userMessages else {
                let cell = UITableViewCell()
                return cell
            }
            let cell = tableView.dequeueReusableCell(indexPath: indexPath) as LiTopicTableViewCell
            cell.model = LiTopicCellModel(message: messages[indexPath.row])
            if let urlString = messages[indexPath.row].author?.avatar?.profile {
                let authorImageUrl = urlString.validateHttps()
                LiImageLoader.sharedInstance.obtainImageWithUrl(imageUrl: authorImageUrl) { (image, error) in
                    if let updateCell = tableView.cellForRow(at: indexPath) as? LiTopicTableViewCell {
                        if let err = error {
                            print(err)
                        }
                        DispatchQueue.main.async {
                            updateCell.imgUserImage.image = image
                        }
                    }
                }
            } else {
                cell.imgUserImage.image = LiUIConstants.defaultProfileImage
            }
            return cell
        }
    }
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return UITableViewAutomaticDimension
        default:
            return 75.0
        }
    }
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 1:
            guard let userMessages = model?.userMessages, !userMessages.isEmpty else {
                return nil
            }
            return headerView(withText: "My Activity")
        default:
            return nil
        }
    }
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 1:
            guard let userMessages = model?.userMessages, !userMessages.isEmpty else {
                return CGFloat.leastNonzeroMagnitude
            }
            return 65.0
        default:
            return CGFloat.leastNonzeroMagnitude
        }
    }
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 1:
            guard let id = model?.userMessages?[indexPath.row].id else {
                return
            }
            guard let vc = UIStoryboard.init(name: "LiMessageViewController", bundle: Bundle(for: LiHomeViewController.self)).instantiateInitialViewController() as? LiMessageViewController else { return }
            vc.originalMessageId = id
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }
    func headerView(withText text: String) -> UIView {
        let headerText = LiHelperFunctions.localizedString(for: text)
        let headerView = UIView()
        headerView.backgroundColor = .white
        let label = UILabel()
        label.frame = CGRect(x: 15, y: 30, width: 200, height: 20)
        label.text = headerText
        label.font = UIFont.systemFont(ofSize: 20)
        headerView.addSubview(label)
        return headerView
    }
}

extension LiProfileViewController: LiClientServiceProtocol {
    public func success(client: LiClient, result: [LiBaseModel]?) {
        switch client {
        case .liUserMessagesClient:
            guard let data = result  else {
                assert(result == nil, "Call returned no results.")
                return
            }
            model = self.model?.setUserMessages(data: data)
        case .liUserDetailsClient:
            guard let data = result?.first as? LiUser else {
                assert(result == nil, "Call returned no results.")
                return
            }
            user = data
            if let userId = user?.id {
                LiClientService.sharedInstance.registerEvent(type: .user, id: "\(userId)", delegate: self)
            }
        case .liBeaconClient:
            return
        default:
            break
        }
        stopActivityIndicator()
        profileTableView.reloadData()
    }
    public func failure(client: LiClient?, errorMessage: String) {
        guard let client = client else {
            stopActivityIndicator()
            self.popupAlertWithSingleAction(title: "", message: errorMessage, actionTitle: LiHelperFunctions.localizedString(for: "Ok")) { (_) in }
            return
        }
        switch client {
        case .liBeaconClient(_):
            print("Beacon call failed with error - \(errorMessage)")
            break
        default:
            stopActivityIndicator()
            self.popupAlertWithSingleAction(title: "", message: errorMessage, actionTitle: LiHelperFunctions.localizedString(for: "Ok")) { (_) in }
        }
    }
}
