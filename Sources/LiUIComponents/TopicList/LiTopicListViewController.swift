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
open class LiTopicListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var messages: [LiMessage] = []
    var activityIndicatorView: UIActivityIndicatorView!
    override open func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        registerCells()
        activityIndicatorView = UIActivityIndicatorView(style: .gray)
        activityIndicatorView.hidesWhenStopped = true
    }
    func registerCells() {
        tableView.registerReusableCellWithNib(LiTopicTableViewCell.self)
    }
    func showEmptyMessageScreen() {
        let noDataLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
        noDataLabel.text = LiHelperFunctions.localizedString(for: "No results found.")
        noDataLabel.textColor = UIColor.gray
        noDataLabel.textAlignment = .center
        tableView.backgroundView = noDataLabel
        tableView.separatorStyle = .none
    }
    func removeEmptyMessageScreen() {
        tableView.backgroundView = nil
    }
    func startActivityIndicator() {
        tableView.backgroundView = activityIndicatorView
        activityIndicatorView.startAnimating()
    }
    func stopActivityIndicator() {
        activityIndicatorView.stopAnimating()
    }
}

extension LiTopicListViewController: UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(indexPath: indexPath) as LiTopicTableViewCell
        cell.model = LiTopicCellModel(message: messages[indexPath.row])
        return cell
    }
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75.0
    }
}
