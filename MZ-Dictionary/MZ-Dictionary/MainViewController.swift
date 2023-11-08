//
//  MainViewController.swift
//  MZ-Dictionary
//
//  Created by 김지은 on 2023/11/09.
//

import UIKit

class MainViewController: UIViewController {

    /// main tableview
    @IBOutlet weak var tvMain: UITableView!
    
    var list: [ListModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableViewCell()
        fetchList(pageSize: 1)
    }
    
    func registerTableViewCell() {
        tvMain.register(UINib(nibName: "MainTableViweCell", bundle: nil), forCellReuseIdentifier: "MainTableViweCell")
        tvMain.delegate = self
        tvMain.dataSource = self
    }
    
    func fetchList(pageSize: Int) {
        FireStoreManager.shared.fetchList(pageSize: pageSize) { list in
            self.list = list
            self.tvMain.reloadData()
        }
    }
}
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath) as! MainTableViewCell
        cell.lblTitle.text = list?[indexPath.row].title ?? ""
        cell.lblContent.text = list?[indexPath.row].content ?? ""
        return cell
    }
}

class MainTableViewCell: UITableViewCell {
    
    /// title label
    @IBOutlet weak var lblTitle: UILabel!
    /// content label
    @IBOutlet weak var lblContent: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
