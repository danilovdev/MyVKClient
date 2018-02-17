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
    
    struct AuthorizeApi {
        
        static let VK_APP_ID = "6367694"
        
        static let VK_APP_SCOPE = ["wall", "photos", "email", "friends"]
        
    }
    
    private var logOutDelegate: LogOutHandlerDelegate!
    
    

    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let vkSdk = VKSdk.initialize(withAppId: AuthorizeApi.VK_APP_ID)
        vkSdk?.register(self)
        vkSdk?.uiDelegate = self
        authUserWithSdk()
    }
    
    @IBAction func loginWithSDKButtonTapped(_ sender: UIButton) {
        authUserWithSdk(forced: true)
    }
    
    func authUserWithSdk(forced: Bool = false) {
        VKSdk.wakeUpSession(AuthorizeApi.VK_APP_SCOPE as [Any]) { (authState, error) in
            if authState == VKAuthorizationState.authorized {
                print("user already authorized")
                self.performSegue(withIdentifier: "ShowMainView", sender: self)
            } else if let error = error {
                self.showError(title: "Ошибка авторизации", message: error.localizedDescription)
            } else if forced {
                VKSdk.authorize(AuthorizeApi.VK_APP_SCOPE as [Any])
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
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

