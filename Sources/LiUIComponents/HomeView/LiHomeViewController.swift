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
open class LiHomeViewController: UIViewController {
    var searchController: UISearchController!
    var searchTableViewController: LiTopicListViewController!
    var activityIndicatorView: UIActivityIndicatorView!
    var model: LiHomeModel?
    var isSearchActive = false
    internal let reuseIdentifier = "DefaultCellForHomeViewController"
    @IBOutlet weak var homeScreenTableView: UITableView!
    @IBOutlet weak var lblCommunityName: UILabel!
    @IBOutlet weak var btnProfile: LiButton!
    @IBOutlet weak var btnAddOrSignIn: LiButton!
    var loggedInUser: LiUser?
    var communityName = LiUISDKManager.sharedInstance.communityName
    ///SSO token for sso login
    var ssoToken: String?
    var isSSOLogin: Bool = false
    ///Device token for notification
    var deviceToken: String?
    ///Notification provider
    var notificationProvider: NotificationProviders?
    /**
     This function return the instance of LiHomeViewController.
     
     - parameter isSSOLogin: True if SSO should be used for login, else false.
     - parameter ssoToken: Optional, SSO token if you are using login via SSO. If isSSOLogin is true then `nil` on ssoToken will result in anonymous browsing.
     - parameter deviceToken: Optional, device token from the `didRegisterForRemoteNotificationsWithDeviceToken` method in AppDelegate.
     - parameter notificationProvider: Optional, your notification provider. Possible values - 'APNS', 'FIREBASE'
     */
    public static func makeHomeViewController(isSSOLogin: Bool, ssoToken: String?, deviceToken: String?, notificationProvider: NotificationProviders?) -> LiHomeViewController? {
        guard let vc = UIStoryboard.init(name: "LiHomeViewController", bundle: Bundle(for: LiHomeViewController.self)).instantiateInitialViewController() as? LiHomeViewController else {
            print("Failed to inialize LiHomeViewController")
            return nil
        }
        vc.isSSOLogin = isSSOLogin
        vc.ssoToken = ssoToken
        vc.deviceToken = deviceToken
        vc.notificationProvider = notificationProvider
        return vc
    }
    override open func viewDidLoad() {
        super.viewDidLoad()
        lblCommunityName.text = communityName
        homeScreenTableView.registerReusableCellWithNib(LiTopicTableViewCell.self)
        searchTableViewController = UIStoryboard.init(name: "LiTopicListViewController", bundle: Bundle(for: LiTopicListViewController.self)).instantiateInitialViewController() as? LiTopicListViewController
        searchController = UISearchController(searchResultsController: searchTableViewController)
        searchController.searchBar.delegate = self
        searchController.delegate = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        homeScreenTableView.dataSource = self
        homeScreenTableView.delegate = self
        homeScreenTableView.tableHeaderView = self.searchController.searchBar
        self.navigationController?.navigationBar.tintColor = LiUISDKManager.sharedInstance.globalTintColor
        self.navigationItem.backBarButtonItem = LiBarButton(title: "", style: .plain, target: nil, action: nil)
    }
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        homeScreenTableView.isHidden = isSearchActive ? false : true
        setupActivityIndicator()
        LiSDKManager.shared().authManager.liLoginDelegate = self
        if LiSDKManager.shared().authManager.isUserLoggedIn() {
            setupNavBarButtons()
        } else if isSSOLogin {
            if let token = ssoToken {
                LiSDKManager.shared().authManager.initLoginFlow(from: self, withSSOToken: token, deviceToken: deviceToken, notificationProvider: notificationProvider)
            }
            btnProfile.isHidden = true
            btnAddOrSignIn.isHidden = true
        } else {
            btnAddOrSignIn.setTitle("Sign in", for: .normal)
            btnAddOrSignIn.setImage(nil, for: .normal)
            btnProfile.isHidden = true
            btnAddOrSignIn.isHidden = false
        }
        if !isSearchActive {
            model = LiHomeModel()
            getData()
        }
    }
    //MARK: Activity indicator
    func setupActivityIndicator() {
        activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityIndicatorView.hidesWhenStopped = true
    }
    func startActivityIndicator() {
        homeScreenTableView.backgroundView = activityIndicatorView
        activityIndicatorView.startAnimating()
    }
    func stopActivityIndicator() {
        activityIndicatorView.stopAnimating()
    }
    func getData() {
        // view.startActivityIndicator(isBlocking: true)
        startActivityIndicator()
        LiClientService.sharedInstance.getMessages(delegate: self)
        if LiSDKManager.shared().authManager.isUserLoggedIn() {
            LiClientService.sharedInstance.getUserActivity(delegate: self)
            LiClientService.sharedInstance.getUserDetails(delegate: self)
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
    ///Function to load profile image
    func loadProfileImage() {
        if let urlString = loggedInUser?.avatar?.profile {
            let authorImageUrl = urlString.validateHttps()
            LiImageLoader.sharedInstance.obtainImageWithUrl(imageUrl: authorImageUrl) {[weak self] (image, error) in
                if let err = error {
                    print(err)
                }
                DispatchQueue.main.async {
                    self?.btnProfile.setImage(image, for: .normal)
                }
            }
        }
    }
    ///Function that sets up action buttons for logged in user 
    func setupNavBarButtons() {
        let image = UIImage(named: "li-PlusIcon", in: Bundle(for: LiHomeViewController.self), compatibleWith: nil)
        btnAddOrSignIn.setTitle("", for: .normal)
        btnAddOrSignIn.setImage(image, for: .normal)
        btnProfile.isHidden = false
        btnAddOrSignIn.isHidden = false
        btnProfile.layer.cornerRadius = 0.5 * btnProfile.bounds.size.width
        btnProfile.clipsToBounds = true
    }
    @IBAction func onAdd(_ sender: UIButton) {
        if LiSDKManager.shared().authManager.isUserLoggedIn() {
            let vc = LiNewMessageViewController(model: LiNewPost(boardId: nil, boardName: nil))
            let navController = UINavigationController(rootViewController: vc)
            self.present(navController, animated: true, completion: nil)
        } else {
            LiSDKManager.shared().authManager.liLoginDelegate = self
            LiSDKManager.shared().authManager.initLoginFlow(from: self, deviceToken: deviceToken, notificationProvider: notificationProvider)
        }
    }
    @IBAction func onProfile(_ sender: UIButton) {
        var vc: LiProfileViewController
        if let user = loggedInUser {
            vc = LiProfileViewController(user: user)
        } else {
            vc = LiProfileViewController()
        }
        vc.isSSOLogin = isSSOLogin
        let navController = UINavigationController(rootViewController: vc)
        self.present(navController, animated: true, completion: nil)
    }
}

extension LiHomeViewController: UISearchBarDelegate {
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            DispatchQueue.main.async {
                self.searchController.searchResultsController?.view.isHidden = false
            }
        }
    }
    public func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        DispatchQueue.main.async {
            self.searchController.searchResultsController?.view.isHidden = false
        }
    }
    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let queryText = searchBar.text else {
            return
        }
        searchTableViewController.startActivityIndicator()
        LiClientService.sharedInstance.search(queryText: queryText, delegate: self)
    }
    public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearchActive = false
        searchTableViewController.messages = []
        searchTableViewController.stopActivityIndicator()
        searchTableViewController.tableView.reloadData()
        searchTableViewController.removeEmptyMessageScreen()
        homeScreenTableView.reloadData()
    }
}

