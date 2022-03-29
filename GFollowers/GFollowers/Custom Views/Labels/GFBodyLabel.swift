//
//  GFBodyLabel.swift
//  GFollowers
//
//  Created by Alperen Selçuk on 11.12.2021.
//  Copyright © 2021 Alperen Selçuk. All rights reserved.
//

import UIKit

class GFBodyLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(textAlignment: NSTextAlignment) {
        super.init(frame: .zero)
        self.textAlignment = textAlignment
    
        configure()
    }
    
    private func configure() {
        textColor                   = .secondaryLabel
        font = UIFont.preferredFont(forTextStyle: .body) //dinamik type
        adjustsFontSizeToFitWidth   = true
        minimumScaleFactor          = 0.75
        lineBreakMode               = .byWordWrapping
        translatesAutoresizingMaskIntoConstraints = false
    }


}
