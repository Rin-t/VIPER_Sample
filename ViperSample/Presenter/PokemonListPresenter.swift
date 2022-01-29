//
//  PokemonListPresenter.swift
//  ViperSample
//
//  Created by Rin on 2022/01/29.
//

import Foundation

protocol PokemonListPresenterProtocol: AnyObject {
    func didLoad()
    func didSelect(pokemonEntity: PokemonEntity)
}

protocol PokemonListViewProtocol: AnyObject {
    func showPokemon(_ pokemonEntities: [PokemonEntity])
    func showEmpty()
    func showError(_ error: Error)
}

class PokemonListPresenter {

    weak var view: PokemonListViewProtocol!

    init(view: PokemonListViewProtocol) {
        self.view = view
    }
}

extension PokemonListPresenter: PokemonListPresenterProtocol {
    
    func didLoad() {
        <#code#>
    }

    func didSelect(pokemonEntity: PokemonEntity) {
        <#code#>
    }
}
