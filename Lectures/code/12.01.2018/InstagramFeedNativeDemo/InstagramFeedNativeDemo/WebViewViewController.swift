//
//  WebViewViewController.swift
//  InstagramFeedNativeDemo
//
//  Created by Emil Atanasov on 11.01.18.
//  Copyright © 2018 SwiftFMI. All rights reserved.
//

import UIKit
import WebKit

class WebViewViewController: UIViewController, UITabBarControllerDelegate {
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadDefaultURL()
    }
    
    func loadDefaultURL() {
        let publicURL = "https://app.tobe-millionaire.com/"
        let localURL = SERVER_ROOT + "demo/"
        
        // Do any additional setup after loading the view.
        let rq = URLRequest(url: URL(string:publicURL)!)
        webView.load(rq)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.delegate = nil
    }
    
    public func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if tabBarController.selectedIndex == 2 {
            loadDefaultURL()
        }
    }
}
