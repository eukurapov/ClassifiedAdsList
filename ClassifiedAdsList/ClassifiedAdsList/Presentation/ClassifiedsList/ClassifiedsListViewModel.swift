//
//  ClassifiedsListViewModel.swift
//  ClassifiedAdsList
//
//  Created by evgenii.kurapov on 21.08.23.
//

import Combine
import Foundation

final class ClassifiedsListViewModel: ObservableObject {

    private let getClassifiedsUseCase: GetClassifiedsUseCase
    private let getImageUseCase: GetImageUseCase
    private let selectionHandler: ((ClassifiedViewModel) -> Void)?

    @Published var classifieds = [Classified]()

    init(
        getClassifiedsUseCase: GetClassifiedsUseCase,
        getImageUseCase: GetImageUseCase,
        selectionHandler: ((ClassifiedViewModel) -> Void)?
    ) {
        self.getClassifiedsUseCase = getClassifiedsUseCase
        self.getImageUseCase = getImageUseCase
        self.selectionHandler = selectionHandler
    }

    func fetch() {
        Task {
            let result = try? await getClassifiedsUseCase.execute()
            classifieds = result ?? []
        }
    }

    func selectItem(indexPath: IndexPath) {
        guard let classifiedViewModel = classifiedViewModel(for: indexPath) else { return }
        selectionHandler?(classifiedViewModel)
    }

    func classifiedViewModel(for indexPath: IndexPath) -> ClassifiedViewModel? {
        guard indexPath.item < classifieds.count else { return nil }
        return ClassifiedViewModel(
            getImageUseCase: getImageUseCase,
            classified: classifieds[indexPath.item]
        )
    }
}
