//
//  ChatMessageCell.swift
//  DarkChat
//
//  Created by Austin Whitelaw on 12/25/17.
//  Copyright © 2017 whitelaw. All rights reserved.
//

//
//  ChatMessageCell.swift
//  RealTimeChat
//
//  Created by Austin Whitelaw on 12/17/17.
//  Copyright © 2017 whitelaw. All rights reserved.
//

import UIKit

class ChatMessageCell: UICollectionViewCell {
    
    var message: Message? {
        didSet {
            if let seconds = message?.timestamp?.doubleValue {
                
                let timestampDate = Date(timeIntervalSince1970: seconds)
                
                
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "HH:mm a (MM/dd/yy)"
                timestampLabel.text = dateFormatter.string(from: timestampDate)
                
                textView.text = message?.text
            }
        }
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Username"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .lightGray
        return label
    }()
    
    let textView: UITextView = {
        let tv = UITextView()
        tv.text = "Sample text blah blah blah"
        tv.font = UIFont.systemFont(ofSize: 16)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = .clear
        tv.textColor = .white
        return tv
    }()
    
    static let blueColor = UIColor(red: 0/255, green: 137/255, blue: 249/255, alpha: 1.0)
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "fsociety")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 16
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let timestampLabel: UILabel = {
        let label = UILabel()
        label.text = "12:22:43 PM"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(nameLabel)
        addSubview(textView)
        addSubview(profileImageView)
        addSubview(timestampLabel)
        
        self.backgroundColor = .darkGray
        
        profileImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        profileImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 32).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 32).isActive = true
        
        textView.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 8).isActive = true
        textView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        textView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        textView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        
        nameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 12).isActive = true
        
        timestampLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
        timestampLabel.leftAnchor.constraint(equalTo: nameLabel.rightAnchor, constant: 5).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

