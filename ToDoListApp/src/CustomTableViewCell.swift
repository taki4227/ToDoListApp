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

    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)

        // タップ時のハイライト設定
//        if(highlighted) {
//            self.alpha = 0.8
//        } else {
//            self.alpha = 1.0
//        }
    }

    /// セルをデータをセットする
    ///
    /// - Parameters:
    ///   - timeLimit: 期限
    ///   - title: タイトル
    func setCell(timeLimit: String, title: String, tagColor: Bool) {
        timeLimitLabel.text = timeLimit
        toDoTitleLabel.text = title

        if tagColor {
            self.backgroundColor = UIColor.AppColor.highlightColor
        } else {
            self.backgroundColor = UIColor.white
        }

    }

}
