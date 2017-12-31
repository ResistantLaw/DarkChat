//
//  CreateChatRoomViewController.swift
//  DarkChat
//
//  Created by Austin Whitelaw on 12/30/17.
//  Copyright © 2017 whitelaw. All rights reserved.
//

import UIKit
import Firebase

class CreateChatRoomViewController: UIViewController {

    let mainView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        view.layer.cornerRadius = 30
        view.clipsToBounds = true
        view.layer.borderWidth = 5
        view.layer.borderColor = UIColor.white.cgColor
        return view
    }()
    
    let textField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.placeholder = "Enter Chatroom Name..."
        field.backgroundColor = .white
        field.textAlignment = .center
        return field
    }()
    
    let createButton: UIButton = {
        let but = UIButton(type: .roundedRect)
        but.translatesAutoresizingMaskIntoConstraints = false
        but.setTitle("Create Chat Room", for: .normal)
        but.backgroundColor = UIColor(red: 28/255, green: 85/255, blue: 96/255, alpha: 1.0)
        but.tintColor = .white
        but.addTarget(self, action: #selector(handleChatroomCreation), for: .touchUpInside)
        return but
    }()
    
    @objc func handleChatroomCreation() {
        if let name = textField.text {
            if name != "" {
                let ref = Database.database().reference()
                let chatRoomDict: [String: Any] = ["name": name, "created": NSDate().timeIntervalSince1970, "activeUsers": 0]
                ref.child("chat-rooms").childByAutoId().setValue(chatRoomDict)
                dismiss(animated: true, completion: nil)
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //view.backgroundColor = .clear
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        view.isOpaque = false
        
        view.addSubview(mainView)
        setupView()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        mainViewHeightAnchor?.constant = 200
        
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    var mainViewHeightAnchor: NSLayoutConstraint?
    
    func setupView() {
        
        mainView.addSubview(textField)
        mainView.addSubview(createButton)
        
        mainView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        mainView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        mainViewHeightAnchor = mainView.heightAnchor.constraint(equalToConstant: 10)
        mainViewHeightAnchor?.isActive = true
        mainView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        
        textField.centerXAnchor.constraint(equalTo: mainView.centerXAnchor).isActive = true
        textField.centerYAnchor.constraint(equalTo: mainView.centerYAnchor, constant: -50).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        textField.widthAnchor.constraint(equalTo: mainView.widthAnchor, constant: -40).isActive = true
        
        createButton.centerXAnchor.constraint(equalTo: mainView.centerXAnchor).isActive = true
        createButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 50).isActive = true
        createButton.widthAnchor.constraint(equalTo: textField.widthAnchor).isActive = true
        createButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }

}
