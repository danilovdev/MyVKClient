//
//  NewsViewController.swift
//  MyVKClient
//
//  Created by Alexey Danilov on 10.02.2018.
//  Copyright © 2018 danilovdev. All rights reserved.
//

import Foundation
import UIKit
import VK_ios_sdk

protocol LogOutHandlerDelegate {
    
    func handleLogout()
}

class NewsViewController: UIViewController {
    
    var newsFeed = NewsFeed()
    
    let cellId = "CellId"
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        navigationItem.backBarButtonItem = backBarButtonItem
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let getNewsRequest: VKRequest = VKRequest(method: "newsfeed.get", parameters: [:])
//        requestWithMethod:@"wall.get" andParameters:@{VK_API_OWNER_ID : @"-1"} andHttpMethod:@"GET"];
        getNewsRequest.attempts = 10
        getNewsRequest.execute(resultBlock: { response in
            print("success")
            
            if let response = response {
                if let dict = response.json as? [String: Any] {
                    self.newsFeed = NewsFeed(dict: dict)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    
                }
            }
        }) { error in
            print("error happened")
        }
    }
    
    @IBAction func logOutButtonTapped(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "Выход из приложения", message: "Вы уверены, что хотите выйти?", preferredStyle: .actionSheet)
        
        let exitAction = UIAlertAction(title: "Выйти", style: .destructive) { action in
            VKSdk.forceLogout()
        }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .default)
        
        alert.addAction(exitAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
}

extension NewsViewController: LogOutHandlerDelegate {
    
    func handleLogout() {
        navigationController?.popViewController(animated: true)
    }
}

extension NewsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsFeed.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        let newsItem = newsFeed.items[indexPath.row]
        let text = newsItem.text
       cell.textLabel?.text = text
        
        let date = Date(timeIntervalSince1970: newsItem.date)
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .medium
        
//        cell.textLabel?.text = dateFormatter.string(from: date)
        cell.textLabel?.text = "\(newsItem.source_id)"
        
        return cell
    }
    
}

extension NewsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        performSegue(withIdentifier: "ShowDetailsView", sender: self)
    }
}
