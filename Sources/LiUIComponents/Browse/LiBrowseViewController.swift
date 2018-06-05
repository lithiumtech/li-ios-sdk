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
/// ViewController for the browse screen.
public class LiBrowseViewController: LiBaseBrowseViewController {
    var navBarTitle: (current: String, parent: String) = ("", "")
    var lblParentCategoryTitle: UILabel = UILabel()
    var lblCurrentCategoryTitle: UILabel = UILabel()
    override public func viewDidLoad() {
        super.viewDidLoad()
        browseTableView.delegate = self
        browseTableView.dataSource = self
        browseTableView.registerReusableCell(LiBrowseTableViewCell.self)
        setupActivityIndicator()
        loadData()
    }
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupNavigationBar()
    }
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    public override func viewWillDisappear(_ animated: Bool) {
        lblParentCategoryTitle.removeFromSuperview()
        lblCurrentCategoryTitle.removeFromSuperview()
    }
    ///Open new message screen.
    func onAdd() {
        let model = LiNewPost(boardId: nil, boardName: nil)
        let vc = LiNewMessageViewController(model: model)
        let navController = UINavigationController(rootViewController: vc)
        self.present(navController, animated: true, completion: nil)
    }
    ///Function to setup navigation bar titles
    func setupNavigationBar() {
        let postItem = LiBarButton(barButtonSystemItem: .add, target: self, action: #selector(LiBrowseViewController.onAdd))
        self.navigationItem.backBarButtonItem = LiBarButton(title: "", style: .plain, target: nil, action: nil)
        self.navigationItem.rightBarButtonItem = postItem
        if currentLevel == "root" {
            self.title = LiHelperFunctions.localizedString(for: "Browse community")
        } else {
            if let navigationBar = self.navigationController?.navigationBar {
                let firstFrame = CGRect(x: (navigationBar.frame.width - navigationBar.frame.width/1.7)/2, y: 0, width: navigationBar.frame.width/1.7, height: navigationBar.frame.height/2)
                let secondFrame = CGRect(x: (navigationBar.frame.width - navigationBar.frame.width/1.7)/2, y: navigationBar.frame.height/2 - 2, width: navigationBar.frame.width/1.7, height: navigationBar.frame.height/2)
                lblParentCategoryTitle.frame = firstFrame
                lblParentCategoryTitle.textAlignment = .center
                lblParentCategoryTitle.font = UIFont.systemFont(ofSize: 12)
                lblCurrentCategoryTitle.frame = secondFrame
                lblCurrentCategoryTitle.textAlignment = .center
                lblCurrentCategoryTitle.font = UIFont.systemFont(ofSize: 17)
                lblCurrentCategoryTitle.font = UIFont.systemFont(ofSize: 17, weight: 0.4)
                navigationBar.addSubview(lblParentCategoryTitle)
                navigationBar.addSubview(lblCurrentCategoryTitle)
                lblParentCategoryTitle.text = navBarTitle.parent
                lblCurrentCategoryTitle.text = navBarTitle.current
            }
        }
    }
}

extension LiBrowseViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            guard let model = model else {
                return
            }
            let vc = LiBrowseViewController()
            vc.model = model
            vc.currentLevel =  model.getNextLevel(givenCurrentLevel: currentLevel, indexPath: indexPath)
            vc.navBarTitle = model.getLevelTitle(givenCurrentLevel: currentLevel, indexPath: indexPath)
            self.navigationController?.pushViewController(vc, animated: true)
        case 1:
            guard let board = model?.getBoard(at: indexPath.row, currentLevel: currentLevel), let boardId = board.id, let boardName = board.title else {
                return
            }
            ///Board id from api has `board:` appended to it. Removing it to access the board id
            let vc = LiBoardViewController(boardId: boardId.replacingOccurrences(of: "board:", with: ""), boardName: boardName)
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }
}
