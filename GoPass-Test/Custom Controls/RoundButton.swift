//
//  RoundButton.swift
//  GoPass-Test
//
//  Created by Juan on 5/10/20.
//

import UIKit

class RoundButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)

        configureStyle()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        configureStyle()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        layer.cornerRadius = frame.height / 2
    }

    private func configureStyle() {
        backgroundColor = .neonGreen
        setTitleColor(.black, for: .normal)
    }
}
