//
//  HomeTableViewCell.swift
//  ViperSample
//
//  Created by Rin on 2022/01/27.
//

import UIKit


final class HomeTableViewCell: UITableViewCell {

    // outlets
    @IBOutlet private weak var titleLabel: UILabel!

    // statics
    static let identifire = "HomeTableViewCell"
    static func nib() -> UINib {
        UINib(nibName: identifire, bundle: nil)
    }

    // methods
    func configure() {

    }

}
