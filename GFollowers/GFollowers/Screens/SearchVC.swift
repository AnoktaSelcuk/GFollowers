//
//  SearchVC.swift
//  GFollowers
//
//  Created by Alperen Selçuk on 9.12.2021.
//  Copyright © 2021 Alperen Selçuk. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {

    //MARK: Variable & Constant
    let logoImageView           = UIImageView()
    let usernameTextField       = GFTextField()
    let callToActionButton      = GFButton(backgroundColor: .systemGreen, title: "Get Followers")
    
    var isUserNameEntered: Bool { return !usernameTextField.text!.isEmpty }
    
    //MARK: Viewlife cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor    = .systemBackground
        
        configureLogoImageView()
        configureTextField()
        configueCallToActionButton()
        createDismissKeyboardTapRecognizer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    //MARK: Configuration
    func configureLogoImageView() {
        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = UIImage(named: "gh-logo")!
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func configureTextField() {
        view.addSubview(usernameTextField)
        usernameTextField.delegate = self
        
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            usernameTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func configueCallToActionButton() {
        view.addSubview(callToActionButton)
        callToActionButton.addTarget(self, action: #selector(pushFollowersVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            callToActionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            callToActionButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func createDismissKeyboardTapRecognizer() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    //MARK: Objc method
    @objc func pushFollowersVC() {
        guard isUserNameEntered else {
//            print("no username") // debug icin
            presentGFAlertOnMainThread(title: "Empty user name", message: "Please enter the user name we need to know who to look for 👮‍♂️", buttonTitle: "OK")
            return
        }
        
        let followersListVC = FollewersListVC()
        followersListVC.userName = usernameTextField.text
        followersListVC.title = usernameTextField.text
        navigationController?.pushViewController(followersListVC, animated: true)
    }
}

extension SearchVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        print("did tap return ") //debug icin
        pushFollowersVC()
        return true
    }
}
