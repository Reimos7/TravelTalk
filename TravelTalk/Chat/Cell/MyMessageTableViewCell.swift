//
//  ChatTableViewCell.swift
//  TravelTalk
//
//  Created by Reimos on 7/19/25.
//

import UIKit

final class MyMessageTableViewCell: UITableViewCell {

    @IBOutlet var myMessageBackgroundView: UIView!
    
    @IBOutlet var myMessageLabel: UILabel!
    @IBOutlet var myMessageDateLabel: UILabel!
    
   
    override func awakeFromNib() {
        super.awakeFromNib()
        
        myMessageBackgroundView.backgroundColor = .myMessageBgColor
        
        myMessageBackgroundView.layer.masksToBounds = true
        myMessageBackgroundView.layer.cornerRadius = 10
        myMessageBackgroundView.layer.borderWidth = 1
        myMessageBackgroundView.layer.borderColor = UIColor.darkGray.cgColor
        
        myMessageLabel.textColor = .black
        myMessageLabel.textAlignment = .left
        myMessageLabel.numberOfLines = 0 
        
        myMessageDateLabel.textAlignment = .right
        myMessageDateLabel.textColor = .darkGray
        myMessageDateLabel.font = .systemFont(ofSize: 14)
    }
    
    func configure(message: String?, date: String?) {
        myMessageLabel.text = message
        myMessageDateLabel.text = date 
    }
    
}
