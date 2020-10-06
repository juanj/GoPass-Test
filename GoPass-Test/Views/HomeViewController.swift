//
//  HomeViewController.swift
//  GoPass-Test
//
//  Created by Juan on 5/10/20.
//

import UIKit

class HomeViewController: BaseViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private var data = [Establishment]() {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        configureTableView()
        loadData()
    }

    private func configureTableView() {
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.register(UINib(nibName: "EstablishmentTableViewCell", bundle: nil), forCellReuseIdentifier: "establishmentCell")
    }

    private func loadData() {
        activityIndicator.startAnimating()
        view.isUserInteractionEnabled = false
        let service = EstablishmentService(restCleint: .shared)
        service.getAll { result in
            self.activityIndicator.stopAnimating()
            self.view.isUserInteractionEnabled = true
            switch result {
            case .success(let establishments):
                self.data = establishments
            case .failure(let error):
                self.showError(message: error.localizedDescription)
            }
        }
    }
}

extension HomeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "establishmentCell") as! EstablishmentTableViewCell

        let establishment = data[indexPath.row]
        cell.nameLabel.text = establishment.name
        cell.addressLabel.text = establishment.address
        cell.scheduleLabel.text = establishment.schedule
        if let latitud = establishment.latitud, let longitud = establishment.longitud {
            cell.locationLabel.text = "(\(latitud), \(longitud))"
        }

        if let imageurl = establishment.imageurl, let url = URL(string: imageurl) {
            ImageDownloader.shared.getImage(url: url) { image in
                cell.establishmentImageView.image = image
            }
        }
        
        return cell
    }
}
