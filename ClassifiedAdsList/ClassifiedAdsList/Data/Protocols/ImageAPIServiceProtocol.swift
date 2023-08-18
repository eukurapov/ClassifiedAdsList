//
//  ImageAPIServiceProtocol.swift
//  ClassifiedAdsList
//
//  Created by evgenii.kurapov on 18.08.23.
//

import Foundation

protocol ImageAPIServiceProtocol {
    func getImage(for url: String) async throws -> Data
}
