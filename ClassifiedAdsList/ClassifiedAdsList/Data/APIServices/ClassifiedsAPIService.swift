//
//  ClassifiedsAPIService.swift
//  ClassifiedAdsList
//
//  Created by evgenii.kurapov on 18.08.23.
//

import Foundation

final class ClassifiedsAPIService: ClassifiedsAPIServiceProtocol {

    private let network: NetworkServiceProtocol
    private let categoriesUrl = "https://raw.githubusercontent.com/leboncoin/paperclip/master/listing.json"

    internal init(network: NetworkServiceProtocol) {
        self.network = network
    }

    func getClassifieds() async throws -> [ClassifiedDTO] {
        guard let url = URL(string: categoriesUrl) else {
            throw DataError.incorrectAddress
        }
        return try await network.request(url: url)
    }
}
