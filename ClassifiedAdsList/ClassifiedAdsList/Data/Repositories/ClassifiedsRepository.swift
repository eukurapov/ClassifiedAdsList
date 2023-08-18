//
//  ClassifiedsRepository.swift
//  ClassifiedAdsList
//
//  Created by evgenii.kurapov on 18.08.23.
//

import Foundation

final class ClassifiedsRepository: ClassifiedsRepositoryProtocol {

    private let classifiedsAPIService: ClassifiedsAPIServiceProtocol
    private let categoriesAPIService: CategoriesAPIServiceProtocol

    init(
        classifiedsAPIService: ClassifiedsAPIServiceProtocol,
        categoriesAPIService: CategoriesAPIServiceProtocol
    ) {
        self.classifiedsAPIService = classifiedsAPIService
        self.categoriesAPIService = categoriesAPIService
    }

    func getClassifieds() async throws -> [Classified] {
        let classifiedDTOs = try await classifiedsAPIService.getClassifieds()
        let categoryDTOs = try await categoriesAPIService.getCategories()

        return classifiedDTOs.compactMap { classifiedDTO in
            let categoryDTO = categoryDTOs.first { $0.id == classifiedDTO.categoryId }
            guard let categoryDTO else { return nil }

            return Classified.from(dto: classifiedDTO, categoryDTO: categoryDTO)
        }
    }
}
