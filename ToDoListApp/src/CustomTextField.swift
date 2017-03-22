//
//  CustomTextField.swift
//  ToDoListApp
//
//  Created by 滝本直樹 on 2017/03/04.
//  Copyright © 2017年 takimoto. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {

    /// 入力カーソル非表示
    ///
    /// - Parameter position: UITextPosition
    /// - Returns: 空
    override func caretRect(for position: UITextPosition) -> CGRect {
        return CGRect.zero
    }

    /// 範囲選択カーソル非表示
    ///
    /// - Parameter range: UITextRange
    /// - Returns: 空の配列
    override func selectionRects(for range: UITextRange) -> [Any] {
        return []
    }

    /// コピー・ペースト・選択等のメニュー非表示
    ///
    /// - Parameters:
    ///   - action: Selector
    ///   - sender: sender
    /// - Returns: true: 表示する, false: 表示しない
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return false
    }

}
