//
//  BaseViewController.swift
//  GoPass-Test
//
//  Created by Juan on 5/10/20.
//

import UIKit

class BaseViewController: UIViewController {
    func showError(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
