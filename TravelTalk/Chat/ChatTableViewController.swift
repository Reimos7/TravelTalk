//
//  ChatViewController.swift
//  TravelTalk
//
//  Created by Reimos on 7/19/25.
//

import UIKit

final class ChatTableViewController: UIViewController {
    
    //let chat = ChatList.list
    
    var navigationTitle: String?
    var personName: String?
    // 컬렉션뷰 화면에서 Chat을 전달 받기 위한 변수 
    var chatList: [Chat]?
    var personImage: UIImage?
    var chatDate: Date?
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        dump(chat[1])
//        print("-----------------------------")
//        dump(chat[1].chatList)
//        print("-----------------------------")
//        dump(chat[1].chatList[0].message)
//        print("-----------------------------")
//        dump(chat[1].chatList[1].message)
//        print("-----------------------------")
//        dump(chat[1].chatList[2].message)
//        print("-----------------------------")
//        dump(chat[1].chatList[3].message)
//        print("-----------------------------")
//        dump(chat[1].chatList[4].message)
//        // 조건문으로 dump에 보이는걸 0번째 셀에 보이게, 1번째 셀에 보이게 이런식으로 ㄱㄱ
//        print("===========================다른 사람 =================================")
//        dump(chat[2])
//        print("-----------------------------")
//        dump(chat[2].chatList)
//        print("-----------------------------")
//        dump(chat[2].chatList[0].message)
//        print("-----------------------------")
//        dump(chat[2].chatList[1].message)
//        print("-----------------------------")
//        dump(chat[2].chatList[2].message)
//        print("-----------------------------")
//        dump(chat[2].chatList[3].message)
//        print("-----------------------------")
//        dump(chat[2].chatList[4].message)
//        print("============================================================")
//        
        

        navigationItem.title = navigationTitle
        
        
        // 내가 보낸 메시지
        configureXib(xibNibName: MyMessageTableViewCell.nibName, reuseIdentifier: MyMessageTableViewCell.identifier)
        
        // 상대방이 보낸 메시지
        configureXib(xibNibName: OtherMessageTableViewCell.nibName, reuseIdentifier: OtherMessageTableViewCell.identifier)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        // automaticDimension
        tableView.rowHeight = UITableView.automaticDimension
        // 테이블 뷰 셀 줄 없애기
        tableView.separatorStyle = .none
    }
    
    
    // MARK: - XIB 세팅
    private func configureXib(xibNibName: String, reuseIdentifier: String) {
        let xib = UINib(nibName: xibNibName, bundle: nil)
        tableView.register(xib, forCellReuseIdentifier: reuseIdentifier)
    }

}


// MARK: - UITableViewDataSource
extension ChatTableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 8개 고정임 
        return chatList?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //let row = indexPath.row
        dump(chatList?[indexPath.row].user.name == "김새싹")
        
        // 김새싹 (나) 이 보낸 채팅이라면? MyMessageTableViewCell
        if chatList?[indexPath.row].user.name == "김새싹" {
            let cell = tableView.dequeueReusableCell(withIdentifier: MyMessageTableViewCell.identifier, for: indexPath) as! MyMessageTableViewCell
            
            cell.configure(message: chatList?[indexPath.row].message, date: chatList?[indexPath.row].date.chatDate)
            
            return cell
            
        } else {
            // 상대방이라면 OtherMessageTableViewCell
            let cell = tableView.dequeueReusableCell(withIdentifier: OtherMessageTableViewCell.identifier, for: indexPath) as! OtherMessageTableViewCell
            
            //let chat = chatList[indexPath.row]
            // 이미지를 정원으로 그리기
            DispatchQueue.main.async {
                cell.otherMessagePersonImage.layer.cornerRadius = cell.otherMessagePersonImage.frame.width / 2
            }
            
            cell.configure(image: personImage , name: personName, message: chatList?[indexPath.row].message, date: chatList?[indexPath.row].date.chatDate)
            
            return cell
        }
    
    }
    
}


// MARK: - UITableViewDelegate
extension ChatTableViewController: UITableViewDelegate {
    
}

