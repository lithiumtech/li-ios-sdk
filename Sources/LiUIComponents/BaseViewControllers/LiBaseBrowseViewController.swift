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
/// Base viewcontroller for screens that browse for boards and categories.
public class LiBaseBrowseViewController: UIViewController {
    var model: LiBrowseModel?
    var currentLevel: String = "root"
    open var browseTableView: UITableView!
    var activityIndicatorView: UIActivityIndicatorView!
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        setupTableView()
        addTableViewConstrains()
        setupActivityIndicator()
    }
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if currentLevel != "root" {
            LiClientService.sharedInstance.registerEvent(type: .node, id: currentLevel, delegate: self)
        } else {
            let root = model?.categories["root"]?.first
            if let id = root?.parent?.id {
                LiClientService.sharedInstance.registerEvent(type: .category, id: id, delegate: self)
            }
        }
    }
    func setupActivityIndicator() {
        activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityIndicatorView.hidesWhenStopped = true
    }
    func startActivityIndicator() {
        browseTableView.backgroundView = activityIndicatorView
        activityIndicatorView.startAnimating()
    }
    func stopActivityIndicator() {
        activityIndicatorView.stopAnimating()
    }
    func setupTableView() {
        browseTableView = UITableView()
        browseTableView.tableFooterView = UIView(frame: .zero)
        self.view.addSubview(browseTableView)
    }
    func addTableViewConstrains() {
        browseTableView.translatesAutoresizingMaskIntoConstraints = false
        browseTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        browseTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        browseTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        browseTableView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor).isActive = true
    }
    func loadData() {
        if let modelInilatized = model {
            if !modelInilatized.hasBoardData(forLevel: currentLevel) {
                startActivityIndicator()
                LiClientService.sharedInstance.getBoards(forCategory: currentLevel, delegate: self)
            } else {
                updateScreen()
            }
        } else {
            startActivityIndicator()
            LiClientService.sharedInstance.getCategoriesData(delegate: self)
        }
    }
    ///Get boards for root depth.
    func getTopBoards() {
        if let rootDepth = model?.getDepthOfRoot() {
            LiClientService.sharedInstance.getTopBoards(atLevel: rootDepth, delegate: self)
        }
    }
    ///Reloads data onto screen after model is updated.
    func updateScreen() {
        browseTableView.reloadData()
    }
    ///Checks if there is any board or categories are present, if not then it shows the empty screen
    func dataCheck() {
        guard let model = model else {
            return
        }
        if model.hasBoardData(forLevel: currentLevel) {
            updateScreen()
        } else if model.hasCategoriesData(forLevel: currentLevel) {
            updateScreen()
        } else {
            //MARK: - Empty results sceen
            let noDataLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: browseTableView.bounds.size.width, height: browseTableView.bounds.size.height))
            noDataLabel.text = LiHelperFunctions.localizedString(for: "No discussions yet")
            noDataLabel.textColor = UIColor.gray
            noDataLabel.textAlignment = .center
            browseTableView.backgroundView = noDataLabel
            browseTableView.separatorStyle = .none
        }
    }
}

extension LiBaseBrowseViewController: LiClientServiceProtocol {
    public func success(client: LiClient, result: [LiBaseModel]?) {
        guard let result = result else {
            return
        }
        switch client {
        case .liCategoryClient:
            model = LiBrowseModel(data: result)
            if currentLevel == "root" {
                let root = model?.categories["root"]?.first
                if let id = root?.parent?.id {
                    LiClientService.sharedInstance.registerEvent(type: .category, id: id, delegate: self)
                }
            }
            getTopBoards()
        case .liBoardsByDepthClient, .liCategoryBoardsClient:
            model?.addBoards(forLevel: currentLevel, data: result)
            dataCheck()
        case .liBeaconClient:
            print(result)
            return
        default:
            break
        }
        stopActivityIndicator()
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
            let alert = UIAlertController(title: nil, message: errorMessage, preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: LiHelperFunctions.localizedString(for: "Ok"), style: .cancel, handler: nil)
            alert.addAction(cancelAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension LiBaseBrowseViewController: UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.numberOfRows(inSection: section, atLevel: currentLevel) ?? 0
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(indexPath: indexPath) as LiBrowseTableViewCell
        cell.cellModel = LiBrowseTableViewCellModel(data: model, indexPath: indexPath, currentLevel: currentLevel)
        return cell
    }
}
