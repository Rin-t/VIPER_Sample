//
//  UseCaseProtocol.swift
//  ViperSample
//
//  Created by Rin on 2022/01/29.
//

import Foundation


protocol UseCaseProtocol where Failure: Error {
    associatedtype Parameter
    associatedtype Success
    associatedtype Failure

    func excute(_ parameter: Parameter, completion: ((Result<Success, Failure>) -> ())?)
}

class UseCase<Parameter, Success, Failure: Error> {

    private let instance: UseCaseInstanceBase<Parameter, Success, Failure>

    init<T: UseCaseProtocol>(_ useCase: T) where
        T.Parameter == Parameter,
        T.Success == Success,
        T.Failure == Failure {
        self.instance = UseCaseInstance(useCase)
    }
}

private extension UseCase {

    class UseCaseInstanceBase<Parameter, Success, Failure: Error> {
        func excute(_ parameter: Parameter, completion: ((Result<Success, Failure>) -> ())?) {
            fatalError()
        }
    }

    class UseCaseInstance<T: UseCaseProtocol>: UseCaseInstanceBase<T.Parameter, T.Success, T.Failure> {

        private let useCase: T

        init(_ useCase: T) {
            self.useCase = useCase
        }

        override func excute(_ parameter: T.Parameter, completion: ((Result<T.Success, T.Failure>) -> ())?) {
            useCase.excute(parameter, completion: completion)
        }
    }
}
