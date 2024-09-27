//
//  GetCharacterDetailsUseCaseTests.swift
//  Domain
//
//  Created by Ahmed Ramzy on 27/09/2024.
//

@testable import CoreDomain
@testable import CharactersDomain
import XCTest

final class GetCharacterDetailsUseCaseTests: XCTestCase {
    var repoSuccessMock: CharactersRepoSuccessMock!
    var repoFailedMock: CharactersRepoFailureMock!

    var getCharacterDetailsUseCase: GetCharacterDetailsUseCase!

    override func setUpWithError() throws {
        repoSuccessMock = CharactersRepoSuccessMock()
        repoFailedMock = CharactersRepoFailureMock()
    }

    override func tearDownWithError() throws {
        repoSuccessMock = nil
        repoFailedMock = nil
        getCharacterDetailsUseCase = nil
    }

    func testGetCharactersSuccess() async throws {
        getCharacterDetailsUseCase = GetCharacterDetailsUseCase(repo: repoSuccessMock)

        let result = await getCharacterDetailsUseCase.execute(
            input: GetCharacterDetailRepoInput(
                id: 1
            )
        )

        // Assert
        switch result {
        case let .success(model):
            XCTAssertEqual(model.name, "Character name #1")
        case .failure:
            // Handle the failure case
            XCTFail("Unexpected failure")
        }
    }

    func testGetCharactersFailed() async throws {
        getCharacterDetailsUseCase = GetCharacterDetailsUseCase(repo: repoFailedMock)

        let result = await getCharacterDetailsUseCase.execute(
            input: GetCharacterDetailRepoInput(
                id: 1
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
