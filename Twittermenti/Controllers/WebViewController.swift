//
//  WebViewController.swift
//  Twittermenti
//
//  Created by Shain Dholakiya on 6/10/20.
//  Copyright © 2020 Shain Dholakiya. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    @IBOutlet weak var tweetWebView: WKWebView!
    
//    var tweetsData: [Tweet = []
    
    var selectedTweet = Tweet(tweetText: "", tweetURL: "")

    override func viewDidLoad() {
        super.viewDidLoad()

        let url = URL(string: selectedTweet.tweetURL)
        let request = URLRequest(url: url!)
        tweetWebView.load(request)
    }

}
