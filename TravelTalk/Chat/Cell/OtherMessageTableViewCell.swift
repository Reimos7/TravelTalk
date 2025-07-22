//
//  OtherMessageTableViewCell.swift
//  TravelTalk
//
//  Created by Reimos on 7/19/25.
//

import UIKit

final class OtherMessageTableViewCell: UITableViewCell {
    
    @IBOutlet var otherMessagePersonImage: UIImageView!
    
    @IBOutlet var otherMessagePersonName: UILabel!
    
    @IBOutlet var otherMessageBackgroundView: UIView!
    
    
    @IBOutlet var otherMessageLabel: UILabel!
    
    
    @IBOutlet var otherMessageDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        otherMessagePersonImage.contentMode = .scaleAspectFit
        //otherMessagePersonImage.backgroundColor = .yellow
   
        otherMessagePersonName.textColor = .black
        
        otherMessageLabel.textColor = .black
        otherMessageLabel.numberOfLines = 0
        
        otherMessageBackgroundView.backgroundColor = .white
        otherMessageBackgroundView.layer.cornerRadius = 10
        otherMessageBackgroundView.clipsToBounds = true
        otherMessageBackgroundView.layer.borderWidth = 1
        otherMessageBackgroundView.layer.borderColor = UIColor.lightGray.cgColor
        
        otherMessageDate.textColor = .darkGray
        otherMessageDate.textAlignment = .left
        otherMessageDate.font = .systemFont(ofSize: 14)

    }
    
    func configure(image: String?, name: String?, message: String?, date: String?) {
        
        otherMessagePersonImage.image = UIImage(named: image ?? "xmark")
        
        otherMessagePersonName.text = name
        
        otherMessageLabel.text = message
        
        otherMessageDate.text = date
    }
   
    
}
