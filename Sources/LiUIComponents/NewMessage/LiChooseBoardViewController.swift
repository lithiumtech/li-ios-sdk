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
///View controller that manages choosing of board to post in a new message.
///Inherits most of its behaviour from LiBaseBrowseViewController.
class LiChooseBoardViewController: LiBaseBrowseViewController {
    weak var boardSelectDelegate: LiBoardSelectDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        browseTableView.delegate = self
        browseTableView.dataSource = self
        browseTableView.registerReusableCell(LiBrowseTableViewCell.self)
        self.navigationItem.title = LiHelperFunctions.localizedString(for: "Post in")
        loadData()
    }
}
extension LiChooseBoardViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            guard let model = model else {
                return
            }
            let vc = LiChooseBoardViewController()
            vc.model = model
            vc.boardSelectDelegate = navigationController?.viewControllers.first as? LiNewMessageViewController
            vc.currentLevel =  model.getNextLevel(givenCurrentLevel: currentLevel, indexPath: indexPath)
            self.navigationController?.pushViewController(vc, animated: true)
        case 1:
            if let board = model?.getBoard(at: indexPath.row, currentLevel: currentLevel), let boardId = board.id, let boardName = board.title {
                boardSelectDelegate?.didSelectBoard(boardId: boardId, boardName: boardName)
            }
            self.navigationController?.popToRootViewController(animated: true)
        default:
            break
        }
    }
}
