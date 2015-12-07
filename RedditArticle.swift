//
//  redditArticle.swift
//  redditJson
//
//  Created by Skyler Tanner on 12/7/15.
//  Copyright © 2015 Skyler Tanner. All rights reserved.
//

import Foundation

class RedditArticle {
    
    let title: String
    let url: String
    
    init(jsonDictionary:[String:AnyObject]) {
        self.title = jsonDictionary["title"]! as! String
        self.url = jsonDictionary["url"]! as! String
    }
}