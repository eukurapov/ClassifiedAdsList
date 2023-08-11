//
//  GetClassifiedsUseCase.swift
//  ClassifiedAdsList
//
//  Created by evgenii.kurapov on 11.08.23.
//

import Foundation

protocol GetClassifiedsUseCaseProtocol {
    func execute() async throws -> [Classified]
}

final class GetClassifiedsUseCase: GetClassifiedsUseCaseProtocol {

    let classifiedsRepository: ClassifiedsRepositoryProtocol

    init(classifiedsRepository: ClassifiedsRepositoryProtocol) {
        self.classifiedsRepository = classifiedsRepository
    }

    func execute() async throws -> [Classified] {
        return try await classifiedsRepository.getClassifieds()
    }
}
