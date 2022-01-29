//
//  PokemonDetailViewController.swift
//  ViperSample
//
//  Created by Rin on 2022/01/29.
//

import UIKit



final class PokemonDetailViewController: UIViewController {

    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var idLabel: UILabel!

    var pokemonEntity: PokemonEntity!
    var presenter: PokemonDetailPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = PokemonDetailPresenter(view: self, inject: PokemonDetailPresenter.Dependency(getPokemonByIdUseCase: UseCase(GetPokemonByIdUseCase())))
        presenter.didLoad(pokemonEntity: pokemonEntity)
        nameLabel.text = pokemonEntity.name
        idLabel.text = String(pokemonEntity.id)
    }
}

extension PokemonDetailViewController: PokemonDetailViewProtocol {

    func showPokemon(_ pokemonEntity: PokemonEntity) {
        // nameLabel.text = pokemonEntity.name
        // idLabel.text = String(pokemonEntity.id)
    }

    func showError(_ error: Error) {
        print("error")
    }
}
