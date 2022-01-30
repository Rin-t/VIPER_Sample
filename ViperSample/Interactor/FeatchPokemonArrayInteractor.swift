//
//  GetPokemonArrayUseCase.swift
//  ViperSample
//
//  Created by Rin on 2022/01/29.
//

import Foundation

final class FeatchPokemonArrayInteractor: FetchPokemonUseCase {

    func excute(_ parameter: Void, completion: ((Result<[PokemonEntity], Error>) -> ())?) async throws {
        let pokemonIdRange = 1...151
        let urls = pokemonIdRange.map { (n: Int) -> URL in
            let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(n)/")!
            return url
        }
        var pokemons = [PokemonEntity]()
        do {
            try await withThrowingTaskGroup(of: (Data, URLResponse).self) { group in
                for url in urls {
                    group.addTask {
                        return try await URLSession.shared.data(from: url)
                    }
                }

                for try await (fetchedData, _) in group {
                    let pokemon = try JSONDecoder().decode(PokemonEntity.self, from: fetchedData)
                    pokemons.append(pokemon)
                    pokemons.sort(by: { $0.id < $1.id } )
                }
            }
        } catch {
            print("failToFetchData")
            throw error
        }
        completion?(.success(pokemons))

    }
}
