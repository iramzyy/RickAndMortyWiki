//
//  GetCharactersListUseCaseTests.swift
//  Domain
//
//  Created by Ahmed Ramzy on 27/09/2024.
//

@testable import CoreDomain
@testable import CharactersDomain
import XCTest

final class GetCharactersListUseCaseTests: XCTestCase {
    var repoSuccessMock: CharactersRepoSuccessMock!
    var repoFailedMock: CharactersRepoFailureMock!

    var getCharacterListUseCase: GetCharactersListUseCase!

    override func setUpWithError() throws {
        repoSuccessMock = CharactersRepoSuccessMock()
        repoFailedMock = CharactersRepoFailureMock()
    }

    override func tearDownWithError() throws {
        repoSuccessMock = nil
        repoFailedMock = nil
        getCharacterListUseCase = nil
    }

    func testGetCharactersSuccess() async throws {
        getCharacterListUseCase = GetCharactersListUseCase(repo: repoSuccessMock)

        let result = await getCharacterListUseCase.execute(
            input: GetCharactersListUseCaseInput(
                page: 1
            )
        )

        // Assert
        switch result {
        case let .success(model):
            XCTAssertEqual(model.results.count, 3)
            XCTAssertEqual(model.results.first?.name, "Character name #1")
            XCTAssertEqual(model.results.last?.name, "Character name #3")
        case .failure:
            // Handle the failure case
            XCTFail("Unexpected failure")
        }
    }

    func testGetCharactersFailed() async throws {
        getCharacterListUseCase = GetCharactersListUseCase(repo: repoFailedMock)

        let result = await getCharacterListUseCase.execute(
            input: GetCharactersListUseCaseInput(
                page: 1
            )
        )

        switch result {
        case .success:
            XCTFail("Unexpected failure")
        case let .failure(failure):
            XCTAssertEqual(
                failure.localizedDescription,
                CharacterError.unknown.localizedDescription
            )
        }
    }
}
