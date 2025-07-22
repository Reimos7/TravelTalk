//
//  CellResource.swift
//  TravelTalk
//
//  Created by Reimos on 7/23/25.
//

import Foundation

enum CellResource {
    case chatRoomList
    case myMessageCell
    case otherMessageCell
    
    var nibName: String {
        switch self {
        case .chatRoomList:
            return "ChatRoomListCollectionViewCell"
        case .myMessageCell:
            return "MyMessageTableViewCell"
        case .otherMessageCell:
            return "OtherMessageTableViewCell"
        }
    }
    
    var identifier: String {
        switch self {
        case .chatRoomList:
            return "ChatRoomListCollectionViewCell"
        case .myMessageCell:
            return "MyMessageTableViewCell"
        case .otherMessageCell:
            return "OtherMessageTableViewCell"
        }
    }
}
