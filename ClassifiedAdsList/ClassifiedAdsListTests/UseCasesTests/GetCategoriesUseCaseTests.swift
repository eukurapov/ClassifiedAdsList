//
//  GetCategoriesUseCaseTests.swift
//  ClassifiedAdsListTests
//
//  Created by evgenii.kurapov on 11.08.23.
//

import XCTest
@testable import ClassifiedAdsList

final class GetCategoriesUseCaseTests: XCTestCase {

    private let repository = CategoriesRepositoryProtocolMock()

    func testSuccessReturnValue() async throws {
        repository.getCategoriesCallHandler = {
            return [ClassifiedCategory.testValue()]
        }
        let useCase = GetCategoriesUseCase(categoriesRepository: repository)
        let categories = try await useCase.execute()

        XCTAssertEqual(repository.getCategoriesCallsCount, 1)
        XCTAssertEqual(categories.count, 1)
    }
}

private class CategoriesRepositoryProtocolMock: CategoriesRepositoryProtocol {

    var getCategoriesCallsCount: Int = 0
    var getCategoriesCallHandler: (() throws -> [ClassifiedCategory])?

    func getCategories() async throws -> [ClassifiedCategory] {
        getCategoriesCallsCount += 1
        return try getCategoriesCallHandler?() ?? []
    }
}

private extension ClassifiedCategory {
    static func testValue() -> Self {
        return .init(
            id: 1,
            name: "Test"
        )
    }
}

