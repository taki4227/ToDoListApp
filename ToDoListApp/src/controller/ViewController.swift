//
//  ViewController.swift
//  ToDoListApp
//
//  Created by 滝本直樹 on 2017/03/02.
//  Copyright © 2017年 takimoto. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: - Outlets

    @IBOutlet weak var naviBar: UINavigationBar!
    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet weak var toDoListTableView: UITableView!

    // MARK: - Private Properties

    private var isRegisterSuccess = false

    private var toDoList = [ToDoEntity]()

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // UITableViewDelegate, UITableViewDatasource を追加
        toDoListTableView.dataSource = self
        toDoListTableView.delegate = self

        // リストの空行の下線を消す
        toDoListTableView.tableFooterView = UIView(frame: .zero)

        // 追加ボタンを設置
        // storyboard上に設定すると、デフォルトでtintColorに塗りつぶされる
        addButton.image = UIImage(named: "AddButton.png")?.withRenderingMode(.alwaysOriginal)
    }

    override func viewWillAppear(_ animated: Bool) {
        selectToDoList()
    }

    override func viewDidAppear(_ animated: Bool) {
        if isRegisterSuccess {
            // 登録完了の表示
            // コントローラ作成
            let alertController = UIAlertController(title: "Success", message: "登録が完了しました", preferredStyle: .alert)
            // アクションを作成
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            // アクションの追加
            alertController.addAction(defaultAction)
            // 実行
            self.present(alertController, animated: true, completion: nil)

            // フラグを落とす
            isRegisterSuccess = false
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    /// 戻るだけのunwindSegue
    ///
    /// - Parameter segue: Segue
    @IBAction func back(segue: UIStoryboardSegue) { }

    /// 登録完了時のunwindSegue
    ///
    /// - Parameter segue: Segue
    @IBAction func registerSuccess(segue: UIStoryboardSegue) {

        // テーブル再描画
        selectToDoList()
        toDoListTableView.reloadData()

        // 完了フラグを立てる
        isRegisterSuccess = true
    }

    /// 一つのsectionの中にセルの個数を指定する
    ///
    /// - Parameters:
    ///   - tableView: UITableView
    ///   - section: section
    /// - Returns: セルの個数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoList.count
    }

    /// 各indexPathのセルが編集(削除，移動等)を行えるか指定する
    ///
    /// - Parameters:
    ///   - tableView: UITableView
    ///   - indexPath: index
    /// - Returns: true: 編集可, false: 編集不可
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    /// 各indexPathのセルがスワイプされた際に表示するスワイプメニューのアクセサリボタンの内容を指定する
    ///
    /// - Parameters:
    ///   - tableView: UITableView
    ///   - indexPath: index
    /// - Returns: UITableView
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        // Deleteボタン
        let deleteButton = UITableViewRowAction(style: .normal, title: "Delete") { (action: UITableViewRowAction, idx: IndexPath) in
            // 確認ダイアログ表示
            let confirmAlertController = UIAlertController(title: "Confirm", message: "削除してもよろしいですか？", preferredStyle: .alert)

            // キャンセルボタン
            let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
            confirmAlertController.addAction(cancelAction)

            // OKボタン
            let okAction = UIAlertAction(title: "OK", style: .default) { action in
                // セル削除
                // データ削除 → テーブル更新 の順番で処理しないとエラーで落ちる

                // データ削除
                self.deleteToDo(index: indexPath.row)

                // テーブル更新
                tableView.deleteRows(at: [indexPath], with: .bottom)
            }
            confirmAlertController.addAction(okAction)

            self.present(confirmAlertController, animated: true, completion: nil)
        }
        deleteButton.backgroundColor = UIColor.AppColor.deleteButtonBgColor

        return [deleteButton]
    }

    /// セルに値を設定する
    ///
    /// - Parameters:
    ///   - tableView: UITableView
    ///   - indexPath: index
    /// - Returns: UITableViewCell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // セルを取得
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoCell") as! CustomTableViewCell

        // セルにデータをセット
        let toDoEntity = toDoList[indexPath.row]
        cell.setCell(timeLimit: DateUtil.dateToString(toDoEntity.timeLimit as! Date)
                     , title: toDoEntity.content!, tagColor: toDoEntity.tagColor)

        // 選択されたときの色なし
        cell.selectionStyle = .none

        return cell
    }

    /// ToDoリストの取得
    private func selectToDoList() {
        // リストの初期化
        toDoList.removeAll()

        // データ取得
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext

        let request: NSFetchRequest<ToDoEntity> = ToDoEntity.fetchRequest()
        // 期限の昇順
        let sort = NSSortDescriptor(key: "timeLimit", ascending: true)
        request.sortDescriptors = [sort]

        do {
            toDoList = try context.fetch(request)
        } catch {
            print("取得失敗")
        }
    }

    /// ToDo削除
    private func deleteToDo(index: Int) {
        // データ削除
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request: NSFetchRequest<ToDoEntity> = ToDoEntity.fetchRequest()

        do {
            toDoList = try context.fetch(request)
            let deleteObject = toDoList[index] as ToDoEntity
            context.delete(deleteObject)
            try context.save()

            // 削除に成功したら、リストの削除も行う
            toDoList.remove(at: index)
        } catch {
            print("削除失敗")
        }
    }

}

