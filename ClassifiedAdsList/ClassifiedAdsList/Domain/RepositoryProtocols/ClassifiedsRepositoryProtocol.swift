//
//  ClassifiedsRepositoryProtocol.swift
//  ClassifiedAdsList
//
//  Created by evgenii.kurapov on 11.08.23.
//

import Foundation

protocol ClassifiedsRepositoryProtocol {
    func getClassifieds() async throws -> [Classified]
}
