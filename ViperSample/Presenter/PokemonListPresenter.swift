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

    struct Dependency {
        let router: PokemonListRouterProtocol!
        let getPokemonArrayUseCase: UseCase<Void, [PokemonEntity], Error>
    }

    weak var view: PokemonListViewProtocol!
    private var di: Dependency

    init(view: PokemonListViewProtocol, inject dependency: Dependency) {
        self.view = view
        self.di = dependency
    }
}

extension PokemonListPresenter: PokemonListPresenterProtocol {
    
    func didLoad() {
        di.getPokemonArrayUseCase.excute(()) { [weak self] result in
            switch result {
            case .success(let pokemonEntities):
                if pokemonEntities.isEmpty {
                    self?.view.showEmpty()
                    return
                }
                self?.view.showPokemon(pokemonEntities)
            case .failure(let error):
                self?.view.showError(error)
            }
        }
    }

    func didSelect(pokemonEntity: PokemonEntity) {
        print(pokemonEntity.name)
        di.router.pokemonDetail(pokemonEntity: pokemonEntity)
    }
}
