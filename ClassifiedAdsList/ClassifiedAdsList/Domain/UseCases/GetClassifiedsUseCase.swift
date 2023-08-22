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
        let classifieds = try await classifiedsRepository.getClassifieds()
        return classifieds.sorted { lhs, rhs in
            switch (lhs.isUrgent, rhs.isUrgent) {
            case (true, true), (false, false): return lhs.creationDate > rhs.creationDate
            case (true, false): return true
            case (false, true): return false
            }
        }
    }
}
