//
//  TweetTableViewCell.swift
//  Smashtag
//
//  Created by Bozidar on 12.12.2015..
//  Copyright © 2015. Bozidar. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {
    
    var tweet: Tweet?{
        didSet{
            updateUI()
        }
    }

    @IBOutlet weak var ivTweetProfile: UIImageView!

    @IBOutlet weak var tvScreenName: UILabel!
    
    @IBOutlet weak var tvTweetText: UILabel!
    
    func updateUI(){
        // reset any existing tweet information
        tvTweetText?.attributedText = nil
        tvScreenName?.text = nil
        ivTweetProfile?.image = nil
       // tweetCreatedLabel?.text = nil
        
        // load new information from our tweet (if any)
        if let tweet = self.tweet
        {
            tvTweetText?.text = tweet.text
            if tvTweetText?.text != nil  {
                for _ in tweet.media {
                    tvTweetText.text! += " 📷"
                }
            }
            
            tvScreenName?.text = "\(tweet.user)" // tweet.user.description
            
            if let profileImageURL = tweet.user.profileImageURL {
                if let imageData = NSData(contentsOfURL: profileImageURL) { // THIS BLOCKS main thread!
                    ivTweetProfile?.image = UIImage(data: imageData)
                }
            }
            
//            let formatter = NSDateFormatter()
//            if NSDate().timeIntervalSinceDate(tweet.created) > 24*60*60 {
//                formatter.dateStyle = NSDateFormatterStyle.ShortStyle
//            } else {
//                formatter.timeStyle = NSDateFormatterStyle.ShortStyle
//            }
//            tweetCreatedLabel?.text = formatter.stringFromDate(tweet.created)
        }

    }
}
