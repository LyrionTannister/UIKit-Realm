//
//  ViewController.swift
//  notVK
//
//  Created by Roman on 31.03.2020.
//  Copyright © 2020 DrewMyScreen. All rights reserved.
//

import UIKit

class LoginController: UIViewController {

    @IBOutlet weak var scrollBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var userPasswordLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loginScrollView: UIScrollView!
    
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var leftLoadingDot: Dots!
    @IBOutlet weak var centerLoadingDot: Dots!
    @IBOutlet weak var rightLoadingDot: Dots!
    
    

    let notificationCenter = NotificationCenter.default
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animateLoadingDots()

        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        loginScrollView?.addGestureRecognizer(hideKeyboardGesture)

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

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        switch identifier {
        case "loginSegue":
            let isAuth = login()
            if !isAuth {
                showErrorAlert()
            }
            return isAuth
        default:
            return true
        }
    }

    func login() -> Bool {
        let login = loginTextField.text!
        let password = passwordTextField.text!
        return login == "root" && password == "toor"
    }

    func showErrorAlert() {
        let alert = UIAlertController(
            title: "Ошибка",
            message: "Введены неверные данные пользователя",
            preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true)
    }

    @objc func keyboardWasShown(notification: Notification) {
        let userInfo = (notification as NSNotification).userInfo as! [String: Any]
        let frame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
        scrollBottomConstraint.constant = frame.height
    }

    @objc func keyboardWillBeHidden(notification: Notification) {
        scrollBottomConstraint.constant = 0
    }

    @objc func hideKeyboard() {
        self.loginScrollView.endEditing(true)
    }
    
    func animateLoadingDots() {
        UIView.animate(withDuration: 1, delay: 0, options: [.repeat, .autoreverse], animations: { self.leftLoadingDot.alpha = 0 })
        UIView.animate(withDuration: 1, delay: 0.333, options: [.repeat, .autoreverse], animations: { self.centerLoadingDot.alpha = 0 })
        UIView.animate(withDuration: 1, delay: 0.666, options: [.repeat, .autoreverse], animations: { self.rightLoadingDot.alpha = 0 })

    }
}


