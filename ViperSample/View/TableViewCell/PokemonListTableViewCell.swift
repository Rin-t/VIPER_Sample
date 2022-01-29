//
//  HomeTableViewCell.swift
//  ViperSample
//
//  Created by Rin on 2022/01/27.
//

import UIKit


final class PokemonListTableViewCell: UITableViewCell {

    // outlets
    @IBOutlet private weak var nameLabel: UILabel!

    // statics
    static let identifire = "PokemonListTableViewCell"
    static func nib() -> UINib {
        UINib(nibName: identifire, bundle: nil)
    }

    // methods
    func configure(_ pokemonEntity: PokemonEntity) {
        nameLabel.text = pokemonEntity.name
    }

}
