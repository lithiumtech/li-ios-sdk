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
class LiImageLoader {
    public static let sharedInstance = LiImageLoader()
    var task: URLSessionDownloadTask!
    var session: URLSession!
    var cache: NSCache<NSString, UIImage>!
    private init() {
        session = URLSession.shared
        task = URLSessionDownloadTask()
        self.cache = NSCache()
    }
    func obtainImageWithUrl(imageUrl: String, completionHandler: @escaping ((_ image: UIImage?, _ error: Error?) -> Void)) {
        if let image = self.cache.object(forKey: imageUrl as NSString) {
            DispatchQueue.main.async {
                completionHandler(image, nil)
            }
        } else {
            let placeholder = LiUIConstants.defaultProfileImage
            DispatchQueue.main.async {
                completionHandler(placeholder, nil)
            }
            let url: URL! = URL(string: imageUrl)
            task = session.downloadTask(with: url, completionHandler: { (_, _, error: Error?) in
                if let err = error {
                    print(err.localizedDescription)
                    completionHandler(nil, err)
                }
                if let data = try? Data(contentsOf: url) {
                    if let image: UIImage = UIImage(data: data) {
                        self.cache.setObject(image, forKey: imageUrl as NSString)
                        DispatchQueue.main.async {
                            completionHandler(image, nil)
                        }
                    }
                }
            })
            task.resume()
        }
    }
}
