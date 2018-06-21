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
import LiUIComponents
import LiCore
class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func onStartCommunity(_ sender: UIButton) {
        let deviceToken = UserDefaults.standard.string(forKey: "deviceToken")
        /*
         Get an instance of LiHomeViewController and push it on the navigation controller.
         You can set your community name here as well as tint color for your action items.
         LiHomeViewController takes care of login for you.
         */
        LiUISDKManager.sharedInstance.set(globalTintColor: .red)
        LiUISDKManager.sharedInstance.set(communityName: "<YOUR COMMUNITY NAME>")
        let vc1 =  LiHomeViewController.makeHomeViewController(isSSOLogin: false, ssoToken: nil, deviceToken: deviceToken, notificationProvider: NotificationProviders.apns)
        self.navigationController?.pushViewController(vc1!, animated: true)
    }
}
