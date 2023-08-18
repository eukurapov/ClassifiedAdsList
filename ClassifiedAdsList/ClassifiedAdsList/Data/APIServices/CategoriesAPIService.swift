//
//  CategoriesAPIService.swift
//  ClassifiedAdsList
//
//  Created by evgenii.kurapov on 18.08.23.
//

import Foundation

final class CategoriesAPIService: CategoriesAPIServiceProtocol {

    private let network: NetworkServiceProtocol
    private let categoriesUrl = "https://raw.githubusercontent.com/leboncoin/paperclip/master/categories.json"

    internal init(network: NetworkServiceProtocol) {
        self.network = network
    }

    func getCategories() async throws -> [CategoryDTO] {
        guard let url = URL(string: categoriesUrl) else {
            throw DataError.incorrectAddress
        }
        return try await network.request(url: url)
    }
}
