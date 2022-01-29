//
//  PokemonDetailPresenter.swift
//  ViperSample
//
//  Created by Rin on 2022/01/29.
//

import Foundation

protocol PokemonDetailPresenterProtocol: AnyObject {

    func didLoad(pokemonEntity: PokemonEntity)
}

protocol PokemonDetailViewProtocol: AnyObject {
    func showPokemon(_ pokemonEntity: PokemonEntity)
    func showError(_ error: Error)
}

class PokemonDetailPresenter {

    struct Dependency {
        let getPokemonByIdUseCase: UseCase<Int, PokemonEntity, Error>
    }

    weak var view : PokemonDetailViewProtocol!
    private var di: Dependency

    init(view: PokemonDetailViewProtocol, inject dependency: Dependency) {
        self.view = view
        self.di = dependency
    }
}

extension PokemonDetailPresenter: PokemonDetailPresenterProtocol {

    func didLoad(pokemonEntity: PokemonEntity) {
        di.getPokemonByIdUseCase.excute(pokemonEntity.id) { [weak self] result in
            switch result {
            case .success(let pokemonEntity):
                self?.view.showPokemon(pokemonEntity)
            case .failure(let error):
                self?.view.showError(error)
            }
        }
    }
}
