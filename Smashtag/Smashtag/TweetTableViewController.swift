//
//  TweetTableViewController.swift
//  Smashtag
//
//  Created by Bozidar on 12.12.2015..
//  Copyright © 2015. Bozidar. All rights reserved.
//

import UIKit

class TweetTableViewController: UITableViewController, UITextFieldDelegate {
    
    //Array of array
    var tweets = [[Tweet]]()
    
    var searchText: String? = "#standford"{
        didSet{
            myLastSuccessfulRequest = nil
            etSearch?.text = searchText
            //clear table and refresh
            tweets.removeAll()
            tableView.reloadData()
            refresh()
        }
    }
    
    //this is called every time user pull list view
    @IBAction func onRefresh(sender: UIRefreshControl?) {
        if searchText != nil{
            if let request = nextRequestToAttempt{
                request.fetchTweets { ( newTweets ) -> Void in
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        //Code when tweets are fetched (this block of code is in main thread)
                        if newTweets.count > 0 {
                            //self.myLastSuccessfulRequest = request
                            self.tweets.insert(newTweets, atIndex: 0)
                            self.tableView.reloadData()
                            sender?.endRefreshing()
                        }
                    })
                    
                }
            }
        }else{
            sender?.endRefreshing()
        }

    }

    @IBOutlet weak var etSearch: UITextField!{
        didSet{
            etSearch.delegate = self
            etSearch.text = searchText
        }
    }
    
    var myLastSuccessfulRequest: TwitterRequest?
    
    var nextRequestToAttempt: TwitterRequest?{
        if myLastSuccessfulRequest == nil{
            if searchText != nil{
                return TwitterRequest(search: searchText!, count: 100)
            }else{ return nil }
        }else{
            return myLastSuccessfulRequest?.requestForNewer
        }
    }
    
    func refresh(){
        //start spinning
        if refreshControl != nil{
            refreshControl?.beginRefreshing()
        }
        onRefresh(refreshControl)
    }
    
    //When someone click return
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == etSearch{
            textField.resignFirstResponder() //dismis keyboard
            searchText = textField.text
        }
        return true
    }
    
    //Here is fetced model data
    //MARK: View Controller LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = tableView.rowHeight  //estimated height defined in storyboard
        tableView.rowHeight = UITableViewAutomaticDimension  //calculate dimensions od row
        refresh()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }


    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return tweets.count  //return number of sections
    }

    //How maniy rows is in each section
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tweets[section].count
    }
    
    private struct StoryBoard{
        static let CellReuseIdentifier = "Tweet"
    }

    //reusing cell...Identifier must be defined in storyboard
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(StoryBoard.CellReuseIdentifier, forIndexPath: indexPath) as! TweetTableViewCell

        //Configure cell
        //transfered responsibility to TweeTableViewCell
        cell.tweet = tweets[indexPath.section][indexPath.row]

        return cell
    }
    


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
