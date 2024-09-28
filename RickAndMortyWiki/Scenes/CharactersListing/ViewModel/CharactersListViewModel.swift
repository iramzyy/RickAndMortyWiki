//
//  CharactersListViewModel.swift
//  RickAndMortyWiki
//
//  Created by Ahmed Ramzy on 28/09/2024.
//

import Foundation
import Combine
import CharactersDomain

enum CharactersListViewModelCallbackType {
    case details(id: Int)
}

typealias CharactersListViewModelCallback = ((CharactersListViewModelCallbackType) -> Void)

class CharactersListViewModel {
    private let useCase: GetCharactersListUseCaseProtocol
    private var totalPages: Int = 0
    private var cancellables = Set<AnyCancellable>()
    private var fetchTask: Task<Void, Never>?

    @Published private(set) var isLoading: Bool = false
    @Published private(set) var isLoadingMore: Bool = false
    @Published var selectedFilter: CharacterStatus?
    @Published private(set) var characters: [CharacterModel] = []

    let callback: CharactersListViewModelCallback
    let filters: [CharacterStatus] = CharacterStatus.allCases
    private(set) var currentPage: Int = 1

    init(useCase: GetCharactersListUseCaseProtocol,
         callback: @escaping CharactersListViewModelCallback) {
        self.useCase = useCase
        self.callback = callback
        observeFilterChanges()
    }
    
    func loadData() {
        guard !isLoading else { return }
        fetchCharacters(isInitialLoad: true)
    }
    
    func loadMore() {
        guard currentPage < totalPages, !isLoading, !isLoadingMore else { return }
        currentPage += 1
        fetchCharacters(isInitialLoad: false)
    }
    
    func didSelectCharacter(index: Int) {
        guard index < characters.count else { return }
        callback(.details(id: characters[index].id))
    }
    
    private func observeFilterChanges() {
        $selectedFilter
            .dropFirst()
            .removeDuplicates()
            .debounce(for: .milliseconds(100), scheduler: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.applyFilter()
            }
            .store(in: &cancellables)
    }
    
    private func applyFilter() {
        fetchTask?.cancel()
        characters = []
        currentPage = 1
        fetchCharacters(isInitialLoad: true)
    }
    
    private func fetchCharacters(isInitialLoad: Bool) {
        if isInitialLoad {
            fetchTask?.cancel()
            isLoading = true
        } else {
            isLoadingMore = true
        }
        
        fetchTask = Task { [weak self] in
            guard let self = self else { return }
            
            let input = GetCharactersListUseCaseInput(
                page: self.currentPage,
                status: self.selectedFilter
            )
            
            let result = await self.useCase.execute(input: input)
            guard !Task.isCancelled else { return }
            
            await self.map(result: result, isInitialLoad: isInitialLoad)
        }
    }
    
    @MainActor
    private func map(result: Result<CharactersList, CharacterError>, isInitialLoad: Bool) {
        defer {
            isLoading = false
            isLoadingMore = false
        }
        
        switch result {
        case let .success(response):
            let newCharacters = response.results.compactMap { character in
                CharacterModel(
                    id: character.id ?? 0,
                    name: character.name ?? "",
                    species: character.species ?? "",
                    location: character.location?.name ?? "",
                    gender: character.gender ?? "",
                    status: character.status ?? .unknown,
                    image: character.image ?? ""
                )
            }
            
            guard !newCharacters.isEmpty else { return }
            
            if isInitialLoad {
                characters = newCharacters
            } else {
                characters.append(contentsOf: newCharacters)
            }
            totalPages = response.info?.pages ?? 0
            
        case .failure:
            consoleLogger.error("Error fetching characters")
        }
    }
}
