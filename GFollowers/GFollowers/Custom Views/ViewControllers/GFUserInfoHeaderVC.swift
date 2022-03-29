//
//  GFUserInfoHeaderVC.swift
//  GFollowers
//
//  Created by Alperen Selçuk on 19.12.2021.
//  Copyright © 2021 Alperen Selçuk. All rights reserved.
//

import UIKit

class GFUserInfoHeaderVC: UIViewController {


    let avatarImageView     = GFAvatarImageView(frame: .zero)
    let usernamelabel       = GFTitleLabel(textAlignment: .left, fontSize: 34)
    let nameLabel           = SecondaryTitleLabel(fontSize: 18)
    let locationImageView   = UIImageView()
    let locationLabel       = SecondaryTitleLabel(fontSize: 18)
    let bioLabel            = GFBodyLabel(textAlignment: .left)
    var user: User!
    
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureUIElements()
        layoutUI()
    }
    
    func configureUIElements() {
        avatarImageView.downloadImage(from: user.avatarUrl)
        usernamelabel.text          = user.login
        nameLabel.text              = user.name ?? "UNKNOW"
        locationLabel.text          = user.location ?? "UNKNOWN"
        bioLabel.text               = user.bio ?? "No bio Availble"
        bioLabel.numberOfLines      = 3
        locationImageView.image     = UIImage(systemName: SFSymbols.location)
        locationImageView.tintColor = .secondaryLabel
    }
    
    func addSubviews() {
        view.addSubview(avatarImageView)
        view.addSubview(usernamelabel)
        view.addSubview(nameLabel)
        view.addSubview(locationImageView)
        view.addSubview(locationLabel)
        view.addSubview(bioLabel)
    }
    
    func layoutUI() {
        let padding: CGFloat            = 20
        let textImagePadding: CGFloat   = 12
        locationImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: 90),
            avatarImageView.heightAnchor.constraint(equalToConstant: 90),
            
            usernamelabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
            usernamelabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            usernamelabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            usernamelabel.heightAnchor.constraint(equalToConstant: 38),
            
            nameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            locationImageView.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor),
            locationImageView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            locationImageView.widthAnchor.constraint(equalToConstant: 20),
            locationImageView.heightAnchor.constraint(equalToConstant: 20),
             
            locationLabel.centerYAnchor.constraint(equalTo: locationImageView.centerYAnchor),
            locationLabel.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor, constant: 5),
            locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            locationLabel.heightAnchor.constraint(equalToConstant: 20),
            
            bioLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: textImagePadding),
            bioLabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor),
            bioLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bioLabel.heightAnchor.constraint(equalToConstant: 60)
            
        ])
    }
}
