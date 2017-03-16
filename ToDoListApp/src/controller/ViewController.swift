//
//  ViewController.swift
//  ToDoListApp
//
//  Created by 滝本直樹 on 2017/03/02.
//  Copyright © 2017年 takimoto. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private var isRegisterSuccess = false
    
    private let refreshControl = UIRefreshControl()
    
    @IBOutlet weak var naviBar: UINavigationBar!
    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet weak var toDoListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UITableViewDelegate を追加
        // UITableViewDatasource を追加
        toDoListTableView.dataSource = self
        toDoListTableView.delegate = self
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
    
    /**
     * 戻るだけのunwindSegue
     * -parameter segue: Segue
     */
    @IBAction func back(segue: UIStoryboardSegue) {}
    
    /**
     * 登録完了時のunwindSegue
     * -parameter segue: Segue
     */
    @IBAction func registerSuccess(segue: UIStoryboardSegue) {
        // 完了フラグを立てる
        isRegisterSuccess = true
    }

    /**
     * 一つのsectionの中にセルの個数を指定する
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    /**
     * セルに値を設定する
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // セルを取得
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoCell") as! CustomTableViewCell
        
        // セルにデータをセット
        cell.setCell(timeLimit: "yyyy/mm/dd hh:mm", title: "swift")
        
        // セルの色を変える
        let isImportant = true
        if isImportant {
            cell.backgroundColor = UIColor.yellow
        }
        
        return cell
    }

}

