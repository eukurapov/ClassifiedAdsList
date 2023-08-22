//
//  ClassifiedViewModel.swift
//  ClassifiedAdsList
//
//  Created by evgenii.kurapov on 21.08.23.
//

import Combine
import Foundation

final class ClassifiedViewModel: ObservableObject {

    private let getImageUseCase: GetImageUseCase
    private let classified: Classified

    private static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm dd MMM yyyy"
        return formatter
    }()

    var title: String { classified.title }
    var categoryName: String { classified.category.name }
    var price: Double { classified.price }
    var creationDateString: String { Self.formatter.string(from: classified.creationDate) }
    var description: String { classified.description }
    var isUrgent: Bool { classified.isUrgent }
    @Published var thumbImageData: Data?
    @Published var smallImageData: Data?

    init(getImageUseCase: GetImageUseCase, classified: Classified) {
        self.getImageUseCase = getImageUseCase
        self.classified = classified
    }

    func fetchThumbImage() {
        Task {
            let imageData = try await getImageUseCase.execute(url: classified.images.thumbUrl)
            thumbImageData = imageData
        }
    }

    func fetchSmallImage() {
        Task {
            let imageData = try await getImageUseCase.execute(url: classified.images.smallUrl)
            smallImageData = imageData
        }
    }
}
