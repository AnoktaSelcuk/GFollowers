//
//  GFTextField.swift
//  GFollowers
//
//  Created by Alperen Selçuk on 9.12.2021.
//  Copyright © 2021 Alperen Selçuk. All rights reserved.
//

import UIKit

class GFTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius          = 10
        layer.borderWidth           = 3
        layer.borderColor           = UIColor.systemGray.cgColor
        
        textColor                   = .label
        tintColor                   = .label
        textAlignment               = .center
        font                        = UIFont.preferredFont(forTextStyle: .title2)
        adjustsFontSizeToFitWidth   = true
        minimumFontSize             = 12
        
        backgroundColor             = .tertiarySystemBackground
        autocorrectionType          = .no
//        keyboardType                = .emailAddress
        returnKeyType               = .go
        placeholder                 = "Enter a username"
    }
}
