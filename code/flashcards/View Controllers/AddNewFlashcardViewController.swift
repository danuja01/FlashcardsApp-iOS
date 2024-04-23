//
//  AddNewFlashcardViewController.swift
//  flashcards
//
//  Created by Danuja Jayasuriya on 2024-04-13.
//

import UIKit

class AddNewFlashcardViewController: UIViewController {
    
    var isCreatingNewDeck: Bool = false
    var flashcardToEdit: Flashcard?
    
    @IBOutlet var frontTextView: CustomTextView!
    @IBOutlet var backTextView: CustomTextView!
    @IBOutlet var mainButton: GradientButton!
    @IBOutlet var saveNdCloseBtn: UIButton!
    
    var deck: Deck!
    var flashcardService: FlashcardService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let flashcard = flashcardToEdit {
            frontTextView.text = flashcard.frontLabel
            backTextView.text = flashcard.backDescription
            mainButton.setTitle("Save", for: .normal)
            saveNdCloseBtn.isHidden = true
        }
        
        frontTextView.delegate = self
        backTextView.delegate = self
        
        self.hideKeyboardWhenTappedAround()

        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
              let keyboardDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval,
              let keyboardCurve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt else { return }
        
        UIView.animate(withDuration: keyboardDuration, delay: 0, options: UIView.AnimationOptions(rawValue: keyboardCurve << 16), animations: {
            if self.backTextView.isFirstResponder {
                self.view.frame.origin.y = -(keyboardSize.height / 1.2)
            } else if self.frontTextView.isFirstResponder {
                self.view.frame.origin.y = 0
            }
        }, completion: nil)
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        guard let keyboardDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval,
              let keyboardCurve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt else { return }
        
        UIView.animate(withDuration: keyboardDuration, delay: 0, options: UIView.AnimationOptions(rawValue: keyboardCurve << 16), animations: {
            self.view.frame.origin.y = 0
        }, completion: nil)
    }
    
    @IBAction func addAnotherButtonTapped(_ sender: Any) {
        guard validateTextFields() else { return }
        addFlashcardToDeck()
        if (flashcardToEdit != nil) {
            closeSegue()
        } else {
            frontTextView.text = ""
            backTextView.text = ""
            Alert.showAlert(on: self, title: "Success", message: "Flashcard added!", actionTitle: "OK")
        }
    }
    
    @IBAction func saveAndCloseButtonTapped(_ sender: Any) {
        guard validateTextFields() else { return }
        addFlashcardToDeck()
        closeSegue()
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        closeSegue()
    }
    
    private func validateTextFields() -> Bool {
        let frontText = frontTextView.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let backText = backTextView.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""

        if frontText.isEmpty || backText.isEmpty {
            let message = frontText.isEmpty ? "Front text is required." : "Back text is required."
            Alert.showAlert(on: self, title: "Missing Information", message: message)
            return false
        }
        return true
    }
    
    private func addFlashcardToDeck() {
        let frontText = frontTextView.text!
        let backText = backTextView.text!
        
        if let flashcard = flashcardToEdit {
            // Update existing flashcard
            flashcard.frontLabel = frontText
            flashcard.backDescription = backText
        } else {
            // Add new flashcard
            flashcardService.addFlashcard(to: deck, flashcardID: UUID().uuidString, frontLabel: frontText, backDescription: backText, status: "pending")
        }
        
        AppDelegate.shared.saveContext()
        NotificationCenter.default.post(name: .didUpdateDecks, object: nil)
        NotificationCenter.default.post(name: .didUpdateFavourites, object: nil)
    }

    
    private func closeSegue() {
        NotificationCenter.default.post(name: .didUpdateDecks, object: nil)
        NotificationCenter.default.post(name: .didUpdateFavourites, object: nil)
        if isCreatingNewDeck {
            self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension AddNewFlashcardViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            if textView == frontTextView {
                backTextView.becomeFirstResponder()
            } else {
                textView.resignFirstResponder()
                addAnotherButtonTapped(self)
            }
            return false
        }
        return true
    }
}


