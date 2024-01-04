//
//  MainDetailViewController.swift
//  MZ-Dictionary
//
//  Created by 김지은 on 2023/11/14.
//

import UIKit

class MainDetailViewController: UIViewController {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblContent: UILabel!
    @IBOutlet weak var lblSong: UILabel!
    @IBOutlet weak var lblLink: UILabel!
    
    var dataArray: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblTitle.text = dataArray[0]
        lblContent.text = dataArray[1]
        lblSong.isHidden = (dataArray[2] == "")
        lblLink.isHidden = (dataArray[3] == "")
        lblSong.text = "노래: \(dataArray[2])"
        lblLink.text = "참고 링크: \(dataArray[3])"
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(clickLinkLabel))
        lblLink.addGestureRecognizer(tapGesture)
    }
    
    @objc func clickLinkLabel(sender: UITapGestureRecognizer) {
        let webViewController = WebViewController(URL(string: dataArray[3]))
        present(webViewController, animated: true, completion: nil)
    }
}
