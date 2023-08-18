//
//  Classified+DTO.swift
//  ClassifiedAdsList
//
//  Created by evgenii.kurapov on 18.08.23.
//

import Foundation

extension Classified {

    private static var dateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formatter
    }()

    static func from(dto: ClassifiedDTO, categoryDTO: CategoryDTO) -> Classified? {
        guard let creationDate = Classified.dateFormatter.date(from: dto.creationDateString) else {
            return nil
        }

        return .init(
            id: dto.id,
            category: ClassifiedCategory.from(dto: categoryDTO),
            title: dto.title,
            description: dto.description,
            price: dto.price,
            creationDate: creationDate,
            isUrgent: dto.isUrgent,
            images: .init(
                smallUrl: dto.imagesUrl.small ?? "",
                thumbUrl: dto.imagesUrl.thumb ?? ""
            )
        )
    }
}
