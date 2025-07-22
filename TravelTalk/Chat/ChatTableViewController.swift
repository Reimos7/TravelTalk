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
    var chatroomId: Int = 0
    
    let textViewPlaceHolder = "내용을 입력하세요"
    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var messageTextView: UITextView!
    
    @IBOutlet var sendButton: UIButton!
    
    // 자동으로 가장 마지막 채팅 이동
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            // 테이블뷰를 마지막 셀로 자동 스크롤
            let endIndex = IndexPath(row: (self.chatList?.count ?? 0) - 1, section: 0)
            self.tableView.scrollToRow(at: endIndex, at: .bottom, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = navigationTitle
        
        // 내가 보낸 메시지
        configureXib(xibNibName: CellResource.myMessageCell.nibName, reuseIdentifier: CellResource.myMessageCell.identifier)
        
        // 상대방이 보낸 메시지
        configureXib(xibNibName: CellResource.otherMessageCell.nibName, reuseIdentifier: CellResource.otherMessageCell.identifier)
        
        setupTableView()
        setupTextView()
        
        setupTextField()
        setupButton()
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        // 테이블뷰 스크롤 인디케이터 가리기
        tableView.showsVerticalScrollIndicator = false
        
        tableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "header")
        
        // automaticDimension
        tableView.rowHeight = UITableView.automaticDimension
        // 테이블 뷰 셀 줄 없애기
        tableView.separatorStyle = .none
    }
    
    private func setupTextView() {
        messageTextView.delegate = self
        messageTextView.textAlignment = .left
        messageTextView.font = .systemFont(ofSize: 15)
    }
    
    private func setupButton() {
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .lightGray
        config.image = UIImage(systemName: "arrowtriangle.right.fill")
        sendButton.configuration = config
        
        sendButton.addTarget(self, action: #selector(tappedSendButton), for: .touchUpInside)
        
    }
    
    
    // MARK: - 전송 버튼 클릭
    @objc
    func tappedSendButton(_ sender: UIButton) {
        print(#function)
        
        // 값이 비어 있음, placeHolder랑 같을때
        if messageTextView.text.isEmpty || messageTextView.text == textViewPlaceHolder {
            showAlert(title: "전송할 메시지가 없어요", message: "전송할 메시지를 입력해주세요", preferredStyle: .alert)
        } else if !messageTextView.text.isEmpty {
            // 김새싹 (나) 텍스트뷰 입력 -> 원본 구조체에 입력 내용 append (방 번호를 통해서)
            let myAppendChat = Chat(user: .init(name: "김새싹", image: "Me"), date: Date().chatDateFormatter, message: messageTextView.text)
            
            chatList?.append(myAppendChat)
            //chatList?.append(Chat(user: .init(name: "김새싹", image: "Me"), date: Date().chatDateFormatter(), message: messageTextView.text))
            //ChatList.list?[chatroomId - 1].chatList.append(myAppendChat)
            print(myAppendChat)
            
            // 방 번호를 통해서 입력한 textView 내용 저장, -1 은 방번호가 1번방부터 시작이니까 0번 인덱스
            ChatList.list[(chatroomId) - 1].chatList.append(myAppendChat)
            
            print(ChatList.list[(chatroomId) - 1].chatList)
            print(chatroomId - 1)
            // print(ChatList.list[(chatroomId) - 1].chatList.append(myAppendChat))
            // 텍스트뷰 입력란 비워주기
            messageTextView.text = ""
            
            tableView.reloadData()
        }
        
        // 테이블뷰를 마지막 셀로 자동 스크롤
        let endIndex = IndexPath(row: (chatList?.count ?? 0) - 1, section: 0)
        self.tableView.scrollToRow(at: endIndex, at: .bottom, animated: true)
        
//        if !messageTextView.text.isEmpty {
//            chatList?.append(Chat(user: .init(name: "김새싹", image: "Me"), date: Date().chatDateFormatter(), message: messageTextView.text))
//            // 텍스트뷰 입력란 비워주기
//            messageTextView.text = ""
//            tableView.reloadData()
//        }
    }
    
    // MARK: - XIB 세팅
    private func configureXib(xibNibName: String, reuseIdentifier: String) {
        let xib = UINib(nibName: xibNibName, bundle: nil)
        tableView.register(xib, forCellReuseIdentifier: reuseIdentifier)
    }
    
    private func setupTextField() {
        messageTextView.text = textViewPlaceHolder
        messageTextView.textColor = UIColor.lightGray
        messageTextView.layer.cornerRadius = 10
        messageTextView.layer.borderWidth = 1
        messageTextView.layer.borderColor = UIColor.lightGray.cgColor
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
            let cell = tableView.dequeueReusableCell(withIdentifier: CellResource.myMessageCell.identifier, for: indexPath) as! MyMessageTableViewCell
            
            cell.configure(message: chatList?[indexPath.row].message, date: chatList?[indexPath.row].date.chatDate)
            
            cell.selectionStyle = .none
            
            return cell
            
        } else {
            // 상대방이라면 OtherMessageTableViewCell
            let cell = tableView.dequeueReusableCell(withIdentifier: CellResource.otherMessageCell.identifier, for: indexPath) as! OtherMessageTableViewCell
            
            //let chat = chatList[indexPath.row]
            // 이미지를 정원으로 그리기
            DispatchQueue.main.async {
                cell.otherMessagePersonImage.layer.cornerRadius = cell.otherMessagePersonImage.frame.width / 2
            }
            
            cell.configure(image: chatList?[indexPath.row].user.image , name: chatList?[indexPath.row].user.name, message: chatList?[indexPath.row].message, date: chatList?[indexPath.row].date.chatDate)
            
            cell.selectionStyle = .none
            
            return cell
        }
    
    }
    
}


// MARK: - UITableViewDelegate
extension ChatTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header")!

        let label = UILabel()
        label.text = "날짜"
        
        label.textColor = .black
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 16)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        headerView.contentView.addSubview(label)

        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: headerView.contentView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: headerView.contentView.centerYAnchor)
        ])
        
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40 // 원하는 높이로 설정
    }
}


// MARK: - UITextViewDelegate
extension ChatTableViewController: UITextViewDelegate {
    // 엔터키 입력시 동작
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        print(#function)
         
        
//        if !text.isEmpty {
//            chatList?.append(Chat(user: .init(name: "김새싹", image: "Me"), date: "ss", message: text))
//        }
//        
//        tableView.reloadData()
        return true
    }
    
    // 텍스트뷰를 터치해서 편집 시작할때 현재 텍스트가 설정한 placeHolder랑 같다면 텍스트 비우고 색상 바꿔줌
    func textViewDidBeginEditing(_ textView: UITextView) {
           if textView.text == textViewPlaceHolder {
               textView.text = ""
               textView.textColor = .black
           }
       }
       
       func textViewDidEndEditing(_ textView: UITextView) {
           // 텍스트뷰가 비어있으면 placeHolder가 다시 보이게 설정, 색상도 기존 색상으로 
           if textView.text.isEmpty {
               textView.text = textViewPlaceHolder
               textView.textColor = .lightGray
           }
       }
}
