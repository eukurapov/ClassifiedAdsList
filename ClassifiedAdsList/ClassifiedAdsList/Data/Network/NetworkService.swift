//
//  NetworkService.swift
//  ClassifiedAdsList
//
//  Created by evgenii.kurapov on 18.08.23.
//

import Foundation

final class NetworkService: NetworkServiceProtocol {
    func request<DTO>(url: URL) async throws -> DTO where DTO: Decodable {
        let (data, _) = try await URLSession.shared.data(for: URLRequest(url: url))
        let jsonDecoder = JSONDecoder()
        return try jsonDecoder.decode(DTO.self, from: data)
    }
}
