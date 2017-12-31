//
//  AccountViewController.swift
//  DarkChat
//
//  Created by Austin Whitelaw on 12/4/17.
//  Copyright © 2017 whitelaw. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Account"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Menu", style: .plain, target: self, action: #selector(self.presentLeftMenuViewController(_:)))
        
        self.view.backgroundColor = .black
    }

}
