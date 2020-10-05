//
//  HomeLoginViewController.swift
//  GoPass-Test
//
//  Created by Juan on 5/10/20.
//

import UIKit

class HomeLoginViewController: UIViewController {
    @IBOutlet weak var signUpButton: UIButton!

    @IBAction func signUp(_ sender: Any) {
        navigationController?.pushViewController(SignUpViewController(), animated: true)
    }
}
