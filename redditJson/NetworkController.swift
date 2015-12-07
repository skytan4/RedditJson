//
//  NetworkController.swift
//  redditJson
//
//  Created by Skyler Tanner on 12/7/15.
//  Copyright © 2015 Skyler Tanner. All rights reserved.
//

import Foundation

class NetworkController {
    
   
    static func searchURL(term: String) -> NSURL {
        
        let baseURLString = "https://www.reddit.com"
        let searchString = baseURLString + "/r/\(term).json"
        
        return NSURL(string: searchString)!
    }
    
    static func dataAtURL(url: NSURL, callback: (resultData: [RedditArticle], NSError?) -> Void) {
        
        let session = NSURLSession.sharedSession()
        
        let dataTask = session.dataTaskWithURL(url) { (data, response, error) -> Void in
            if let error = error {
                print(error.localizedDescription)
            }
            guard let data = data else {
                callback(resultData: [],nil)
                print("Error getting data")
                return
            }
            
            let jsonObject: AnyObject
            
            do{
                jsonObject = try NSJSONSerialization.JSONObjectWithData(data, options: [])
            } catch(let error as NSError) {
                callback(resultData: [], error)
                return
            }
            
            if let searchObject = jsonObject as? [String: AnyObject],
                let subredditData = searchObject["data"] as? [String: AnyObject],
                let subredditArray = subredditData["children"] as? [AnyObject] {
                    
                    var redditArticles: [RedditArticle] = []
                    
                    for redditDictionary in subredditArray {
                        if let redditArticleDictionary = redditDictionary["data"] as? [String: AnyObject] {
                            let redditArticleObject = RedditArticle(jsonDictionary: redditArticleDictionary)
                            redditArticles.append(redditArticleObject)
                        }
                        
                    }
                    callback(resultData: redditArticles, nil)
            }
            print(jsonObject)
        }
        dataTask.resume()
    }
}



