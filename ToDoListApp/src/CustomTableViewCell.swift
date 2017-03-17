//
//  CustomTableViewCell.swift
//  ToDoListApp
//
//  Created by 滝本直樹 on 2017/03/05.
//  Copyright © 2017年 takimoto. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var timeLimitLabel: UILabel!
    @IBOutlet weak var toDoTitleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    /// セルをデータをセットする
    ///
    /// - Parameters:
    ///   - timeLimit: 期限
    ///   - title: タイトル
    func setCell(timeLimit: String, title: String) {
        timeLimitLabel.text = timeLimit
        toDoTitleLabel.text = title
    }

}
