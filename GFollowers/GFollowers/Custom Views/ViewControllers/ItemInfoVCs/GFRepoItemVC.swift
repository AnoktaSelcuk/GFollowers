//
//  GFRepoItemVC.swift
//  GFollowers
//
//  Created by Alperen Selçuk on 21.12.2021.
//  Copyright © 2021 Alperen Selçuk. All rights reserved.
//

import UIKit


class GFRepoItemVC: CFItemInfoVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    private func configureItems() {
        itemInfoViewOne.set(itemEnumType: .repos, with: user.publicRepos)
        itemInfoViewTwo.set(itemEnumType: .gists, with: user.publicGists)
        actionButton.set(backgroundColor: .systemPurple, title: "Github Profile")
    }
    
    override func actionButtonTapped() {
        delegate.didTapGitHubProfile(for: user)
    }
}

