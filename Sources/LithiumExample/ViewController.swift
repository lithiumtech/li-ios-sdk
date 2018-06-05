//
//  ViewController.swift
//  LithiumExample
//
//  Created by Shekhar Dahore on 5/30/18.
//  Copyright © 2018 Shek. All rights reserved.
//

import UIKit
import LiUIComponents

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
        LiUISDKManager.sharedInstance.set(globalTintColor: .red)
        let vc1 =  LiHomeViewController.makeHomeViewController(isSSOLogin: false, ssoToken: nil, deviceToken: nil, notificationProvider: nil)
        self.navigationController?.pushViewController(vc1!, animated: true)
    }
    
    
}

