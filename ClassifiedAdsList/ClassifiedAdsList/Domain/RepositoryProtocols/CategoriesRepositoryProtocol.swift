//
//  CategoriesRepositoryProtocol.swift
//  ClassifiedAdsList
//
//  Created by evgenii.kurapov on 11.08.23.
//

import Foundation

protocol CategoriesRepositoryProtocol {
    func getCategories() async throws -> [ClassifiedCategory]
}
