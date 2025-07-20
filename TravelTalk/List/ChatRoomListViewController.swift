//
//  FriendListViewController.swift
//  TravelTalk
//
//  Created by Reimos on 7/18/25.
//

import UIKit

final class ChatRoomListViewController: UIViewController {
    // 검색을 필터링을 통해 유동적으로 변경되어야 함
    var chat = ChatList.list
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "TRAVEL TALK"
        navigationItem.backBarButtonItem?.tintColor = .black
       
        collectionView.dataSource = self
        collectionView.delegate = self
        // 컬렉션뷰 스크롤 인디케이터 가려주기
        collectionView.showsVerticalScrollIndicator = false
        
        searchBar.delegate = self
        
        searchBar.placeholder = "친구 이름을 검색해보세요"
        
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
    
    // alert
    func showAlert(title: String?, message: String?, preferredStyle: UIAlertController.Style) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        
        let cancel = UIAlertAction(title: "닫기", style: .cancel)
        
        alert.addAction(cancel)

        present(alert, animated: true)
    }
    
    
}


// MARK: - UICollectionViewDataSource
extension ChatRoomListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return chat.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChatRoomListCollectionViewCell.identifier, for: indexPath) as! ChatRoomListCollectionViewCell
        
        let item = chat[indexPath.row]
        DispatchQueue.main.async {
            cell.chattingRoomImage.layer.cornerRadius = cell.chattingRoomImage.frame.width / 2
        }
        
        cell.configureData(item: item)
        
        return cell
        
    }
    
    
}


// MARK: - UICollectionViewDelegate
extension ChatRoomListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //print(#function)
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "ChatTableViewController") as! ChatTableViewController
        
        let item = chat[indexPath.item]
        
        
        //print(item.chatroomName)
        
        //print(item.chatList[indexPath.item].message)
        
        // 네비게이션 타이틀 설정
        vc.navigationTitle = item.chatroomName
        
        // 사용자 이름 설정
        vc.personName = item.chatroomImage
        
        // 사용자 이미지 설정
        vc.personImage = UIImage(named: item.chatroomImage)
        
        //vc.personMessage = item.chatList[indexPath.item].message
        
        // chatList를 다음 화면인 테이블뷰에 보내주기
        // chatList에는 채팅에 필요한 (유저이름, 메시지, 전송 시간)
        vc.chatList = item.chatList
        
        //vc.personName = ChatList.den.name
        //vc.personMessage = item.chatList[indexPath.item].message
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
}


// MARK: - UISearchBarDelegate
extension ChatRoomListViewController: UISearchBarDelegate {
   
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
        // 고정적인 원본 데이터
        //let chatOriginData = ChatList.list
        
        // 검색 조건 필터링 데이터
        var chatFilterData: [ChatRoom] = []
        // 공백 제거
        guard let searchText = searchBar.text?.trimmingCharacters(in: .whitespaces),
              !searchText.isEmpty else {
//            chat = chatOriginData
//            collectionView.reloadData()
            showAlert(title: "검색어 없음", message: "친구 이름을 검색해주세요", preferredStyle: .alert)
            return
        }
        
        // 대소문자 구별 x
        chatFilterData = chat.filter {$0.chatroomName.lowercased().contains(searchText.lowercased())}
        
        // 검색한 결과가 친구 목록에 없다면?
        if chatFilterData.isEmpty {
            showAlert(title: "검색 결과 없음", message: "\(searchText)에 해당하는 채팅방이 없어요", preferredStyle: .alert)
        }
        
        chat = chatFilterData

        collectionView.reloadData()
    
        
    }
    
    // 사용자가 검색어를 지웠을때 값이 비어 있다면, 다시 전체 목록 출력
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // 고정적인 원본 데이터
        let chatOriginData = ChatList.list
        
        if searchText.isEmpty {
            chat = chatOriginData
            collectionView.reloadData()
        }
    }
    
    
    
}
