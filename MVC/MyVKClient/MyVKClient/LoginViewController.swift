//
//  ViewController.swift
//  MyVKClient
//
//  Created by Alexey Danilov on 10.02.2018.
//  Copyright © 2018 danilovdev. All rights reserved.
//

import UIKit
import VK_ios_sdk

class LoginViewController: UIViewController {
    
    private var logOutDelegate: LogOutHandlerDelegate!
    
    let VK_APP_ID = "6367694"
    
    let VK_APP_SCOPE = ["wall", "photos", "email", "friends"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vkSdk = VKSdk.initialize(withAppId: VK_APP_ID)
        vkSdk?.register(self)
        vkSdk?.uiDelegate = self
        authUserWithSdk()
    }
    
    @IBAction func loginWithSDKButtonTapped(_ sender: UIButton) {
        authUserWithSdk(forced: true)
    }
    
    func authUserWithSdk(forced: Bool = false) {
        VKSdk.wakeUpSession(VK_APP_SCOPE as [Any]) { (authState, error) in
            if authState == VKAuthorizationState.authorized {
                print("user already authorized")
                self.performSegue(withIdentifier: "ShowMainView", sender: self)
            } else if let error = error {
                self.showError(title: "Ошибка авторизации", message: error.localizedDescription)
            } else if forced {
                VKSdk.authorize(self.VK_APP_SCOPE as [Any])
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowMainView" {
            if let destination = segue.destination as? NewsViewController {
                self.logOutDelegate = destination
                destination.navigationItem.hidesBackButton = true
            }
        }
    }

}

extension LoginViewController: VKSdkDelegate {
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        if result.token != nil {
            performSegue(withIdentifier: "ShowMainView", sender: self)
        } else if let error = result.error {
            showError(title: "Ошибка авторизации", message: error.localizedDescription)
        }
    }
    
    func vkSdkUserAuthorizationFailed() {
    }
    
    func vkSdkAccessTokenUpdated(_ newToken: VKAccessToken!, oldToken: VKAccessToken!) {
        if newToken == nil && oldToken != nil {
            if let logOutDelegate = self.logOutDelegate {
                logOutDelegate.handleLogout()
            }
        }
    }
    
    func showError(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Отмена", style: .default)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
    
}

extension LoginViewController: VKSdkUIDelegate {
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        present(controller, animated: true)
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
    }
    
}

