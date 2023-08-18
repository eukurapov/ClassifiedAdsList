//
//  ClassifiedCategory+DTO.swift
//  ClassifiedAdsList
//
//  Created by evgenii.kurapov on 18.08.23.
//

import Foundation

extension ClassifiedCategory {
    static func from(dto: CategoryDTO) -> ClassifiedCategory {
        return .init(id: dto.id, name: dto.name)
    }
}
