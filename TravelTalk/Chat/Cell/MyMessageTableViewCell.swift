//
//  ChatTableViewCell.swift
//  TravelTalk
//
//  Created by Reimos on 7/19/25.
//

import UIKit

final class MyMessageTableViewCell: UITableViewCell {
    
    static let nibName = "MyMessageTableViewCell"
    static let identifier = "MyMessageTableViewCell"

    @IBOutlet var myMessageBackgroundView: UIView!
    
    @IBOutlet var myMessageLabel: UILabel!
    @IBOutlet var myMessageDateLabel: UILabel!
    
   
    override func awakeFromNib() {
        super.awakeFromNib()
        
        myMessageBackgroundView.backgroundColor = UIColor(red: 239/255.0, green: 239/255.0, blue: 239/255.0, alpha: 1.0)
        
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
