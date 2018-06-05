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

import Foundation
import UIKit

protocol Reusable: class {
    static var reuseIdentifier: String { get }
    static var nib: UINib? { get }
}

extension Reusable {
    static var reuseIdentifier: String { return String(describing: self) }
    static var nib: UINib? { return nil }
}
//MARK:- TABLEVIEW
extension UITableView {
    func registerReusableCellWithNib<T: UITableViewCell>(_: T.Type) where T: Reusable {
        let nib = UINib(nibName: T.reuseIdentifier, bundle: Bundle(for: T.self))
        self.register(nib, forCellReuseIdentifier: T.reuseIdentifier)
    }
    func registerReusableCell<T: UITableViewCell>(_: T.Type) where T: Reusable {
        if let nib = T.nib {
            self.register(nib, forCellReuseIdentifier: T.reuseIdentifier)
        } else {
            self.register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
        }
    }
    func dequeueReusableCell<T: UITableViewCell>(indexPath: IndexPath) -> T where T: Reusable {
        // swiftlint:disable:next force_cast
        return self.dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }
    func registerReusableHeaderFooterViewWithNib<T: UITableViewHeaderFooterView>(_: T.Type) where T: Reusable {
        let nib = UINib(nibName: T.reuseIdentifier, bundle: Bundle(for: T.self))
        self.register(nib, forHeaderFooterViewReuseIdentifier: T.reuseIdentifier)
    }
    func registerReusableHeaderFooterView<T: UITableViewHeaderFooterView>(_: T.Type) where T: Reusable {
        if let nib = T.nib {
            self.register(nib, forHeaderFooterViewReuseIdentifier: T.reuseIdentifier)
        } else {
            self.register(T.self, forHeaderFooterViewReuseIdentifier: T.reuseIdentifier)
        }
    }
    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>() -> T where T: Reusable {
        // swiftlint:disable:next force_cast
        return self.dequeueReusableHeaderFooterView(withIdentifier: T.reuseIdentifier) as! T
    }
}
//MARK:- ARRAY
extension Array {
    var tail: Array {
        return Array(self.dropFirst())
    }
}
//MARK:- ALERT VIEW
extension UIViewController {
    func popupAlertWithMultipleActions(title: String?, message: String?, actionTitles: [String?], actions: [((UIAlertAction) -> Void)?]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for (index, title) in actionTitles.enumerated() {
            let action = UIAlertAction(title: title, style: .default, handler: actions[index])
            alert.addAction(action)
        }
        self.present(alert, animated: true, completion: nil)
    }
    func popupAlertWithNoAction(title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
    }
    func popupAlertWithSingleAction(title: String?, message: String?, actionTitle: String, actions: @escaping (UIAlertAction) -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: actionTitle, style: .default, handler: actions)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}
//MARK:- NSLAYOUT CONSTRAINS
extension NSLayoutConstraint {
    override open var description: String {
        let id = identifier ?? ""
        return "id: \(id), constant: \(constant)"
    }
}

//MARK:- STRING 
extension String {
    ///method to find and replace url starting with http, with https.
    func validateHttps() -> String {
        if self.hasPrefix("https://") {
            return self
        } else if self.hasPrefix("http://") {
            return self.replacingOccurrences(of: "http://", with: "https://")
        } else {
            return self
        }
    }
}
