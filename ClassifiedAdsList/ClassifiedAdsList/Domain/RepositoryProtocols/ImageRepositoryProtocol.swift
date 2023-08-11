//
//  ImageRepositoryProtocol.swift
//  ClassifiedAdsList
//
//  Created by evgenii.kurapov on 11.08.23.
//

import Foundation

protocol ImageRepositoryProtocol {
    func getImage(for url: String) async throws -> Data
}
