//
//  ViewController.swift
//  redditJson
//
//  Created by Skyler Tanner on 12/7/15.
//  Copyright © 2015 Skyler Tanner. All rights reserved.
//

import UIKit
import SafariServices

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var articles: [RedditArticle] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articles.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("subredditCell", forIndexPath: indexPath)
        
        let redditArticle = self.articles[indexPath.row]
        cell.textLabel?.text = redditArticle.title
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let webView = SFSafariViewController.init(URL:NSURL(string: self.articles[indexPath.row].url)!)
        self.presentViewController(webView, animated: true, completion: nil)
    }

    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        let url = NetworkController.searchURL(searchBar.text!)
        NetworkController.dataAtURL(url, callback: { (resultData, error) -> Void in
            self.articles = resultData
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.tableView.reloadData()
            })
        })
    }
    
}

