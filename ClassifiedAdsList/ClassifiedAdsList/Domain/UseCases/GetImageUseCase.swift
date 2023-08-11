//
//  GetImageUseCase.swift
//  ClassifiedAdsList
//
//  Created by evgenii.kurapov on 11.08.23.
//

import Foundation

protocol GetImageUseCaseProtocol {
    func execute(url: String) async throws -> Data
}

final class GetImageUseCase: GetImageUseCaseProtocol {

    let imageRepository: ImageRepositoryProtocol

    init(imageRepository: ImageRepositoryProtocol) {
        self.imageRepository = imageRepository
    }

    func execute(url: String) async throws -> Data {
        return try await imageRepository.getImage(for: url)
    }
}
