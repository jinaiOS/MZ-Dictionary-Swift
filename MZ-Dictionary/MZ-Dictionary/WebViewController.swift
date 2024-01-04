//
//  WebViewController.swift
//  MZ-Dictionary
//
//  Created by 김지은 on 2024/01/04.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKUIDelegate {
    
    var myURL: URL?
    var webView: WKWebView!
    
    init(_ url: URL?) {
        super.init(nibName: nil, bundle: nil)
        myURL = url
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let myURL = myURL else { return }
        let myRequest = URLRequest(url: myURL)
        webView.load(myRequest)
    }
}
