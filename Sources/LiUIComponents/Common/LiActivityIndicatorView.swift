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
///Activity Indicator view
class LiActivityIndicatorView {
    public static let sharedInstance = LiActivityIndicatorView()
    let activityIndicatorView = UIActivityIndicatorView()
    let restorationIdentifier = "activityIndicatorViewIdentifier"
    var containerView: UIView = UIView()
    private init() {}
    func start(view: UIView?) {
        if let contentView = view {
            containerView = contentView
            containerView.translatesAutoresizingMaskIntoConstraints = false
        } else {
            containerView = UIView(frame: UIScreen.main.bounds)
            containerView.translatesAutoresizingMaskIntoConstraints = false
        }
        containerView.restorationIdentifier = restorationIdentifier
        activityIndicatorView.style = .gray
        activityIndicatorView.startAnimating()
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(activityIndicatorView)
        applyConstrains()
        guard let keyWindow = UIApplication.shared.keyWindow else { return }
        keyWindow.addSubview(containerView)
        applyConstrains(to: keyWindow)
    }
    func stop() {
        guard let keyWindow = UIApplication.shared.keyWindow else { return }
        for item in keyWindow.subviews where item.restorationIdentifier == restorationIdentifier {
                item.removeFromSuperview()
        }
    }
    func applyConstrains() {
        let xConstraint = NSLayoutConstraint(item: containerView, attribute: .centerX, relatedBy: .equal, toItem: activityIndicatorView, attribute: .centerX, multiplier: 1, constant: 0)
        let yConstraint = NSLayoutConstraint(item: containerView, attribute: .centerY, relatedBy: .equal, toItem: activityIndicatorView, attribute: .centerY, multiplier: 1, constant: 0)
        containerView.addConstraints([xConstraint, yConstraint])
    }
    func applyConstrains(to keyWindow: UIWindow) {
        let leadingConstraint = NSLayoutConstraint(item: keyWindow, attribute: .leading, relatedBy: .equal, toItem: containerView, attribute: .leading, multiplier: 1, constant: 0)
        let trailingConstraint = NSLayoutConstraint(item: keyWindow, attribute: .trailing, relatedBy: .equal, toItem: containerView, attribute: .trailing, multiplier: 1, constant: 0)
        let topConstraint = NSLayoutConstraint(item: keyWindow, attribute: .top, relatedBy: .equal, toItem: containerView, attribute: .top, multiplier: 1, constant: 0)
        let bottomConstraint = NSLayoutConstraint(item: keyWindow, attribute: .bottom, relatedBy: .equal, toItem: containerView, attribute: .bottom, multiplier: 1, constant: 0)
        keyWindow.addConstraints([leadingConstraint, trailingConstraint, topConstraint, bottomConstraint])
    }
}

extension UIView {
    ///Starts the activity indicator at the center of the view this method is called on.
    ///Could be blocking the view or non blocking.
    /// - parameter isBlocking: if true then it adds a view about the given view to block any action.
    func startActivityIndicator(isBlocking: Bool ) {
        if isBlocking {
            LiActivityIndicatorView.sharedInstance.start(view: nil)
        } else {
            LiActivityIndicatorView.sharedInstance.start(view: self)
        }
    }
    ///Stops the activity indicator on the given view.
    func stopActivityIndicator() {
        LiActivityIndicatorView.sharedInstance.stop()
    }
}
