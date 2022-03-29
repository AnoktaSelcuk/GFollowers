//
//  GFFollowerItemVC.swift
//  GFollowers
//
//  Created by Alperen Selçuk on 21.12.2021.
//  Copyright © 2021 Alperen Selçuk. All rights reserved.
//

import UIKit

class GFFollewerItemVC: CFItemInfoVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    private func configureItems() {
        itemInfoViewOne.set(itemEnumType: .followers, with: user.followers)
        itemInfoViewTwo.set(itemEnumType: .following, with: user.following)
        actionButton.set(backgroundColor: .systemGreen, title: "Get Follower")
    }
    
    override func actionButtonTapped() {
        guard user.followers != 0 else {
            presentGFAlertOnMainThread(title: "No Followers", message: "This user has no followers", buttonTitle: "OK")
            return
        }
        delegate.didTapGetFollowers(for: user)
        dismiss(animated: true)
    }
}
