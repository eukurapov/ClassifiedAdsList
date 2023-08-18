//
//  NetworkServiceProtocol.swift
//  ClassifiedAdsList
//
//  Created by evgenii.kurapov on 18.08.23.
//

import Foundation

protocol NetworkServiceProtocol {
    func request<DTO>(url: URL) async throws -> DTO where DTO: Decodable
}
