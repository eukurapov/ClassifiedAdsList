//
//  GetClassifiedsUseCaseTests.swift
//  ClassifiedAdsListTests
//
//  Created by evgenii.kurapov on 11.08.23.
//

import XCTest
@testable import ClassifiedAdsList

final class GetClassifiedsUseCaseTests: XCTestCase {

    private let repository = ClassifiedsRepositoryProtocolMock()

    func testSuccessReturnValue() async throws {
        repository.getClassifiedsCallHandler = {
            return Classified.testValues()
        }
        let useCase = GetClassifiedsUseCase(classifiedsRepository: repository)
        let classifieds = try await useCase.execute()

        XCTAssertEqual(repository.getClassifiedsCallsCount, 1)
        XCTAssertEqual(classifieds.count, 4)
        XCTAssertEqual(classifieds.map(\.id), [1,2,3,4])
    }
}

private class ClassifiedsRepositoryProtocolMock: ClassifiedsRepositoryProtocol {

    var getClassifiedsCallsCount: Int = 0
    var getClassifiedsCallHandler: (() throws -> [Classified])?

    func getClassifieds() async throws -> [Classified] {
        getClassifiedsCallsCount += 1
        return try getClassifiedsCallHandler?() ?? []
    }
}

private extension Classified {
    static func testValues() -> [Classified] {
        return [
            .init(
                id: 4,
                category: ClassifiedCategory(id: 1, name: "test category"),
                title: "Test",
                description: "Test Description",
                price: 100.00,
                creationDate: Date()-1,
                isUrgent: false,
                images: .init(smallUrl: "", thumbUrl: "")
            ),
            .init(
                id: 2,
                category: ClassifiedCategory(id: 1, name: "test category"),
                title: "Test",
                description: "Test Description",
                price: 100.00,
                creationDate: Date()-1,
                isUrgent: true,
                images: .init(smallUrl: "", thumbUrl: "")
            ),
            .init(
                id: 1,
                category: ClassifiedCategory(id: 1, name: "test category"),
                title: "Test",
                description: "Test Description",
                price: 100.00,
                creationDate: Date(),
                isUrgent: true,
                images: .init(smallUrl: "", thumbUrl: "")
            ),
            .init(
                id: 3,
                category: ClassifiedCategory(id: 1, name: "test category"),
                title: "Test",
                description: "Test Description",
                price: 100.00,
                creationDate: Date(),
                isUrgent: false,
                images: .init(smallUrl: "", thumbUrl: "")
            )
        ]
    }
}
