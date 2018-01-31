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
///Model representing the reponse from liUploadImageClient
public struct LiImageResponse: LiBaseModel {
    public private(set) var id: String?
    init(data: [String: Any]) {
        self.id = data["id"] as? String
    }
}

extension UIImage {
    /// Returns the data for the specified image in JPEG format.
    /// If the image object’s underlying image data has been purged, calling this function forces that data to be reloaded into memory.
    /// - returns: A data object containing the JPEG data, or nil if there was a problem generating the data. This function may return nil if the image has no data or if the underlying CGImageRef contains data in an unsupported bitmap format.
    public func jpeg() -> Data? {
        var imageData: Data?
        var actualHeight = self.size.height
        var actualWidth = self.size.width
        let maxHeight: CGFloat = 600.0
        let maxWidth: CGFloat = 800.0
        var imgRatio = actualWidth / actualHeight
        let maxRatio = maxWidth / maxHeight
        var compressionQuality: CGFloat = 0.5
        if actualHeight > maxHeight || actualWidth > maxWidth {
            if imgRatio < maxRatio {
                imgRatio = maxHeight / actualHeight
                actualWidth = imgRatio * actualWidth
                actualHeight = maxHeight
            } else if imgRatio > maxRatio {
                imgRatio = maxWidth / actualWidth
                actualHeight = imgRatio * actualHeight
                actualWidth = maxWidth
            } else {
                actualHeight = maxHeight
                actualWidth = maxWidth
                compressionQuality = 1
            }
        }
        let rect = CGRect(x: 0, y: 0, width: actualWidth, height: actualHeight)
        UIGraphicsBeginImageContext(rect.size)
        self.draw(in: rect)
        if let img = UIGraphicsGetImageFromCurrentImageContext() {
            imageData = UIImageJPEGRepresentation(img, compressionQuality)
        }
        UIGraphicsEndImageContext()
        return imageData
    }
}
