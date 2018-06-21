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
import Photos
import LiCore
protocol LiImagePostDelegate: class {
    ///Method called when an image is added to a message/reply.
    func onAddImage()
    ///Method called when an image is removed from a message/reply.
    func onRemoveImage()
}
///Base view controller for New Message or Reply view controller.
open class LiBaseNewMessageViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    var inputAccessoryToolbar: UIToolbar?
    var imagePicker = UIImagePickerController()
    var imageAdded = false
    var textViewText: String?
    var textView: UITextView?
    var selectedImage: UIImage?
    var heightOfImage: CGFloat?
    var imageFileName: String = ""
    open var tableView: UITableView!
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override open func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupTableView()
        addTableViewConstrains()
        registerForKeyboardNotifiactions()
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    func registerCells() {
        tableView.registerReusableCell(LiTopicNameTableViewCell.self)
        tableView.registerReusableCell(LiPostDetailsTableViewCell.self)
        tableView.registerReusableCell(LiImageTableViewCell.self)
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
        let tapGestureToDetectTouchInEmptyArea: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.onTap(_:)))
        tapGestureToDetectTouchInEmptyArea.delegate = self
        tableView.addGestureRecognizer(tapGestureToDetectTouchInEmptyArea)
    }
    ///Action when area below the last cell in table view is tab.
    ///Sets the textView as first responder
    func onTap(_ sender: UITapGestureRecognizer) {}
    func onCancel() {
        self.dismiss(animated: true, completion: nil)
    }
}
extension LiBaseNewMessageViewController: UITableViewDelegate {
    open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    open func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
///This extention handles image related methods.
extension LiBaseNewMessageViewController: LiImagePostDelegate {
    func onRemoveImage() {
        imageAdded = false
        selectedImage =  nil
        heightOfImage = nil
        imageFileName = ""
        tableView.reloadData()
    }
    func onAddImage() {
        let actionSheetController = UIAlertController(title: LiHelperFunctions.localizedString(for: "Add image"), message: nil, preferredStyle: .actionSheet)
        let cancelActionButton = UIAlertAction(title: LiHelperFunctions.localizedString(for: "Cancel"), style: .cancel) { _ -> Void in
        }
        actionSheetController.addAction(cancelActionButton)
        let saveActionButton = UIAlertAction(title: LiHelperFunctions.localizedString(for: "Photo Library"), style: .default) { _ -> Void in
            if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
                self.imagePicker.delegate = self
                self.imagePicker.sourceType = .savedPhotosAlbum
                self.imagePicker.allowsEditing = false
                self.present(self.imagePicker, animated: true, completion: nil)
            }
        }
        actionSheetController.addAction(saveActionButton)
        let cameraActionButton = UIAlertAction(title: "Camera", style: .default) { _ -> Void in
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                self.imagePicker.delegate = self
                self.imagePicker.sourceType = .camera
                self.present(self.imagePicker, animated: true, completion: nil)
            }
        }
        actionSheetController.addAction(cameraActionButton)
        self.present(actionSheetController, animated: true, completion: nil)
    }
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        self.dismiss(animated: true, completion: { () -> Void in
        })
        imageAdded = true
        if let imageURL = info[UIImagePickerControllerReferenceURL] as? URL {
            let result = PHAsset.fetchAssets(withALAssetURLs: [imageURL], options: nil)
            let asset = result.firstObject
            imageFileName = asset?.value(forKey: "filename") as? String ?? LiUIConstants.defaultImageName
        }
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            selectedImage = image
            heightOfImage = (image.size.height / image.size.width) * view.frame.size.width
            imageFileName = LiUIConstants.defaultImageName
            tableView.reloadData()
        }
    }
}
extension LiBaseNewMessageViewController: UITextViewDelegate {
    public func textViewDidChange(_ textView: UITextView) {
        textViewText = textView.text
        let currentOffset = tableView.contentOffset
        UIView.setAnimationsEnabled(false)
        tableView.beginUpdates()
        tableView.endUpdates()
        UIView.setAnimationsEnabled(true)
        tableView.setContentOffset(currentOffset, animated: false)
    }
}

extension LiBaseNewMessageViewController: UIGestureRecognizerDelegate {
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        let location = gestureRecognizer.location(in: tableView)
        let indexPath = tableView.indexPathForRow(at: location)
        return indexPath == nil
    }
}
extension LiBaseNewMessageViewController {
    func registerForKeyboardNotifiactions() {
        NotificationCenter.default.addObserver(self, selector: #selector(LiBaseNewMessageViewController.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(LiBaseNewMessageViewController.keyboardWillBeHidden(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    func keyboardWillShow(_ aNotifiacation: NSNotification) {
        guard let info = aNotifiacation.userInfo else {
            return
        }
        guard let kbSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size else {
            return
        }
        tableView.contentInset.bottom = kbSize.height
        tableView.scrollIndicatorInsets.bottom = kbSize.height
        var aRect = self.view.frame
        aRect.size.height -= kbSize.height
        guard let frame = textView?.frame else {
            return
        }
        if !aRect.contains(frame.origin) {
            self.tableView.scrollRectToVisible(frame, animated: true)
        }
    }
    func keyboardWillBeHidden(_ aNotifiacation: NSNotification) {
        tableView.contentInset.bottom = 0
        tableView.scrollIndicatorInsets.bottom = 0
    }
}
