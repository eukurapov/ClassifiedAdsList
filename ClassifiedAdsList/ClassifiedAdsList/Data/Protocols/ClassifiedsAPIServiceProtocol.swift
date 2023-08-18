//
//  ClassifiedsAPIServiceProtocol.swift
//  ClassifiedAdsList
//
//  Created by evgenii.kurapov on 18.08.23.
//

import Foundation

protocol ClassifiedsAPIServiceProtocol {
    func getClassifieds() async throws -> [ClassifiedDTO]
}
