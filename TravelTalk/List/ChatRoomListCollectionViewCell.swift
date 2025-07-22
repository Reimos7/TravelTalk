//
//  FriendListCollectionViewCell.swift
//  TravelTalk
//
//  Created by Reimos on 7/18/25.
//

import UIKit

final class ChatRoomListCollectionViewCell: UICollectionViewCell {
    @IBOutlet var chattingRoomImage: UIImageView!
    
    @IBOutlet var chattingRoomName: UILabel!
    
    @IBOutlet var chattingRoomLastMessage: UILabel!
    
    @IBOutlet var chattingRoomDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureView()
    }
    
    private func configureView() {
        chattingRoomImage.contentMode = .scaleAspectFit
    }
    
    func configureData(item: ChatRoom) {
      
        chattingRoomImage.image = UIImage(named: item.chatroomImage)
        
        guard let date = item.chatList.last?.date.chatRoomListDate else {return }
            
        chattingRoomName.setupLabel(labelText: item.chatroomName, fontSize: .boldSystemFont(ofSize: 16), textColor: .black, textAlignment: .left)
        chattingRoomLastMessage.setupLabel(labelText: item.chatList.last?.message, fontSize: .systemFont(ofSize: 15), textColor: .lightGray, textAlignment: .left)
        chattingRoomDate.setupLabel(labelText: date, fontSize: .systemFont(ofSize: 13), textColor: .lightGray, textAlignment: .center)
       
    }

}
