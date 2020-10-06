//
//  EstablishmentTableViewCell.swift
//  GoPass-Test
//
//  Created by Juan on 5/10/20.
//

import UIKit

class EstablishmentTableViewCell: UITableViewCell {
    @IBOutlet weak var establishmentImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var scheduleLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        prepareForReuse()

        establishmentImageView.layer.cornerRadius = 5
    }

    override func prepareForReuse() {
        establishmentImageView.image = nil
        nameLabel.text = ""
        scheduleLabel.text = ""
        addressLabel.text = ""
        locationLabel.text = ""
    }
}
