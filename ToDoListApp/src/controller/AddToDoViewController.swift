//
//  AddToDoViewController.swift
//  ToDoListApp
//
//  Created by 滝本直樹 on 2017/03/04.
//  Copyright © 2017年 takimoto. All rights reserved.
//

import UIKit
import CoreData

class AddToDoViewController: UIViewController, UIToolbarDelegate, UITextFieldDelegate {

    // MARK: - Outlets

    @IBOutlet weak var toDoTitleTextField: UITextField!
    @IBOutlet weak var timeLimitView: UIView!
    @IBOutlet weak var timeLimitTextField: UITextField!

    // MARK: - Private Properties

    var toolBar: UIToolbar!
    var datePicker: UIDatePicker!

    private var isImportant = false

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // UITextFieldDelegateの追加
        toDoTitleTextField.delegate = self

        // タイトルのTextFieldにパディング設定
        let padding = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        toDoTitleTextField.leftView = padding
        toDoTitleTextField.leftViewMode = UITextFieldViewMode.always
        toDoTitleTextField.rightView = padding
        toDoTitleTextField.rightViewMode = UITextFieldViewMode.always

        // TextFieldの改行キーを変更
        toDoTitleTextField.returnKeyType = .done

        // 期限のViewにシングルタップしたときのアクション（tapSingle）の設定
        let timeLimitViewTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.onClickTimeLimitTextField(gesture:)))
        timeLimitViewTapGesture.numberOfTapsRequired = 1

        timeLimitView.addGestureRecognizer(timeLimitViewTapGesture)

        // UIDatePickerの設定
        datePicker = UIDatePicker()
        datePicker.datePickerMode = UIDatePickerMode.dateAndTime
        timeLimitTextField.inputView = datePicker

        // 初期値の設定
        timeLimitTextField.text = DateUtil.dateToString(Date())

        // UIToolBarの設定
        toolBar = UIToolbar(frame: CGRect(x: 0, y: self.view.bounds.size.height - 44, width: self.view.bounds.size.width, height: 40.0))
        toolBar.layer.position = CGPoint(x: self.view.frame.size.width / 2, y: self.view.frame.size.height - 20.0)
        toolBar.barStyle = .default
        toolBar.barTintColor = UIColor.AppColor.defaultPrimaryColor
        toolBar.tintColor = UIColor.white

        // ToolBarのボタンの設定
        let toolBarDoneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.onClickDoneButton(sender:)))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)

        toolBar.items = [flexSpace, toolBarDoneButton]

        timeLimitTextField.inputAccessoryView = toolBar

        // 背景をタップしたときのアクションの設定
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.onClickBackground(gesture:)))
        self.view.addGestureRecognizer(tapGesture)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - UITextFieldDelegate

    /// 完了ボタンを押したときの処理
    ///
    /// - Parameter textField: UITextField
    /// - Returns: true: 処理を行う, false: 処理を行わない
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // キーボードを隠す
        toDoTitleTextField.resignFirstResponder()

        return true
    }

    /// 画面遷移するかどうかの処理
    ///
    /// - Parameters:
    ///   - identifier: ID
    ///   - sender: sender
    /// - Returns: true: 遷移する, false: 遷移しない
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {

        guard !identifier.isEmpty else {
            // IDがなければ遷移しない
            return false
        }

        switch identifier {
        case "back":
            return true

        case "register":
            if inputCheck() {
                // 正常処理

                // 登録処理
                _ = createToDo()

                return true
            } else {
                // 異常

                let alertController = UIAlertController(title: "Error", message: "未入力の項目があります", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(action)
                self.present(alertController, animated: true, completion: nil)

                return false
            }


        default:
            // それ以外は遷移しない
            return false
        }

    }

    /// Switchの切り替え時
    ///
    /// - Parameter sender: UISwitch
    @IBAction func onChangeSwitch(_ sender: UISwitch) {
        isImportant = sender.isOn
    }

    /// 期限のViewタップ時
    ///
    /// - Parameter gesture: UITapGestureRecognizer
    func onClickTimeLimitTextField(gesture: UITapGestureRecognizer) {
        // 期限テキストフィールドにフォーカスを当てる
        timeLimitTextField.becomeFirstResponder()
    }

    /// DatePickerのdoneボタンのタップ時
    ///
    /// - Parameter sender: UIBarButtonItem
    func onClickDoneButton(sender: UIBarButtonItem) {
        // テキストの入力
        timeLimitTextField.text = DateUtil.dateToString(datePicker.date)
        // キーボードを隠す
        timeLimitTextField.resignFirstResponder()
    }

    /// 背景のタップ時
    ///
    /// - Parameter gesture: UITapGestureRecognizer
    func onClickBackground(gesture: UITapGestureRecognizer) {
        // キーボードを隠す
        toDoTitleTextField.resignFirstResponder()
        timeLimitTextField.resignFirstResponder()
    }

    /// 入力チェック
    ///
    /// - Returns: true: 正常, false: 不正
    private func inputCheck() -> Bool {
        if toDoTitleTextField.text != ""
            && timeLimitTextField.text != "" {
            return true
        } else {
            return false
        }
    }

    /// 登録処理
    ///
    /// - Returns: true: 成功, false: 失敗
    private func createToDo() -> Bool {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let viewContext = appDelegate.persistentContainer.viewContext
        // Insertするテーブルを指定
        let entity = NSEntityDescription.entity(forEntityName: "ToDoEntity", in: viewContext)

        // レコード作成
        let newRecord = NSManagedObject(entity: entity!, insertInto: viewContext)
        newRecord.setValue(toDoTitleTextField.text, forKey: "content")
        newRecord.setValue(DateUtil.stringToDate(timeLimitTextField.text!), forKey: "timeLimit")
        newRecord.setValue(isImportant, forKey: "tagColor")

        // 登録
        do {
            // 成功
            try viewContext.save()
            return true
        } catch {
            // 失敗
            print("登録失敗")
            return false
        }
    }

}
