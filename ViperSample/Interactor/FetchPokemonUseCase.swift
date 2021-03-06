//
//  UseCaseProtocol.swift
//  ViperSample
//
//  Created by Rin on 2022/01/29.
//

import Foundation


protocol FetchPokemonUseCase where Failure: Error {
    associatedtype Parameter
    associatedtype Success
    associatedtype Failure

    func excute(_ parameter: Parameter, completion: ((Result<Success, Failure>) -> ())?) async throws
}

class FetchPokemonInteractor<Parameter, Success, Failure: Error> {

    private let instance: UseCaseInstanceBase<Parameter, Success, Failure>

    init<T: FetchPokemonUseCase>(_ useCase: T) where
        T.Parameter == Parameter,
        T.Success == Success,
        T.Failure == Failure {
        self.instance = UseCaseInstance(useCase)
    }

    func excute(_ parameter: Parameter, completion: ((Result<Success, Failure>) -> ())?) {
        instance.excute(parameter, completion: completion)
    }
}

private extension FetchPokemonInteractor {

    class UseCaseInstanceBase<Parameter, Success, Failure: Error> {
        func excute(_ parameter: Parameter, completion: ((Result<Success, Failure>) -> ())?) {
            fatalError()
        }
    }

    class UseCaseInstance<T: FetchPokemonUseCase>: UseCaseInstanceBase<T.Parameter, T.Success, T.Failure> {

        private let useCase: T

        init(_ useCase: T) {
            self.useCase = useCase
        }

        override func excute(_ parameter: T.Parameter, completion: ((Result<T.Success, T.Failure>) -> ())?) {
            Task {
                do {
                    try await useCase.excute(parameter, completion: completion)
                } catch {
                    print("error")
                }
            }
        }
    }
}
