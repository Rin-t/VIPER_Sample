//
//  GetPokemonByIdUseCase.swift
//  ViperSample
//
//  Created by Rin on 2022/01/29.
//

import Foundation

final class GetPokemonByIdUseCase: UseCaseProtocol {
    
    func excute(_ parameter: Int, completion: ((Result<PokemonEntity, Error>) -> ())?) async throws {
        let res = PokemonEntity(name: "フシギダネ", id: 1)
        completion?(.success(res))
    }
}
