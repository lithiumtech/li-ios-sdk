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
extension LiHomeViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if isSearchActive {
            return 75
        }
        switch indexPath.section {
        case 0:
            return 50
        default:
            return 75
        }
    }
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if isSearchActive {
            return nil
        }
        switch section {
        case 0:
            return nil
        case 1:
            guard let userMessages = model?.userMessages, !userMessages.isEmpty else {
                return nil
            }
            return headerView(withText: "My Activity")
        case 2:
            guard let messages = model?.messages, !messages.isEmpty else {
                return nil
            }
            return headerView(withText: "Recent Activity")
        default:
           return nil
        }
    }
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if isSearchActive {
            return CGFloat.leastNonzeroMagnitude
        }
        switch section {
        case 0:
            return CGFloat.leastNonzeroMagnitude
        case 1:
            guard let userMessages = model?.userMessages, !userMessages.isEmpty else {
                return CGFloat.leastNonzeroMagnitude
            }
            return 65.0
        case 2:
            return 65.0
        default:
            return CGFloat.leastNonzeroMagnitude
        }
    }
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isSearchActive {
            guard let id = searchTableViewController.messages[indexPath.row].id else {
                return
            }
            guard let vc = UIStoryboard.init(name: "LiMessageViewController", bundle: Bundle(for: LiHomeViewController.self)).instantiateInitialViewController() as? LiMessageViewController else { return }
            vc.originalMessageId = id
            self.navigationController?.pushViewController(vc, animated: true)
            return
        }
        switch indexPath.section {
        case 0:
            let vc = LiBrowseViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        case 1:
            guard let id = model?.userMessages?[indexPath.row].id else {
                return
            }
            guard let vc = UIStoryboard.init(name: "LiMessageViewController", bundle: Bundle(for: LiHomeViewController.self)).instantiateInitialViewController() as? LiMessageViewController else { return }
            vc.originalMessageId = id
            self.navigationController?.pushViewController(vc, animated: true)
         case 2:
            guard let id = model?.messages?[indexPath.row].id else {
                return
            }
            guard let vc = UIStoryboard.init(name: "LiMessageViewController", bundle: Bundle(for: LiHomeViewController.self)).instantiateInitialViewController() as? LiMessageViewController else { return }
            vc.originalMessageId = id
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }
}
