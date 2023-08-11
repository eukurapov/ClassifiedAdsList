//
//  GetCategoriesUseCase.swift
//  ClassifiedAdsList
//
//  Created by evgenii.kurapov on 11.08.23.
//

import Foundation

protocol GetCategoriesUseCaseProtocol {
    func execute() async throws -> [ClassifiedCategory]
}

final class GetCategoriesUseCase: GetCategoriesUseCaseProtocol {

    let categoriesRepository: CategoriesRepositoryProtocol

    init(categoriesRepository: CategoriesRepositoryProtocol) {
        self.categoriesRepository = categoriesRepository
    }

    func execute() async throws -> [ClassifiedCategory] {
        return try await categoriesRepository.getCategories()
    }
}
