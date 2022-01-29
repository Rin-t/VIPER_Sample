//
//  PokemonListRouter.swift
//  ViperSample
//
//  Created by Rin on 2022/01/29.
//

import Foundation
import UIKit

protocol PokemonListRouterProtocol: AnyObject {
    func pokemonDetail(pokemonEntity: PokemonEntity)
}

final class PokemonListRouter: PokemonListRouterProtocol {

    weak var view: UIViewController!

    init(view: UIViewController) {
        self.view = view
    }

    func pokemonDetail(pokemonEntity: PokemonEntity) {
        let pokemonDetailViewController = PokemonDetailViewController()
        print(pokemonEntity.name)
        pokemonDetailViewController.pokemonEntity = pokemonEntity

        pokemonDetailViewController.presenter = PokemonDetailPresenter(view: pokemonDetailViewController,
                                                                       inject: PokemonDetailPresenter.Dependency(
                                                                        getPokemonByIdUseCase: UseCase(GetPokemonByIdUseCase()))
        )

        view.show(pokemonDetailViewController, sender: nil)
    }
}
