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

class LiBoardViewController: UIViewController {
    open var tableView: UITableView!
    var boardId: String
    var boardName: String
    var activityIndicatorView: UIActivityIndicatorView!
    var model: LiBoardData?
    init(boardId: String, boardName: String) {
        self.boardId = boardId
        self.boardName = boardName
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        addTableViewConstrains()
        setupNavigationBarButton()
        LiClientService.sharedInstance.registerEvent(type: .board, id: boardId, delegate: self)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupActivityIndicator()
        startActivityIndicator()
        LiClientService.sharedInstance.getMessages(forBoardId: boardId, delegate: self)
    }
    func setupActivityIndicator() {
        activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityIndicatorView.hidesWhenStopped = true
    }
    func startActivityIndicator() {
        tableView.backgroundView = activityIndicatorView
        activityIndicatorView.startAnimating()
    }
    func stopActivityIndicator() {
        activityIndicatorView.stopAnimating()
    }
    func addTableViewConstrains() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor).isActive = true
    }
    func setupTableView() {
        tableView = UITableView()
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.registerReusableCellWithNib(LiTopicTableViewCell.self)
    }
    func setupNavigationBarButton() {
        let postItem = LiBarButton(barButtonSystemItem: .add, target: self, action: #selector(LiBoardViewController.onAdd))
        self.navigationItem.rightBarButtonItem = postItem
    }
    func onAdd() {
        let model = LiNewPost(boardId: boardId, boardName: boardName)
        let vc = LiNewMessageViewController(model: model)
        let navController = UINavigationController(rootViewController: vc)
        self.present(navController, animated: true, completion: nil)
    }
    func dataCheck() {
        //MARK: - Empty results sceen
        guard let messages = model?.messages, messages.isEmpty else {
            return
        }
        let noDataLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
        noDataLabel.text = LiHelperFunctions.localizedString(for: "No discussions yet")
        noDataLabel.textColor = UIColor.gray
        noDataLabel.textAlignment = .center
        tableView.backgroundView = noDataLabel
        tableView.separatorStyle = .none
    }
}

extension LiBoardViewController: LiClientServiceProtocol {
    func success(client: LiClient, result: [LiBaseModel]?) {
        guard let result = result else {
            return
        }
        switch client {
        case .liMessagesByBoardIdClient:
            model = LiBoardData(data: result)
            LiClientService.sharedInstance.getFloatedMessages(forBoardId: boardId, delegate: self)
        case .liFloatedMessagesClient:
            model = model?.floatingData(data: result)
        case .liBeaconClient:
            return
        default:
            break
        }
        stopActivityIndicator()
        tableView.dataSource = self
        dataCheck()
        tableView.reloadData()
    }
    func failure(client: LiClient?, errorMessage: String) {
        guard let client = client else {
            stopActivityIndicator()
            self.popupAlertWithSingleAction(title: "", message: errorMessage, actionTitle: LiHelperFunctions.localizedString(for: "Ok")) { (_) in }
            return
        }
        switch client {
        case .liBeaconClient(_):
            print("Beacon call failed with error - \(errorMessage)")
            return
        default:
            stopActivityIndicator()
            let alert = UIAlertController(title: nil, message: errorMessage, preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: LiHelperFunctions.localizedString(for: "Ok"), style: .cancel, handler: nil)
            alert.addAction(cancelAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension LiBoardViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.messages.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(indexPath: indexPath) as LiTopicTableViewCell
        cell.model = LiTopicCellModel(message: model!.messages[indexPath.row])
        return cell
    }
}

extension LiBoardViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75.0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let id = model?.messages[indexPath.row].id
        guard let vc  = UIStoryboard.init(name: "LiMessageViewController", bundle: Bundle(for: LiHomeViewController.self)).instantiateInitialViewController() as? LiMessageViewController else { return }
        vc.originalMessageId = id
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
