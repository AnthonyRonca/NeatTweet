//
//  HomeTableTableViewController.swift
//  Twitter
//
//  Created by Anthony Ronca on 2/20/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit



class HomeTableTableViewController: UITableViewController {
    
    //  Holds tweets
    
    var tweetArray = [ NSDictionary ]( )
    var numberOfTweets: Int!
    
    
    let myRefreshControl = UIRefreshControl()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        loadTweet()
        
        myRefreshControl.addTarget(self, action: #selector(loadTweet), for: .valueChanged)
        
       tableView.refreshControl = myRefreshControl
        self.myRefreshControl.endRefreshing()
        
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    
    @objc func loadTweet( ){
        
        numberOfTweets = 20
        
        let myURL = ("https://api.twitter.com/1.1/statuses/home_timeline.json")
        
        let myParams = [ "count": 20 ]
        
        TwitterAPICaller.client?.getDictionariesRequest(url: myURL, parameters: myParams, success:
            { (tweets: [NSDictionary]) in
                
                
                
                self.tweetArray.removeAll()
            
                for tweets in tweets {
                    self.tweetArray.append(tweets)
                    
                }
                
                self.tableView.reloadData()
                
        }, failure: { (Error) in
            
            print("ERROR - Try again later")
            
        })
        
        
    }
    
    
    func loadMoreTweets( ){
        
        
        let myURL = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        
        numberOfTweets = numberOfTweets + 20
        
        let myParams = ["count": numberOfTweets]
        
        TwitterAPICaller.client?.getDictionariesRequest(url: myURL, parameters: myParams as [String : Any], success:
            { (tweets: [NSDictionary]) in
                
                
                
                self.tweetArray.removeAll()
                
                for tweets in tweets {
                    self.tweetArray.append(tweets)
                    
                }
                
                self.tableView.reloadData()
                
        }, failure: { (Error) in
            
            print("ERROR - Try again later")
            
        })
        
        
        
    }
    
    
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
      
        return tweetArray.count
    }
    
    
    @IBAction func onLogout(_ sender: Any) {
        
        
        TwitterAPICaller.client?.logout()
        
        self.dismiss(animated: true, completion: nil)
        
          UserDefaults.standard.set(false, forKey: "userLoggedIn")
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell",  for: indexPath ) as! TweetCellTableViewCell
        
        let user = tweetArray[indexPath.row]["user"] as! NSDictionary
        
        
        cell.UserNameLabel.text = user["name"] as? String
        
        cell.TweetContent.text = tweetArray[indexPath.row]["text"] as? String
        
        
        let imageURL = URL(string: (user["profile_image_url_https"] as? String )!)
        
        let data = try? Data(contentsOf: imageURL!)
        
        if let imageData = data {
          
            cell.profileImageView.image = UIImage(data: imageData)
            
            
            
        }
        
        return cell
        
        }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath){
        
        if indexPath.row + 1 == tweetArray.count {
            
            loadMoreTweets()
            
        }
        
        
        
    }
        
        
//        return cell
    
    }
    
    
    
    
    
    
    
    
    
    
    
    

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


