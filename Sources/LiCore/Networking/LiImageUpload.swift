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
import Alamofire
extension LiRestClient {
    func upload <T: Router>(client: T, success: @escaping Success, failure: @escaping Failure) {
        sessionManager.session.configuration.timeoutIntervalForResource = 100
        sessionManager.upload(multipartFormData: { (multipartFormData) in
            guard let image = client.image else {
                return
            }
            let requestBody: String = "{\"request\": {\"data\": {\"description\": \"\",\"field\": \"image.content\",\"title\": \"" + image.imageName + "\",\"type\": \"image\",\"visibility\": \"public\"}}}"
            multipartFormData.append(requestBody.data(using: String.Encoding.utf8)!, withName: "api.request")
            multipartFormData.append(image.imageData, withName: "image.content", fileName: image.imageName, mimeType: "image/jpg")
            multipartFormData.append("".data(using: String.Encoding.utf8)!, withName: "payload")
        }, with: client) { (encodingResult) in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseString { response in
                    switch response.result {
                    case .success:
                        do {
                            let data = try LiApiResponse.getLiBaseResponse(data: response.data)
                            success(data)
                        } catch let error {
                            failure(error)
                        }
                    case .failure:
                        do {
                            let data = try LiApiResponse.getLiBaseError(data: response.data)
                            failure(data)
                        } catch let error {
                            failure(error)
                        }
                    }
                }
            case .failure(let encodingError):
                failure(encodingError)
            }
        }
    }
}
