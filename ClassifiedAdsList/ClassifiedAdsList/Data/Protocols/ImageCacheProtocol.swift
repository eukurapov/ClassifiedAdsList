//
//  ImageCacheProtocol.swift
//  ClassifiedAdsList
//
//  Created by evgenii.kurapov on 18.08.23.
//

import Foundation

protocol ImageCacheProtocol {
    func getImage(for url: String) async throws -> Data
    func setImage(_ data: Data, for url: String)
}
