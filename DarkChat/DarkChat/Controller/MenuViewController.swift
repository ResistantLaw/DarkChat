//
//  SideMenuViewController.swift
//  DarkChat
//
//  Created by Austin Whitelaw on 12/4/17.
//  Copyright © 2017 whitelaw. All rights reserved.
//

import UIKit
import Firebase

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView: UITableView?
    let menuNames: [String] = ["Home", "Messages", "Account", "Logout"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tableView = UITableView(frame: CGRect(x: 0, y: (self.view.frame.size.height - 50 * 4) / 2.0, width: self.view.frame.size.width, height: 50 * 4), style: .plain)
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        self.tableView = tableView
        self.view.addSubview(self.tableView!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        cell.backgroundColor = .clear
        cell.textLabel?.text = menuNames[indexPath.row]
        cell.textLabel?.textColor = .white
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView?.deselectRow(at: indexPath, animated: true)
        switch(indexPath.row) {
        case 0:
            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: ChatsTableViewController()), animated: true)
            self.sideMenuViewController!.hideMenuViewController()
        case 1:
            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: MessagesTableViewController()), animated: true)
            self.sideMenuViewController!.hideMenuViewController()
        case 2:
            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: AccountViewController()), animated: true)
            self.sideMenuViewController!.hideMenuViewController()
        case 3:
            do {
                try Auth.auth().signOut()
                self.sideMenuViewController!.hideMenuViewController()
                present(ViewController(), animated: true, completion: nil)
            } catch {
                print(error)
            }
        default: break
        }
    }

}

// CONVENIENCE INIT TO TURN SOLID COLOR INTO IMAGE
public extension UIImage {
    public convenience init?(color: UIColor, size: CGSize = CGSize(width: 100, height: 100)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
}
