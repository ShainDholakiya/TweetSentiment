#  TweetSentiment

## Description

TweetSentiment is a tweet sentiment analysis app where you can input any twitter profile, name, or hashtag and it will generate a score from the past 100 tweets to see how people are reacting to this certain topic on Twitter. It uses CoreML to predict the sentiment score of a tweet. 

## What I learned

* How to use CoreML.
* How to convert a data set to a MLModel using CreateML.

## Tools Used

* [Swifter - Twitter Framework](https://github.com/mattdonnelly/Swifter)
* [TwitterAPI](https://developer.twitter.com/en/docs/tweets/search/api-reference/get-search-tweets)
* [SwiftyJSON](https://github.com/SwiftyJSON/SwiftyJSON)


## My way of analyzing the sentiment score for each tweet 
```

if sentiment == "Pos" {
    sentimentScore += 1
} else if sentiment == "Neg" {
    sentimentScore -= 1
}
                
                
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

```