extension LiHomeViewController: UISearchControllerDelegate {
    public func willPresentSearchController(_ searchController: UISearchController) {
        DispatchQueue.main.async {
            searchController.searchResultsController?.view.isHidden = false
            self.searchTableViewController.tableView.separatorStyle = .none
            self.isSearchActive = true
        }
    }
    public func didDismissSearchController(_ searchController: UISearchController) {
        DispatchQueue.main.async {
            self.navigationController?.navigationBar.isHidden = true
            self.isSearchActive = false
            self.homeScreenTableView.reloadData()
        }
    }
}

extension LiHomeViewController: LiClientServiceProtocol {
    public func success(client: LiClient, result: [LiBaseModel]?) {
        switch client {
        case .liSearchClient:
            searchTableViewController.stopActivityIndicator()
            guard let messages = result as? [LiMessage] else {
                return
            }
            if messages.isEmpty {
                searchTableViewController.showEmptyMessageScreen()
            } else {
                searchTableViewController.tableView.separatorStyle = .singleLine
            }
            searchTableViewController.messages = messages
            searchTableViewController.tableView.delegate = self
            searchTableViewController.tableView.reloadData()
            return
        case .liMessagesClient:
            guard let data = result  else {
                self.popupAlertWithSingleAction(title: "", message: LiHelperFunctions.localizedString(for: "Failed to retrive messages."), actionTitle: LiHelperFunctions.localizedString(for: "Ok"), actions: { (_) in
                })
                return
            }
            model = self.model?.setMessages(data: data)
        case .liUserMessagesClient:
            guard let data = result  else {
                self.popupAlertWithSingleAction(title: "", message: LiHelperFunctions.localizedString(for: "Failed to retrive user activity."), actionTitle: LiHelperFunctions.localizedString(for: "Ok"), actions: { (_) in
                })
                return
            }
            model = self.model?.setUserMessages(data: data)
        case .liUserDetailsClient:
            guard let data = result?.first as? LiUser else {
                self.popupAlertWithSingleAction(title: "", message: LiHelperFunctions.localizedString(for: "Failed to retrive user data."), actionTitle: LiHelperFunctions.localizedString(for: "Ok"), actions: { (_) in
                })
                return
            }
            loggedInUser = data
            loadProfileImage()
        default:
            break
        }
        stopActivityIndicator()
        homeScreenTableView.reloadData()
        homeScreenTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: UITableViewScrollPosition.top, animated: false)
        homeScreenTableView.isHidden = false
    }
    public func failure(client: LiClient?, errorMessage: String) {
        guard let client = client else {
            stopActivityIndicator()
            self.popupAlertWithSingleAction(title: "", message: errorMessage, actionTitle: LiHelperFunctions.localizedString(for: "Ok")) { (_) in }
            return
        }
        switch client {
        case .liSearchClient:
            searchTableViewController.stopActivityIndicator()
        default:
            stopActivityIndicator()
        }
        self.popupAlertWithSingleAction(title: "", message: errorMessage, actionTitle: "Ok") { (_) in }
    }
}

extension LiHomeViewController: LiAuthorizationDelegate {
    public func login(status: Bool, userId: String?, error: Error?) {
        if status {
            if isSSOLogin {
               setupNavBarButtons()
            }
            model = LiHomeModel()
            getData()
        } else {
            if let err = error as? LiBaseError {
                self.popupAlertWithSingleAction(title:  LiHelperFunctions.localizedString(for: "Login error"), message: err.errorMessage, actionTitle: LiHelperFunctions.localizedString(for: "Ok"), actions: { (_) in
                })
            } else {
                self.popupAlertWithSingleAction(title: LiHelperFunctions.localizedString(for: "Login error"), message: error?.localizedDescription ?? "Failed to sign in. Please try again.", actionTitle: LiHelperFunctions.localizedString(for: "Ok"), actions: { (_) in
                })
            }
        }
    }
}
