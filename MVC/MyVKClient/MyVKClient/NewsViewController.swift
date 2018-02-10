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
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
