//
//  Group.swift
//  MyVKClient
//
//  Created by Alexey Danilov on 11.02.2018.
//  Copyright © 2018 danilovdev. All rights reserved.
//

import Foundation

struct Group {
    
    var id: Int64!
    
    var name: String!
    
    var screen_name: String!
    
    var type: String!
    
    var photo_50: String!
    
    var photo_100: String!
    
    var photo_200: String!
    
    init(dict: Dictionary<String, Any>) {
        if let id = dict["id"] as? Int64 {
            self.id = id
        }
        if let name = dict["name"] as? String {
            self.name = name
        }
        if let screen_name = dict["screen_name"] as? String {
            self.screen_name = screen_name
        }
        if let type = dict["type"] as? String {
            self.type = type
        }
        if let photo_50 = dict["photo_50"] as? String {
            self.photo_50 = photo_50
        }
        if let photo_100 = dict["photo_100"] as? String {
            self.photo_100 = photo_100
        }
        if let photo_200 = dict["photo_200"] as? String {
            self.photo_200 = photo_200
        }
    }
    
}
