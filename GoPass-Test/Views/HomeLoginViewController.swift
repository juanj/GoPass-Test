//
//  HomeLoginViewController.swift
//  GoPass-Test
//
//  Created by Juan on 5/10/20.
//

import UIKit

class HomeLoginViewController: BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        let typeService = TypesService(restCleint: .shared)
        typeService.getDocumentTypes { result in
            switch result {
            case .success(let documents):
                guard let documents = documents else { return }
                OptionsValues.shared.documentTypes = documents
            case .failure(let error):
                self.showError(message: error.localizedDescription)
            }
        }
    }

    @IBAction func signUp(_ sender: Any) {
        navigationController?.pushViewController(SignUpViewController(), animated: true)
    }
}
