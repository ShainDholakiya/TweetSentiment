//
//  ViewController.swift
//  Twittermenti
//
//  Created by Shain Dholakiya on 6/10/20.
//  Copyright © 2020 Shain Dholakiya. All rights reserved.
//

import UIKit
import SwifteriOS
import CoreML
import SwiftyJSON

class ViewController: UIViewController {
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var sentimentLabel: UILabel!
    
    var tweetsData: [Tweet] = [] // for segue to table view controller
    
    let tweetCount = 100
    
    let sentimentClassifier = TweetSentimentClassifier()
    
    // Instantiation using Twitter's OAuth Consumer Key and secret
    let swifter = Swifter(consumerKey: "kHGsfU6sXIc11GGJipVhEIRru", consumerSecret: "Y8EcOFwli450KfH7V9qrg1SOvm5xezZU0vFpf9cuBY7M7QMJd4")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func predictPressed(_ sender: Any) {
        
        fetchTweets()
        
    }
    
    func fetchTweets() {
        
        if let searchText = textField.text {
            
            swifter.searchTweet(using: searchText, lang: "en", resultType: "recent", count: tweetCount, includeEntities: true, tweetMode: .extended, success: { (results, metadata) in
                
                var tweets = [TweetSentimentClassifierInput]()
                
                self.tweetsData = []
                
                for i in 0..<self.tweetCount {
                    
                    if let tweet = results[i]["full_text"].string, let url = results[i]["entities"]["media"][0]["url"].string {
                        
                        let tweetForClassification = TweetSentimentClassifierInput(text: tweet)
                        tweets.append(tweetForClassification)
                        
                        // for segue to table view controller
                        let newTweet = Tweet(tweetText: tweet, tweetURL: url)
                        self.tweetsData.append(newTweet)
                    }
                    
                }
                
                self.makePrediction(with: tweets)
                
            }) { (error) in
                print("There was an error with the Twitter API request, \(error)")
            }
            
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ShowTweets" {
            
            let destinationTableVC = segue.destination as! TableViewController

            destinationTableVC.tweetsData = tweetsData
        }
        
    }
    
    func makePrediction(with tweets: [TweetSentimentClassifierInput]) {
        
        do {
            let predictions = try self.sentimentClassifier.predictions(inputs: tweets)
            
            var sentimentScore = 0
            
            for pred in predictions {
                let sentiment = pred.label
                
                if sentiment == "Pos" {
                    sentimentScore += 1
                } else if sentiment == "Neg" {
                    sentimentScore -= 1
                }
            }
            
            updateUI(with: sentimentScore)
            
        } catch {
            print("There was an error with making a prediction, \(error)")
        }
        
    }
    
    func updateUI(with sentimentScore: Int) {
        
        if sentimentScore > 20 {
            self.sentimentLabel.text = "😍"
        } else if sentimentScore > 10 {
            self.sentimentLabel.text = "😀"
        } else if sentimentScore > 0 {
            self.sentimentLabel.text = "🙂"
        } else if sentimentScore == 0 {
            self.sentimentLabel.text = "😐"
        } else if sentimentScore > -10 {
            self.sentimentLabel.text = "😕"
        } else if sentimentScore > -20 {
            self.sentimentLabel.text = "😡"
        } else {
            self.sentimentLabel.text = "🤮"
        }
        
        print(sentimentScore)
        
        DispatchQueue.main.async {
            self.scoreLabel.text = "Score: \(sentimentScore)"
        }
        
    }
    
}

