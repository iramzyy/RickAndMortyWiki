//
//  CharactersListingViewModelTests.swift
//  RickAndMortyWiki
//
//  Created by Ahmed Ramzy on 28/09/2024.
//

import XCTest
import Combine
import Core
import CharactersDomain
import CharactersData
import CoreDomain

@testable import RickAndMortyWiki

class MockGetCharactersListUseCase: GetCharactersListUseCaseProtocol {
    var executeCallCount = 0
    var executeInput: GetCharactersListUseCaseInput?
    var executeResult: Result<CharactersList, CharacterError> = .failure(.unknown)
    
    func execute(input: GetCharactersListUseCaseInput) async -> Result<CharactersList, CharacterError> {
        executeCallCount += 1
        executeInput = input
        return executeResult
    }
}

class CharactersListViewModelTests: XCTestCase {
    var viewModel: CharactersListViewModel!
    var mockUseCase: MockGetCharactersListUseCase!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        mockUseCase = MockGetCharactersListUseCase()
        viewModel = CharactersListViewModel(useCase: mockUseCase) { _ in }
        cancellables = Set<AnyCancellable>()
    }
    
    override func tearDown() {
        viewModel = nil
        mockUseCase = nil
        cancellables = nil
        super.tearDown()
    }
    
    func testLoadData() async {
        // Given
        let expectation = XCTestExpectation(description: "Load data")
        mockUseCase.executeResult = .success(CharactersList(
            info: Info(count: 1, pages: 1, next: nil, prev: nil),
            results: [
                CharacterDetails(id: 1, name: "Rick", status: .alive, species: "Human", type: "", gender: "Male", origin: Location(name: "Earth", url: ""), location: Location(name: "Earth", url: ""), image: "url", episode: [], url: "", created: "")
            ]
        ))
        
        // When
        viewModel.loadData()
        
        // Then
        viewModel.$isLoading
            .dropFirst()
            .sink { isLoading in
                if !isLoading {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        await fulfillment(of: [expectation], timeout: 1.0)
        
        XCTAssertEqual(mockUseCase.executeCallCount, 1)
        XCTAssertEqual(viewModel.characters.count, 1)
        XCTAssertEqual(viewModel.characters.first?.name, "Rick")
    }
    
    func testLoadMore() async {
        // Given
        let initialExpectation = XCTestExpectation(description: "Initial load")
        let loadMoreExpectation = XCTestExpectation(description: "Load more")
        
        // Set up initial data
        mockUseCase.executeResult = .success(CharactersList(
            info: Info(count: 2, pages: 2, next: "https://nextpage.com", prev: nil),
            results: [
                CharacterDetails(id: 1, name: "Rick", status: .alive, species: "Human", type: "", gender: "Male", origin: Location(name: "Earth", url: ""), location: Location(name: "Earth", url: ""), image: "url", episode: [], url: "", created: "")
            ]
        ))
        
        // When - Load initial data
        viewModel.loadData()
        
        // Then - Wait for initial load to complete
        viewModel.$isLoading
            .dropFirst()
            .sink { isLoading in
                if !isLoading {
                    initialExpectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        await fulfillment(of: [initialExpectation], timeout: 1.0)
        
        // Verify initial load
        XCTAssertEqual(viewModel.characters.count, 1)
        XCTAssertEqual(viewModel.characters.first?.name, "Rick")
        
        // Set up data for loading more
        mockUseCase.executeResult = .success(CharactersList(
            info: Info(count: 2, pages: 2, next: nil, prev: "https://previouspage.com"),
            results: [
                CharacterDetails(id: 2, name: "Morty", status: .alive, species: "Human", type: "", gender: "Male", origin: Location(name: "Earth", url: ""), location: Location(name: "Earth", url: ""), image: "url", episode: [], url: "", created: "")
            ]
        ))
        
        // When - Load more data
        viewModel.loadMore()
        
        // Then - Wait for load more to complete
        viewModel.$isLoadingMore
            .dropFirst()
            .sink { isLoadingMore in
                if !isLoadingMore {
                    loadMoreExpectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        await fulfillment(of: [loadMoreExpectation], timeout: 1.0)
        
        // Verify after loading more
        XCTAssertEqual(mockUseCase.executeCallCount, 2)
        XCTAssertEqual(viewModel.characters.count, 2)
        XCTAssertEqual(viewModel.characters.first?.name, "Rick")
        XCTAssertEqual(viewModel.characters.last?.name, "Morty")
    }
    
    func testApplyFilter() async {
        // Given
        let expectation = XCTestExpectation(description: "Apply filter")
        mockUseCase.executeResult = .success(CharactersList(
            info: Info(count: 1, pages: 1, next: nil, prev: nil),
            results: [
                CharacterDetails(id: 1, name: "Rick", status: .alive, species: "Human", type: "", gender: "Male", origin: Location(name: "Earth", url: ""), location: Location(name: "Earth", url: ""), image: "url", episode: [], url: "", created: "")
            ]
        ))
        
        // When
        viewModel.selectedFilter = .alive
        
        // Then
        viewModel.$isLoading
            .dropFirst()
            .sink { isLoading in
                if !isLoading {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        await fulfillment(of: [expectation], timeout: 1.0)
        
        XCTAssertEqual(mockUseCase.executeCallCount, 1)
        XCTAssertEqual(mockUseCase.executeInput?.status, .alive)
        XCTAssertEqual(viewModel.characters.count, 1)
        XCTAssertEqual(viewModel.characters.first?.name, "Rick")
    }
    
    func testFetchCharactersFailure() async {
        // Given
        let expectation = XCTestExpectation(description: "Fetch characters failure")
        mockUseCase.executeResult = .failure(.unknown)
        
        // When
        viewModel.loadData()
        
        // Then
        viewModel.$isLoading
            .dropFirst()
            .sink { isLoading in
                if !isLoading {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        await fulfillment(of: [expectation], timeout: 1.0)
        
        XCTAssertEqual(mockUseCase.executeCallCount, 1)
        XCTAssertTrue(viewModel.characters.isEmpty)
    }
}
