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
        newCard.setQuestion(currentFlashcard.frontLabel)
        newCard.setAnswer(currentFlashcard.backDescription)
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
        // Delay the dismissal to allow the progress bar to update visually
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.dismiss(animated: true, completion: nil)
        }
    }
}

extension SwippableViewController: SwappableCardDelegate {
    func didSwipe(direction: String) {
        print(direction == "right" ? "Completed" : "Skipped")

        if currentCardIndex < (flashcards?.count ?? 0) - 1 {
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
