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
            return [Classified.testValue()]
        }
        let useCase = GetClassifiedsUseCase(classifiedsRepository: repository)
        let classifieds = try await useCase.execute()

        XCTAssertEqual(repository.getClassifiedsCallsCount, 1)
        XCTAssertEqual(classifieds.count, 1)
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
    static func testValue() -> Classified {
        return .init(
            id: 1,
            categoryId: 1,
            title: "Test",
            description: "Test Description",
            price: 100.00,
            creationDate: Date(),
            isUrgent: false,
            images: .init(smallUrl: "", thumbUrl: "")
        )
    }
}
