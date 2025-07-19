//
//  DateFormatter+Extension.swift
//  TravelTalk
//
//  Created by Reimos on 7/18/25.
//

import UIKit

extension String {
    var chatRoomListDate: String {
        // 현재 문자열의 실제 날짜 포맷에 맞게 설정
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        // 출력 포맷 정의
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "yy.MM.dd"
        
        // 변환
        guard let date = inputFormatter.date(from: self) else {
            print("포맷 변환 오류")
            return self
        }
        print("포맷 변환 성공 ")
        return outputFormatter.string(from: date)
    }
}
