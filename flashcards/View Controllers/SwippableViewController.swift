import UIKit

class SwippableViewController: UIViewController {
    
    var currentCardIndex = 0
    var flashcards: [Flashcard]?
    
    @IBOutlet var card: SwappableCard!
    @IBOutlet var progressBar: UIProgressView!
    @IBOutlet var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNextCard()
        progressBar.progress = 0
        progressLabel.text = "\(currentCardIndex) of \(flashcards?.count ?? 0) Total Cards"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        ToastManager.shared.showToast(on: self, message: "Tap on card to flip between question and answer, swipe left to skip or swipe right to complete it", duration: 5.0)
    }

    // Ensures the card stays centered
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        card?.center = view.center
    }

    private func setupNextCard() {
        guard let flashcards = flashcards, currentCardIndex < flashcards.count else {
            finishQuiz()
            return
        }

        if let existingCard = card {
            existingCard.removeFromSuperview() // Remove the existing card if it exists
        }

        let newCard = SwappableCard(frame: CGRect(x: 0, y: 0, width: 300, height: 500))
        newCard.center = view.center
        newCard.delegate = self  // Set this view controller as the delegate
        let currentFlashcard = flashcards[currentCardIndex]
        newCard.setQuestion(currentFlashcard.frontLabel ?? "No question available")
        newCard.setAnswer(currentFlashcard.backDescription ?? "No answer available")
        view.addSubview(newCard)
        card = newCard
    }


    private func updateProgress() {
        guard let flashcards = flashcards else { return }
        let progress = Float(currentCardIndex) / Float(flashcards.count)
        progressBar.setProgress(progress, animated: true)
        progressLabel.text = "\(currentCardIndex) of \(flashcards.count) Total Cards"
    }


    private func finishQuiz() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.dismiss(animated: true, completion: nil)
        }
    }
}

extension SwippableViewController: SwappableCardDelegate {
    func didSwipe(direction: String) {
        guard let flashcards = flashcards, currentCardIndex < flashcards.count else { return }
        let flashcard = flashcards[currentCardIndex]

        if direction == "right" {
            flashcard.status = "completed"
            print("Flashcard completed")
        } else if direction == "left" {
            flashcard.status = "skipped"
            print("Flashcard skipped")
        }

        AppDelegate.shared.saveContext()
        
        NotificationCenter.default.post(name: .didUpdateFlashcards, object: nil)
        NotificationCenter.default.post(name: .didUpdateDecks, object: nil)
        NotificationCenter.default.post(name: .didUpdateFavourites, object: nil)

        if currentCardIndex < flashcards.count - 1 {
            currentCardIndex += 1
            updateProgress()
            setupNextCard()
        } else {
            currentCardIndex += 1
            updateProgress()
            finishQuiz()
        }
    }
}


