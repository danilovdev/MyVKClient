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
    
    var profiles = [Int64: Profile]()
    
    var groups = [Int64: Group]()
    
//    var new_offset 
    
    var next_from: String!
    
    init(dict: Dictionary<String, Any>) {
        if let items = dict["items"] as? Array<Dictionary<String, Any>> {
            for item in items {
                let newsItem = NewsItem(dict: item)
                self.items.append(newsItem)
            }
        }
        if let profiles = dict["profiles"] as? Array<Dictionary<String, Any>> {
            for profileDict in profiles {
                let profile = Profile(dict: profileDict)
                self.profiles[profile.id] = profile
            }
        }
        if let groups = dict["groups"] as? Array<Dictionary<String, Any>> {
            for groupDict in groups {
                let group = Group(dict: groupDict)
                self.groups[group.id] = group
            }
        }
        if let next_from = dict["next_from"] as? String {
            self.next_from = next_from
        }
    }
    
    init() {
        
    }
    
    mutating func add(feed: NewsFeed) {
        self.items += feed.items
        self.profiles.merge(feed.profiles) { (_, newValue) -> Profile in
            return newValue
        }
        self.groups.merge(feed.groups) { (_, newValue) -> Group in
            return newValue
        }
        self.next_from = feed.next_from
    }
    
}
