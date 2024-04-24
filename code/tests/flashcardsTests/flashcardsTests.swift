import XCTest
@testable import flashcards

final class flashcardsTests: XCTestCase {
    
    var viewController: MyDecksViewController!
    var mockDeckService: MockDeckService!

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockDeckService = MockDeckService(context: createInMemoryManagedObjectContext())
        viewController = MyDecksViewController()
        viewController.deckService = mockDeckService
    }
    
    override func tearDownWithError() throws {
        viewController = nil
        mockDeckService = nil
        super.tearDown()
    }
    
    func testFetchDecksPopulatesDecksCorrectly() {
        mockDeckService.mockDecks = [Deck(), Deck(), Deck()]
        
        
        viewController.fetchDecks()
        
    
        XCTAssertFalse(viewController.allDecks.isEmpty, "All decks should not be empty after fetching.")
        XCTAssertFalse(viewController.recentDecks.isEmpty, "Recent decks should not be empty after fetching.")
    }
}
