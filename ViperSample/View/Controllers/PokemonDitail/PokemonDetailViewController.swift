//
//  PokemonDetailViewController.swift
//  ViperSample
//
//  Created by Rin on 2022/01/29.
//

import UIKit

final class PokemonDetailViewController: UIViewController {

    // IBOutlet
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var idLabel: UILabel!

    // Propaties
    var pokemonEntity: PokemonEntity!
    var presenter: PokemonDetailPresentation!

    // LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPresenter()
        setupViews()
    }

    // Methods
    private func setupPresenter() {
        presenter = PokemonDetailPresenter(view: self, inject: PokemonDetailPresenter.Dependency(getPokemonByIdUseCase: FetchPokemonInteractor(FeatchPokemonByIdInteractor())))
        presenter.didLoad(pokemonEntity: pokemonEntity)
    }

    private func setupViews() {
        nameLabel.text = pokemonEntity.name
        idLabel.text = String(pokemonEntity.id)
    }
}

//MARK: - PokemonDetailView
extension PokemonDetailViewController: PokemonDetailView {

    func showPokemon(_ pokemonEntity: PokemonEntity) {
        // nameLabel.text = pokemonEntity.name
        // idLabel.text = String(pokemonEntity.id)
    }

    func showError(_ error: Error) {
        print("error")
    }
}
