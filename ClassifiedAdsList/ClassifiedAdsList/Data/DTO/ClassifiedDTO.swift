//
//  ClassifiedDTO.swift
//  ClassifiedAdsList
//
//  Created by evgenii.kurapov on 11.08.23.
//

import Foundation

struct ClassifiedDTO: Decodable {
    let id: Int
    let categoryId: Int
    let title: String
    let description: String
    let price: Double
    let creationDateString: String
    let isUrgent: Bool
    let imagesUrl: ImagesUrl
}

extension ClassifiedDTO {
    enum CodingKeys: String, CodingKey {
        case id
        case categoryId = "category_id"
        case title
        case description
        case price
        case creationDateString = "creation_date"
        case isUrgent = "is_urgent"
        case imagesUrl = "images_url"
    }
}

extension ClassifiedDTO {
    struct ImagesUrl: Decodable {
        let small: String
        let thumb: String
    }
}
