//
//  CategoriesRepository.swift
//  ClassifiedAdsList
//
//  Created by evgenii.kurapov on 18.08.23.
//

import Foundation

final class CategoriesRepository: CategoriesRepositoryProtocol {

    private let categoriesAPIService: CategoriesAPIServiceProtocol

    init(categoriesAPIService: CategoriesAPIServiceProtocol) {
        self.categoriesAPIService = categoriesAPIService
    }

    func getCategories() async throws -> [ClassifiedCategory] {
        let categoriesDTOs = try await categoriesAPIService.getCategories()
        return categoriesDTOs.map { dto in
            ClassifiedCategory.from(dto: dto)
        }
    }
}
