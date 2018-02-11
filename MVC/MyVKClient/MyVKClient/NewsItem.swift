//
//  NewsItem.swift
//  MyVKClient
//
//  Created by Alexey Danilov on 11.02.2018.
//  Copyright © 2018 danilovdev. All rights reserved.
//

import UIKit

struct NewsItem {
    
//    var type: String
//
    var source_id: Int64
//
    var date: Double
//
//    var post_id: Int64
//
//    var post_type: String
//
    var text: String
//
//    var comments: Comments
//
//    var likes: Likes
//
//    var reposts: Reposts
//
//    var views: Views
    
//    var attachments: [Attachment]
//
//    var geo: Geo
    
    init(dict: Dictionary<String, Any>) {
        if let text = dict["text"] as? String {
            self.text = text
        } else {
            self.text = ""
        }
        
        if let date = dict["date"] as? Double {
            self.date = date
        } else {
            self.date = Double(Date().timeIntervalSince1970)
        }
        
        if let source_id = dict["source_id"] as? Int64 {
            self.source_id = source_id
        } else {
            self.source_id = 0
        }
    }
    
}
