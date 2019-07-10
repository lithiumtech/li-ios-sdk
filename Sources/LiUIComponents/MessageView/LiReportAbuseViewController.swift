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
class LiReportAbuseViewController: UIViewController, UITextViewDelegate, LiClientServiceProtocol {
    var messageId: String
    var userId: String
    var cancelItem: LiBarButton!
    var reportItem: LiBarButton!
    var lblDescription: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight(rawValue: 0.4))
        label.numberOfLines = 0
        label.text = LiHelperFunctions.localizedString(for: "Tell us why you believe this content is inappropriate.")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var txtReportAbuseTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 15)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = UIColor.white
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.borderWidth = 1.0
        textView.textAlignment = .natural
        return textView
    }()
    init(messageId: String, userId: String) {
        self.messageId = messageId
        self.userId = userId
        super.init(nibName: nil, bundle: nil)
    }
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(txtReportAbuseTextView)
        view.addSubview(lblDescription)
        setupNavigationController()
        setupLabel()
        setupTextView()
        txtReportAbuseTextView.delegate = self
        automaticallyAdjustsScrollViewInsets = false
        txtReportAbuseTextView.becomeFirstResponder()
    }
    func setupLabel() {
        lblDescription.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        lblDescription.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
        lblDescription.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 72).isActive = true
    }
    func setupTextView() {
        txtReportAbuseTextView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        txtReportAbuseTextView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
        txtReportAbuseTextView.topAnchor.constraint(equalTo: lblDescription.bottomAnchor, constant: 16).isActive = true
        txtReportAbuseTextView.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }
    func setupNavigationController() {
        self.navigationItem.title = LiHelperFunctions.localizedString(for: "Report abuse")
        self.navigationController?.navigationBar.tintColor = LiUISDKManager.sharedInstance.globalTintColor
        cancelItem = LiBarButton(barButtonSystemItem: .cancel, target: self, action: #selector(LiReportAbuseViewController.onCancel))
        reportItem = LiBarButton(title: LiHelperFunctions.localizedString(for: "Submit"), style: .plain, target: self, action: #selector(LiReportAbuseViewController.onSubmit))
        reportItem.isEnabled = false
        self.navigationItem.setLeftBarButton(cancelItem, animated: true)
        self.navigationItem.setRightBarButton(reportItem, animated: true)
    }
    @objc func onCancel() {
        self.dismiss(animated: true, completion: nil)
    }
    @objc func onSubmit() {
        txtReportAbuseTextView.resignFirstResponder()
        LiClientService.sharedInstance.markAbuse(messageId: messageId, userId: userId, body: txtReportAbuseTextView.text, delegate: self)
    }
    func success(client: LiClient, result: [LiBaseModel]?) {
        self.popupAlertWithSingleAction(title: LiHelperFunctions.localizedString(for: "Report submitted"), message: "", actionTitle: LiHelperFunctions.localizedString(for: "Ok")) { (_) in
            self.dismiss(animated: true, completion: nil)
        }
    }
    func failure(client: LiClient?, errorMessage: String) {
        self.popupAlertWithSingleAction(title: LiHelperFunctions.localizedString(for: "Error"), message: errorMessage, actionTitle: LiHelperFunctions.localizedString(for: "Ok")) { (_) in }
    }
    public func textViewDidBeginEditing(_ textView: UITextView) {
        reportItem.isEnabled = true
    }
}
