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
    
    @IBOutlet var tableView: UITableView!
    
    lazy var loadMoreSpinner: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        activityIndicator.frame = CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 44)
        activityIndicator.color = #colorLiteral(red: 0.2963480353, green: 0.4561202526, blue: 0.6371127963, alpha: 1)
        return activityIndicator
    }()
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "Загрузка обновлений...")
        refreshControl.tintColor = #colorLiteral(red: 0.2963480353, green: 0.4561202526, blue: 0.6371127963, alpha: 1)
        return refreshControl
    }()
    
    @objc private func handleRefresh(sender: UIRefreshControl) {
        let queue = DispatchQueue.global(qos: .userInitiated)
        queue.async {
            sleep(2)
            self.loadData()
            DispatchQueue.main.async {
                self.refreshControl.endRefreshing()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        configureTableView()
        loadData()
    }
    
    private func configureNavBar() {
        navigationItem.title = "Новости"
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        navigationItem.backBarButtonItem = backBarButtonItem
    }
    
    private func configureTableView() {
        tableView.register(UINib(nibName: "NewsItemTableViewCell", bundle: nil), forCellReuseIdentifier: "CellId")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = UITableViewAutomaticDimension
        tableView.rowHeight = UITableViewAutomaticDimension
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        tableView.tableFooterView?.isHidden = true
    }
    
    private func loadData(start_from: String? = nil) {
        var parameters = [AnyHashable : Any]()
        if let start_from = start_from {
            parameters["start_from"] = start_from
        }
        DispatchQueue.global(qos: .userInitiated).async {
            let getNewsRequest: VKRequest = VKRequest(method: "newsfeed.get", parameters: parameters)
            getNewsRequest.attempts = 10
            getNewsRequest.execute(resultBlock: { response in
                if let response = response {
                    if let dict = response.json as? [String: Any] {
                        let newsFeed = NewsFeed(dict: dict)
                        if start_from != nil && newsFeed.next_from != self.newsFeed.next_from {
                            self.newsFeed.add(feed: newsFeed)
                        } else {
                            self.newsFeed = newsFeed
                        }
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                }
            }) { error in
                print("error happened")
            }
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellId", for: indexPath) as! NewsItemTableViewCell
        let newsItem = newsFeed.items[indexPath.row]
        let text = newsItem.text
//       cell.textLabel?.text = text
        
        let date = Date(timeIntervalSince1970: newsItem.date)
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .medium
        
        var newsItemSourceImageUrl: String?
        var newsItemSourceName: String?
        if newsItem.source_id > 0 {
            let profile = newsFeed.profiles[newsItem.source_id]
            newsItemSourceImageUrl = profile?.photo_100
            newsItemSourceName = profile?.fullName
        
        } else if newsItem.source_id < 0 {
            let group = newsFeed.groups[-newsItem.source_id]
            newsItemSourceImageUrl = group?.photo_100
            newsItemSourceName = group?.name
        }
        
        if let newsItemSourceImageUrl = newsItemSourceImageUrl {
            cell.newsItemImageView.loadImageWithUrl(urlString: newsItemSourceImageUrl)
        }
        
        if let newsItemSourceName = newsItemSourceName {
//            cell.sourceNameTitleLabel.text = newsItemSourceName
            print("\(indexPath.row) \\ \(newsItemSourceName)")
        }
cell.sourceNameTitleLabel.text = text
//        cell.textLabel?.text = dateFormatter.string(from: date)
//        cell.textLabel?.text = "\(newsItem.source_id)"
//        cell.textLabel?.text = "\(indexPath.row)"
        
        
        
        return cell
    }
    
}

extension NewsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        performSegue(withIdentifier: "ShowDetailsView", sender: self)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastElement = newsFeed.items.count - 1
        if indexPath.row == lastElement {
            let spinner = self.loadMoreSpinner
            spinner.startAnimating()
            tableView.tableFooterView = spinner
            tableView.tableFooterView?.isHidden = false
            let queue = DispatchQueue.global(qos: .userInitiated)
            queue.async {
                sleep(2)
                self.loadData(start_from: self.newsFeed.next_from)
                DispatchQueue.main.async {
                    spinner.stopAnimating()
                    tableView.tableFooterView?.isHidden = true
                }
            }
        }
    }
}
