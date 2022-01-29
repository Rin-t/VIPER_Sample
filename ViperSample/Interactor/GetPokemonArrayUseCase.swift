//
//  GetPokemonArrayUseCase.swift
//  ViperSample
//
//  Created by Rin on 2022/01/29.
//

import Foundation

final class GetPokemonArrayUseCase: UseCaseProtocol {

    func excute(_ parameter: Void, completion: ((Result<[PokemonEntity], Error>) -> ())?) {
        let res: [PokemonEntity] = [
            PokemonEntity(name: "フシギダネ", id: 1),
            PokemonEntity(name: "フシギソウ", id: 2)
        ]
        completion?(.success(res))

    }

    
}
