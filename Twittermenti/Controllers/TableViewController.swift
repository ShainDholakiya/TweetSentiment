//
//  TableViewController.swift
//  Twittermenti
//
//  Created by Shain Dholakiya on 6/10/20.
//  Copyright © 2020 Shain Dholakiya. All rights reserved.
//

import UIKit
import SwifteriOS
import CoreML
import SwiftyJSON

class TableViewController: UITableViewController {
    
    var tweetsData: [Tweet] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return tweetsData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetIdentifier", for: indexPath)
        
        cell.textLabel?.text = tweetsData[indexPath.row].tweetText
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "TweetWebView" {
            
            let destinationWebVC = segue.destination as! WebViewController
            
            //                destinationWebVC.tweetsData = tweetsData
            
            if let indexPath = tableView.indexPathForSelectedRow {
                destinationWebVC.selectedTweet = tweetsData[indexPath.row]
            }
            
        }
    }
        
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
        performSegue(withIdentifier: "TweetWebView", sender: self)
    }
        
}
