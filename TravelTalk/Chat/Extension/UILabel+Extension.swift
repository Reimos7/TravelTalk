//
//  UILabel+Extension.swift
//  TravelTalk
//
//  Created by Reimos on 7/18/25.
//

import UIKit

extension UILabel {
    func setupLabel(labelText: String?, fontSize: UIFont?, textColor: UIColor?, textAlignment: NSTextAlignment) {
        
        self.text = labelText
        self.font = fontSize
        self.textColor = textColor
        self.textAlignment = textAlignment
    }
}
