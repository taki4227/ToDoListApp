//
//  DateUtil.swift
//  ToDoListApp
//
//  Created by Naoki Takimoto on 2017/03/17.
//  Copyright © 2017年 takimoto. All rights reserved.
//

import Foundation

class DateUtil {
    
    /**
     * フォーマッタ
     */
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ja_JP")
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
        return dateFormatter
    }()
    
    
    /**
     * Date型を文字列に変換
     * - parameter date: 日付
     * - returns: yyyy/MM/dd HH:mm
     */
    public static func dateToString(_ date: Date) -> String {
        return dateFormatter.string(from: date)
    }
    
    /**
     * 文字列をDate型に変換
     * - parameter date: 日付(yyyy/MM/dd HH:mm)
     * - returns: Date
     */
    public static func stringToDate(_ dateStirng: String) -> Date {
        return dateFormatter.date(from: dateStirng)!
    }
}
