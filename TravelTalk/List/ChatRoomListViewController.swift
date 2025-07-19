//
//  FriendListViewController.swift
//  TravelTalk
//
//  Created by Reimos on 7/18/25.
//

import UIKit

final class ChatRoomListViewController: UIViewController {
    
    let chatList = ChatList.list
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //dump(chatList.count)
        navigationItem.title = "TRAVEL TALK"
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        setupXib(xifNibName: ChatRoomListCollectionViewCell.nibName, reuseIdentifier: ChatRoomListCollectionViewCell.identifier)
        configureCollectionView(sectionInsets: 10, minimumSpacing: 1, cellCount: 1, itemSpacing: 0, lineSpacing: 10, scrollDirection: .vertical)
        
        
    }
    
    // xib 세팅 함수
    private func setupXib(xifNibName: String, reuseIdentifier: String) {
        let xib = UINib(nibName: xifNibName, bundle: nil)
        collectionView.register(xib, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    // 컬렉션뷰 세팅 함수
    private func configureCollectionView(sectionInsets: CGFloat, minimumSpacing: CGFloat, cellCount: CGFloat, itemSpacing: Int, lineSpacing: CGFloat, scrollDirection: UICollectionView.ScrollDirection) {
        
        let layout = UICollectionViewFlowLayout()
        
        // 너비
        let deviceWidth = UIScreen.main.bounds.width
        
        // 너비 계산
        let cellWidth = deviceWidth - (sectionInsets * 2) - (minimumSpacing * (cellCount - 1))
        
        layout.itemSize = CGSize(width: cellWidth , height: cellWidth / 4 )
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        
        // 셀 사이 간격
        layout.minimumInteritemSpacing = minimumSpacing
        // 셀 상하 간격
        layout.minimumLineSpacing = lineSpacing
        
        layout.scrollDirection = scrollDirection
        
        collectionView.collectionViewLayout = layout
    }
    
    
}


// MARK: - UICollectionViewDataSource
extension ChatRoomListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return chatList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChatRoomListCollectionViewCell.identifier, for: indexPath) as! ChatRoomListCollectionViewCell
        
        let item = chatList[indexPath.row]
        DispatchQueue.main.async {
            cell.chattingRoomImage.layer.cornerRadius = cell.chattingRoomImage.frame.width / 2
        }
        
        cell.configureData(item: item)
        
        return cell
        
    }
    
    
}


// MARK: - UICollectionViewDelegate
extension ChatRoomListViewController: UICollectionViewDelegate {
    
}
