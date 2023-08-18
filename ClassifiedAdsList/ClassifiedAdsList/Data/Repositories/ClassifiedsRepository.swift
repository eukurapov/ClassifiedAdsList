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
        async let classifiedDTOs = classifiedsAPIService.getClassifieds()
        async let categoryDTOs = categoriesAPIService.getCategories()

        return try await classifieds(from: classifiedDTOs, categoryDTOs: categoryDTOs)
    }

    private func classifieds(from dtos: [ClassifiedDTO], categoryDTOs: [CategoryDTO]) -> [Classified] {
        return dtos.compactMap { classifiedDTO in
            let categoryDTO = categoryDTOs.first { $0.id == classifiedDTO.categoryId }
            guard let categoryDTO else { return nil }

            return Classified.from(dto: classifiedDTO, categoryDTO: categoryDTO)
        }
    }
}
