//
//  ImageAPIService.swift
//  ClassifiedAdsList
//
//  Created by evgenii.kurapov on 18.08.23.
//

import Foundation

final class ImageAPIService: ImageAPIServiceProtocol {
    func getImage(for url: String) async throws -> Data {
        guard let url = URL(string: url) else {
            throw DataError.incorrectAddress
        }
        let (data, _) = try await URLSession.shared.data(for: URLRequest(url: url))
        return data
    }
}
