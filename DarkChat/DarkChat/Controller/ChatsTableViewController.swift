//
//  ChatsTableViewController.swift
//  DarkChat
//
//  Created by Austin Whitelaw on 12/4/17.
//  Copyright © 2017 whitelaw. All rights reserved.
//

import UIKit
import Firebase
import AKSideMenu

class ChatsTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, AKSideMenuDelegate {
    
    var tableView: UITableView?
    
    var chatRoomsArray: [ChatRoom] = []
    
    let cellId: String = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.definesPresentationContext = true
        
        self.title = "Chat Rooms"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Menu", style: .plain, target: self, action: #selector(self.presentLeftMenuViewController(_:)))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleNewChatRoom))
        self.view.backgroundColor = UIColor(red: 0/255, green: 31/255, blue: 54/255, alpha: 1.0)
        
        let tableView = UITableView(frame: CGRect(x: self.view.frame.width * 0.075, y: 0, width: self.view.frame.size.width*0.85, height: self.view.frame.height), style: .plain)
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor(red: 0/255, green: 31/255, blue: 54/255, alpha: 1.0)
        tableView.showsVerticalScrollIndicator = false
        tableView.register(ChatsTableViewCell.self, forCellReuseIdentifier: cellId)
        self.tableView = tableView
        self.view.addSubview(self.tableView!)
        
        getChatRooms()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if Auth.auth().currentUser?.uid == nil {
            present(ViewController(), animated: true, completion: nil)
        } 
    }
    
    func getChatRooms() {
        let ref = Database.database().reference().child("chat-rooms").observe(.childAdded) { (snapshot) in
            print(snapshot)
            guard let chatRoomDict = snapshot.value as? [String: AnyObject] else {
                return
            }
            let chatRoom = ChatRoom()
            chatRoom.key = snapshot.key
            chatRoom.name = chatRoomDict["name"] as? String
            chatRoom.created = chatRoomDict["created"] as? TimeInterval
            chatRoom.activeUsers = chatRoomDict["activeUsers"] as? Int
            self.chatRoomsArray.append(chatRoom)
            DispatchQueue.main.async {
                self.tableView?.reloadData()
            }
        }
    }
    
    var index = 4
    
    @objc func handleNewChatRoom() {
        print("New Chat Room Pressed")
        
        let vc = CreateChatRoomViewController()
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true, completion: nil)
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return chatRoomsArray.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let chatRoom = chatRoomsArray[indexPath.section]
        let chatLogViewController = ChatLogViewController(collectionViewLayout: UICollectionViewFlowLayout())
        chatLogViewController.chatRoom = chatRoom
        navigationController?.pushViewController(chatLogViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ChatsTableViewCell
        let chatRoom = chatRoomsArray[indexPath.section]
//        cell.backgroundColor = UIColor(red: 28/255, green: 85/255, blue: 96/255, alpha: 1.0)
        cell.chatRoom = chatRoom
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//
//
//    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view:UIView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.bounds.size.width, height: 10))
        view.backgroundColor = .clear
        
        return view
    }
    

}
