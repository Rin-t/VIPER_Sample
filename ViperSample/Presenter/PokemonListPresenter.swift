//
//  PokemonListPresenter.swift
//  ViperSample
//
//  Created by Rin on 2022/01/29.
//

import Foundation

protocol PokemonListPresentation: AnyObject {
    func didLoad()
    func didSelect(pokemonEntity: PokemonEntity)
}

protocol PokemonListView: AnyObject {
    func showPokemon(_ pokemonEntities: [PokemonEntity])
    func showEmpty()
    func showError(_ error: Error)
}

class PokemonListPresenter {

    struct Dependency {
        let router: PokemonListRouterWireFrame!
        let getPokemonArrayUseCase: FetchPokemonInteractor<Void, [PokemonEntity], Error>
    }

    weak var view: PokemonListView!
    private var di: Dependency

    init(view: PokemonListView, inject dependency: Dependency) {
        self.view = view
        self.di = dependency
    }
}

extension PokemonListPresenter: PokemonListPresentation {
    
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
