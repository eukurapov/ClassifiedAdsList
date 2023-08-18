//
//  Classified.swift
//  ClassifiedAdsList
//
//  Created by evgenii.kurapov on 11.08.23.
//

import Foundation

struct Classified {
    let id: Int
    let category: ClassifiedCategory
    let title: String
    let description: String
    let price: Double
    let creationDate: Date
    let isUrgent: Bool
    let images: ClassifiedImage
}
