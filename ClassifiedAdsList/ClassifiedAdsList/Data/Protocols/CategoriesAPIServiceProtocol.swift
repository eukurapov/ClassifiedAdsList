//
//  CategoriesAPIServiceProtocol.swift
//  ClassifiedAdsList
//
//  Created by evgenii.kurapov on 18.08.23.
//

import Foundation

protocol CategoriesAPIServiceProtocol {
    func getCategories() async throws -> [CategoryDTO]
}
