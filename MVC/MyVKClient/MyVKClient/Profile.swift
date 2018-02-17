//
//  Profile.swift
//  MyVKClient
//
//  Created by Alexey Danilov on 11.02.2018.
//  Copyright © 2018 danilovdev. All rights reserved.
//

import Foundation

struct Profile {
    
    var id: Int64!
    
    var first_name: String!
    
    var last_name: String!
    
    var screen_name: String!
    
    var photo_50: String!
    
    var photo_100: String!
    
    var fullName: String! {
        return "\(self.first_name) \(self.last_name)"
    }
    
    init(dict: Dictionary<String, Any>) {
        if let id = dict["id"] as? Int64 {
            self.id = id
        }
        if let first_name = dict["first_name"] as? String {
            self.first_name = first_name
        }
        if let last_name = dict["last_name"] as? String {
            self.last_name = last_name
        }
        if let screen_name = dict["screen_name"] as? String {
            self.screen_name = screen_name
        }
        if let photo_50 = dict["photo_50"] as? String {
            self.photo_50 = photo_50
        }
        if let photo_100 = dict["photo_100"] as? String {
            self.photo_100 = photo_100
        }
    }
}
