//
//  WebViewController.swift
//  ArkusNexusTest
//
//  Created by guerrier on 6/12/19.
//  Copyright © 2019 guerra. All rights reserved.
//

import UIKit
import RxSwift
import WebKit

class WebViewController: UIViewController {

    var url:String!
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        let req = URLRequest(url: URL(string: url)!)
        webView.load(req)
        self.webView.allowsBackForwardNavigationGestures = true
    }

}

