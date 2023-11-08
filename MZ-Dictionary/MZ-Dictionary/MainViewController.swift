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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableViewCell()
    }
    
    func registerTableViewCell() {
        tvMain.register(UINib(nibName: "MainTableViweCell", bundle: nil), forCellReuseIdentifier: "MainTableViweCell")
        tvMain.delegate = self
        tvMain.dataSource = self
    }
}
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViweCell", for: indexPath) as! MainTableViweCell
        return cell
    }
}

class MainTableViweCell: UITableViewCell {
    
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
