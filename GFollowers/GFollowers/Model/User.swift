//
//  User.swift
//  GFollowers
//
//  Created by Alperen Selçuk on 14.12.2021.
//  Copyright © 2021 Alperen Selçuk. All rights reserved.
//

import Foundation

struct User: Codable {
    
    //MARK: Variable
    let login: String
    let avatarUrl: String
    let name: String?
    var location: String?
    var bio: String?
    let publicRepos: Int
    let publicGists: Int
    let htmlUrl: String
    let following: Int
    let followers: Int
    let createdAt: String
}
