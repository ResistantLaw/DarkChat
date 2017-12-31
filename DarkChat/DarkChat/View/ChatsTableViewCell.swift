//
//  ChatsTableViewCell.swift
//  DarkChat
//
//  Created by Austin Whitelaw on 12/5/17.
//  Copyright © 2017 whitelaw. All rights reserved.
//

import UIKit

class ChatsTableViewCell: UITableViewCell {
    
    var chatRoom: ChatRoom? {
        didSet {
            
            if let seconds = chatRoom?.created, let active = chatRoom?.activeUsers {
                
                nameLabel.text = chatRoom?.name
                activeUsersLabel.text = "Active Users: \(active)"
                
                let timestampDate = Date(timeIntervalSince1970: seconds)
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MM/dd/yyyy"
                dateLabel.text = dateFormatter.string(from: timestampDate)
            }
        }
    }

    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Chat Room Name"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "Created: 12/25/2017"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let activeUsersLabel: UILabel = {
        let label = UILabel()
        label.text = "Users: 0"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor(red: 28/255, green: 85/255, blue: 96/255, alpha: 1.0)
        
        self.addSubview(nameLabel)
        self.addSubview(dateLabel)
        self.addSubview(activeUsersLabel)
        
        nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        activeUsersLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        activeUsersLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        dateLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
