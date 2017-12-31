//
//  SetupAccountViewController.swift
//  DarkChat
//
//  Created by Austin Whitelaw on 11/30/17.
//  Copyright © 2017 whitelaw. All rights reserved.
//

import UIKit
import Firebase

class SetupAccountViewController: UIViewController {
    
    var ref: DatabaseReference!
    var user: User!
    
    var email = "invalid@email.com"
    var displayNameField: UITextField!
    var confirmButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        ref = Database.database().reference()
        user = Auth.auth().currentUser
        
    }
    
    func setupView() {
        let back = UIView(frame: CGRect(x: 0, y: 0, width: 275, height: 150))
        back.center = CGPoint(x: self.view.frame.width/2, y: self.view.frame.height/2)
        back.backgroundColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        self.view.addSubview(back)
        
        displayNameField = UITextField(frame: CGRect(x: 0, y: 0, width: back.frame.width*0.75, height: 30))
        displayNameField.borderStyle = .roundedRect
        displayNameField.placeholder = "Enter a display name"
        displayNameField.center = CGPoint(x: back.center.x, y: back.center.y-25)
        displayNameField.textAlignment = .center
        self.view.addSubview(displayNameField)
        
        confirmButton = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
        confirmButton.setTitle("Confirm", for: .normal)
        confirmButton.center = CGPoint(x: back.center.x, y: back.center.y+40)
        confirmButton.backgroundColor = #colorLiteral(red: 0.4078431373, green: 0.7019607843, blue: 0.6862745098, alpha: 1)
        self.view.addSubview(confirmButton)
        
        
        
    }
    
    func confirmNamePressed(_ sender: Any) {
        
        var userInfo: [String: Any] = [:]
        userInfo["name"] = displayNameField.text!
        userInfo["email"] = user.email
        
        ref.child("users").child(user.uid).setValue(userInfo)
        
        let vc = ChatsTableViewController()
        present(vc, animated: true, completion: nil)
        
    }
    
}

