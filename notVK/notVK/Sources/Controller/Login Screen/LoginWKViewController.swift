//
//  LoginWKViewController.swift
//  notVK
//
//  Created by Roman on 14.05.2020.
//  Copyright © 2020 DrewMyScreen. All rights reserved.
//

import UIKit
import WebKit

class LoginWKViewController: UIViewController {
    
    @IBOutlet private weak var WKLoginView: WKWebView!
    @IBOutlet private weak var bottomConstraint: NSLayoutConstraint!
    
    let notificationCenter = NotificationCenter.default

    override func viewDidLoad() {
        super.viewDidLoad()
        WKLoginView.load(VKRequestService.loginRequest())
        WKLoginView.navigationDelegate = self
        
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        WKLoginView?.addGestureRecognizer(hideKeyboardGesture)

        notificationCenter.addObserver(
            self,
            selector: #selector(keyboardWasShown(notification:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)

        notificationCenter.addObserver(
            self,
            selector: #selector(keyboardWasShown(notification:)),
            name: UIResponder.keyboardDidChangeFrameNotification,
            object: nil)

        notificationCenter.addObserver(
            self,
            selector: #selector(keyboardWillBeHidden(notification:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        notificationCenter.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc private func keyboardWasShown(notification: Notification) {
        let userInfo = (notification as NSNotification).userInfo as! [String: Any]
        let frame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
        bottomConstraint.constant = frame.height
    }

    @objc private func keyboardWillBeHidden(notification: Notification) {
        bottomConstraint.constant = 0
    }

    @objc private func hideKeyboard() {
        self.WKLoginView.endEditing(true)
    }
}

extension LoginWKViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment else {
            decisionHandler(.allow)
            return
        }
        
        let parameters = fragment
            .components(separatedBy: "&")
            .map{ $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
        }
        
        guard let token = parameters["access_token"], let userId = parameters["user_id"] else { return }
        
        Session.shared.token = token
        Session.shared.userId = Int(userId) ?? 0
        
        print("Current token: \(Session.shared.token)")
        print("Current userID: \(Session.shared.userId)\n")

        decisionHandler(.cancel)

        performSegue(withIdentifier: "loginSegue", sender: nil)
    }
}
