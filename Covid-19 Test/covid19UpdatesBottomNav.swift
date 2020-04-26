//
//  covid19UpdatesBottomNav.swift
//  Covid-19 Test
//
//  Created by Tushar  yadav on 25/04/2020.
//  Copyright © 2020 Tushar  yadav. All rights reserved.
//

import UIKit
import WebKit
import Firebase

class covid19UpdatesBottomNav: UIViewController , WKNavigationDelegate, WKUIDelegate {
    
    let urlString:String = "https://news.google.com/covid19/map"
    let secondURL:URL = URL(string: "https://www.worldometers.info/coronavirus/")!
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    var refreshControl:UIRefreshControl?

    lazy var settingLauncher:settingLauhcher = {
        let launcher = settingLauhcher()
        launcher.covid19Update = self
        return launcher
    }()


    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl = UIRefreshControl.init()
        refreshControl!.addTarget(self, action:#selector(refreshControlClicked), for: UIControl.Event.valueChanged)
        webView.scrollView.addSubview(self.refreshControl!)

        webView.scrollView.backgroundColor = UIColor.white
        
        webView.navigationDelegate = self;
        webView.uiDelegate = self
        
        
        

        if let url: URL = URL(string:urlString){
            webView.load(URLRequest(url: url))
            indicatorViewStart()
        }else{
            webView.load(URLRequest(url: secondURL))
            indicatorViewStart()
        }
        
      
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    @objc func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        indicatorViewStart()
    }

    @objc func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        indicatorViewStop()
    }
    
    @objc func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        indicatorViewStop()
    }
    
   @objc func refreshControlClicked(){
        
    webView.reload()
    refreshControl!.endRefreshing()
    }
    @IBAction func setting(_ sender: Any) {
        settingLauncher.showSettings()
    }
    
    @objc func logout(){
        
        URLCache.shared.removeAllCachedResponses()
                  
        try! Auth.auth().signOut()
                  
        self.performSegue(withIdentifier: "logout", sender: self)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @objc func indicatorViewStart(){
                   activityIndicator.center = self.view.center
                   activityIndicator.hidesWhenStopped = true
                   activityIndicator.style = UIActivityIndicatorView.Style.large
                   view.addSubview(activityIndicator)
                   activityIndicator.startAnimating()
               }
               
               @objc func indicatorViewStop(){
                   activityIndicator.stopAnimating()
               }

}
