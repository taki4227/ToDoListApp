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

    /// セルに値を設定する
    ///
    /// - Parameters:
    ///   - tableView: UITableView
    ///   - indexPath: 行のインデックス
    /// - Returns: UITableViewCell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // セルを取得
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoCell") as! CustomTableViewCell

        // セルにデータをセット
        let toDoEntity = toDoList[indexPath.row]
        cell.setCell(timeLimit: DateUtil.dateToString(toDoEntity.timeLimit as! Date)
                     , title: toDoEntity.content!)

        // セルの背景色を変える
        if toDoEntity.tagColor {
            cell.backgroundColor = UIColor.AppColor.highlightColor
        }

        return cell
    }

    private func selectToDoList() {
        // リストの初期化
        toDoList.removeAll()

        // データ取得
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let viewContext = appDelegate.persistentContainer.viewContext

        let request: NSFetchRequest<ToDoEntity> = ToDoEntity.fetchRequest()
        // 期限の昇順
        let sort = NSSortDescriptor(key: "timeLimit", ascending: true)
        request.sortDescriptors = [sort]

        toDoList = try! viewContext.fetch(request)
    }

}

