//
//  ViewController.swift
//  DarkChat
//
//  Created by Austin Whitelaw on 11/29/17.
//  Copyright © 2017 whitelaw. All rights reserved.
//

import UIKit
import Firebase
import AKSideMenu

class ViewController: UIViewController {
    
    var emailField: UITextField!
    var passwordField: UITextField!
    var newAccountSwitch: UISwitch!
    var loginButton: UIButton!
    
    var errorLabel: UILabel!
    var newAccountLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        if Auth.auth().currentUser != nil {
            print("already logged in!")
            //self.performSegue(withIdentifier: "loginSegue", sender: self)   UPDATE THIS
        } else {
            print("not logged in")
        }
    }
    
    func setupView() {
        
        self.view.backgroundColor = .black
        
        emailField = UITextField(frame: CGRect(x: 0, y: 0, width: 500, height: 30))
        emailField.placeholder = "Enter a random email"
        emailField.borderStyle = UITextBorderStyle.roundedRect
        emailField.keyboardType = .emailAddress
        emailField.returnKeyType = .next
        emailField.textAlignment = .center
        self.view.addSubview(emailField)
        
        passwordField = UITextField(frame: CGRect(x: 0, y: 0, width: 500, height: 30))
        passwordField.placeholder = "Enter password"
        passwordField.borderStyle = UITextBorderStyle.roundedRect
        passwordField.isSecureTextEntry = true
        passwordField.returnKeyType = .go
        passwordField.textAlignment = .center
        self.view.addSubview(passwordField)
        
        loginButton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
        loginButton.setTitle("Start Using Dark Chat!", for: .normal)
        loginButton.backgroundColor = #colorLiteral(red: 0.4078431373, green: 0.7019607843, blue: 0.6862745098, alpha: 1)
        loginButton.addTarget(self, action: #selector(loginPressed), for: .touchUpInside)
        self.view.addSubview(loginButton)
        
        newAccountSwitch = UISwitch()
        self.view.addSubview(newAccountSwitch)
        
        newAccountLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        newAccountLabel.text = "Create new account?"
        newAccountLabel.textColor = .white
        self.view.addSubview(newAccountLabel)
        
        errorLabel = UILabel()
        errorLabel.text = ""
        errorLabel.textColor = .red
        self.view.addSubview(errorLabel)
        
        emailField.translatesAutoresizingMaskIntoConstraints = false
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        newAccountSwitch.translatesAutoresizingMaskIntoConstraints = false
        newAccountLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        
        emailField.widthAnchor.constraint(equalToConstant: 250).isActive = true
        emailField.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -500).isActive = true
        emailField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        passwordField.widthAnchor.constraint(equalToConstant: 250).isActive = true
        passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 20).isActive = true
        passwordField.centerXAnchor.constraint(equalTo: emailField.centerXAnchor).isActive = true
        newAccountLabel.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 20).isActive = true
        newAccountLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: -40).isActive = true
        newAccountSwitch.centerYAnchor.constraint(equalTo: newAccountLabel.centerYAnchor).isActive = true
        newAccountSwitch.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 100).isActive = true
        loginButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        loginButton.topAnchor.constraint(equalTo: newAccountLabel.bottomAnchor, constant: 30).isActive = true
        loginButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        errorLabel.bottomAnchor.constraint(equalTo: emailField.topAnchor, constant: -10).isActive = true
        errorLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
    }
    
    @objc func loginPressed(_ sender: Any) {
        if(emailField.text == "" || passwordField.text == "") {
            errorLabel.text = "Missing username or password."
        } else {
            if(newAccountSwitch.isOn) {
                Auth.auth().createUser(withEmail: emailField.text!, password: passwordField.text!, completion: { (user, error) in
                    if user != nil {
                        print("Created new user")
                        let vc = SetupAccountViewController()
                        vc.email = self.emailField.text!
                        self.present(vc, animated: true, completion: nil)
                    } else {
                        print(error?.localizedDescription)
                    }
                })
            } else {
                Auth.auth().signIn(withEmail: emailField.text!, password: passwordField.text!) { (user, error) in
                    if user != nil {
                        //let vc = MenuViewController()
                        //self.present(vc, animated: true, completion: nil)
                        self.dismiss(animated: true, completion: nil)
                    } else {
                        print(error?.localizedDescription)
                    }
                }
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "setupAccountSegue") {
            if let vc = segue.destination as? SetupAccountViewController {
                vc.email = emailField.text!
            }
        }
    }
    
    
}

