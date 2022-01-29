//
//  GetPokemonByIdUseCase.swift
//  ViperSample
//
//  Created by Rin on 2022/01/29.
//

import Foundation


final class GetPokemonByIdUseCase {
    
    func excute(_ parameter: Int, completion: ((Result<PokemonEntity, Error>) -> ())?) {
        let res = PokemonEntity(name: "フシギダネ", id: 1)
        completion?(.success(res))
    }
}
