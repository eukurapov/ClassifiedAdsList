//
//  ImageRepository.swift
//  ClassifiedAdsList
//
//  Created by evgenii.kurapov on 18.08.23.
//

import Foundation

final class ImageRepository: ImageRepositoryProtocol {

    private let imageCache: ImageCacheProtocol?
    private let imageAPIService: ImageAPIServiceProtocol

    init(imageCache: ImageCacheProtocol?, imageAPIService: ImageAPIServiceProtocol) {
        self.imageCache = imageCache
        self.imageAPIService = imageAPIService
    }

    func getImage(for url: String) async throws -> Data {
        if let cachImage = try? await imageCache?.getImage(for: url) {
            return cachImage
        } else {
            let image = try await imageAPIService.getImage(for: url)
            imageCache?.setImage(image, for: url)
            return image
        }
    }
}
