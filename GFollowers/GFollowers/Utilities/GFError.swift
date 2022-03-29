//
//  GFError.swift
//  GFollowers
//
//  Created by Alperen Selçuk on 19.12.2021.
//  Copyright © 2021 Alperen Selçuk. All rights reserved.
//

import Foundation

enum GFError: String, Error {
    case invalidUsername = "This username created an invalid request. Please try again."
    case unableToComplete = "Unable To Complete your request. Please check your internet connection."
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data received from the server was invalid. Please try again."
    case unableToFavorite = "there was an error favorite this user. Please try again"
    case alreadyInFavorites = "You've already favorited this user"
}
