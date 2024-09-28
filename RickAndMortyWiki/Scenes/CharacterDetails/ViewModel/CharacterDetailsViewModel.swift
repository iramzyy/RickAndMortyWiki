//
//  CharacterDetailsViewModel.swift
//  RickAndMortyWiki
//
//  Created by Ahmed Ramzy on 28/09/2024.
//

import Foundation
import Combine
import CharactersDomain
import DesignKit

enum CharacterDetailsViewModelCallbackType {
    case back
}

typealias CharacterDetailsViewModelCallback = ((CharacterDetailsViewModelCallbackType) -> Void)

class CharacterDetailsViewModel: ObservableObject {
    private let useCase: GetCharacterDetailsUseCaseProtocol
    private let characterID: Int
    private var cancellables = Set<AnyCancellable>()
    
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var character: CharacterModel?
    
    let callback: CharacterDetailsViewModelCallback
    
    init(useCase: GetCharacterDetailsUseCaseProtocol,
         characterID: Int,
         callback: @escaping CharacterDetailsViewModelCallback) {
        self.useCase = useCase
        self.characterID = characterID
        self.callback = callback
    }
    
    func loadData() {
        Task {
            await setLoading(to: true)
            let input = GetCharacterDetailUseCaseInput(id: self.characterID)
            let result = await useCase.execute(input: input)
            await processResult(result)
            await setLoading(to: false)
        }
    }
    
    @MainActor
    private func setLoading(to value: Bool) {
        isLoading = value
    }
    
    @MainActor
    private func processResult(_ result: Result<CharacterDetails, CharacterError>) {
        switch result {
        case .success(let details):
            character = CharacterModel(
                id: details.id ?? 0,
                name: details.name ?? "",
                species: details.species ?? "",
                location: details.location?.name ?? "",
                gender: details.gender ?? "",
                status: details.status ?? .unknown,
                image: details.image ?? ""
            )
        case .failure:
            // Handle error
            print("Error fetching character details")
        }
    }
}
