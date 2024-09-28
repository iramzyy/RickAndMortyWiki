//
//  CharacterDetailsViewModelTests.swift
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

class MockGetCharacterDetailsUseCase: GetCharacterDetailsUseCaseProtocol {
    var executeCallCount = 0
    var executeInput: GetCharacterDetailUseCaseInput?
    var executeResult: Result<CharacterDetails, CharacterError> = .failure(.unknown)
    
    func execute(input: GetCharacterDetailUseCaseInput) async -> Result<CharacterDetails, CharacterError> {
        executeCallCount += 1
        executeInput = input
        return executeResult
    }
}

class CharacterDetailsViewModelTests: XCTestCase {
    var viewModel: CharacterDetailsViewModel!
    var mockUseCase: MockGetCharacterDetailsUseCase!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        mockUseCase = MockGetCharacterDetailsUseCase()
        viewModel = CharacterDetailsViewModel(useCase: mockUseCase, characterID: 1) { _ in }
        cancellables = Set<AnyCancellable>()
    }
    
    override func tearDown() {
        viewModel = nil
        mockUseCase = nil
        cancellables = nil
        super.tearDown()
    }
    
    func testLoadDataSuccess() async {
        // Given
        let expectation = XCTestExpectation(description: "Load data")
        mockUseCase.executeResult = .success(CharacterDetails(
            id: 1,
            name: "Rick Sanchez",
            status: .alive,
            species: "Human",
            type: "",
            gender: "Male",
            origin: Location(name: "Earth", url: ""),
            location: Location(name: "Earth", url: ""),
            image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
            episode: [],
            url: "",
            created: ""
        ))
        
        // When
        viewModel.loadData()
        
        // Then
        viewModel.$isLoading
            .dropFirst(2) // Drop the initial false and the true when loading starts
            .sink { isLoading in
                if !isLoading {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        await fulfillment(of: [expectation], timeout: 1.0)
        
        XCTAssertEqual(mockUseCase.executeCallCount, 1)
        XCTAssertEqual(mockUseCase.executeInput?.id, 1)
        XCTAssertNotNil(viewModel.character)
        XCTAssertEqual(viewModel.character?.name, "Rick Sanchez")
        XCTAssertEqual(viewModel.character?.species, "Human")
        XCTAssertEqual(viewModel.character?.status, .alive)
    }
    
    func testLoadDataFailure() async {
        // Given
        let expectation = XCTestExpectation(description: "Load data failure")
        mockUseCase.executeResult = .failure(.unknown)
        
        // When
        viewModel.loadData()
        
        // Then
        viewModel.$isLoading
            .dropFirst(2) // Drop the initial false and the true when loading starts
            .sink { isLoading in
                if !isLoading {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        await fulfillment(of: [expectation], timeout: 1.0)
        
        XCTAssertEqual(mockUseCase.executeCallCount, 1)
        XCTAssertNil(viewModel.character)
    }
    
    func testInitialization() {
        XCTAssertEqual(viewModel.isLoading, false)
        XCTAssertNil(viewModel.character)
    }
    
    func testCallback() {
        // Given
        let expectation = XCTestExpectation(description: "Callback called")
        var callbackCalled = false
        
        viewModel = CharacterDetailsViewModel(useCase: mockUseCase, characterID: 1) { callbackType in
            if case .back = callbackType {
                callbackCalled = true
                expectation.fulfill()
            }
        }
        
        // When
        viewModel.callback(.back)
        
        // Then
        wait(for: [expectation], timeout: 1.0)
        XCTAssertTrue(callbackCalled)
    }
}
