//
//  NewsFeed.swift
//  MyVKClient
//
//  Created by Alexey Danilov on 11.02.2018.
//  Copyright © 2018 danilovdev. All rights reserved.
//

import UIKit

struct NewsFeed {
    
    var items = [NewsItem]()
    
    var profiles = [Profile]()
    
    var groups = [Group]()
    
//    var new_offset 
    
//    var next_from
    
    init(dict: Dictionary<String, Any>) {
        if let items = dict["items"] as? Array<Dictionary<String, Any>> {
            for item in items {
                let newsItem = NewsItem(dict: item)
                self.items.append(newsItem)
            }
        }
    }
    
    init() {
        
    }
    
}
