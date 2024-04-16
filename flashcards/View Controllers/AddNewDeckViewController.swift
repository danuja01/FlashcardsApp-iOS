//
//  AddNewDeckViewController.swift
//  flashcards
//
//  Created by Danuja Jayasuriya on 2024-04-12.
//

import UIKit

class AddNewDeckViewController: UIViewController {

    @IBOutlet var deckNameTextField: UITextField!
    @IBOutlet var deckDescriptionTextView: CustomTextView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var nextBtn: GradientButton!
    
    var deckService: DeckService!
    var deckToEdit: Deck?

    override func viewDidLoad() {
        super.viewDidLoad()
        deckService = DeckService(context: AppDelegate.getContext())
        
        deckNameTextField.delegate = self 
        deckDescriptionTextView.delegate = self

        self.hideKeyboardWhenTappedAround()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

        if let deck = deckToEdit {
            deckNameTextField.text = deck.deckName
            deckDescriptionTextView.text = deck.deckDescription
            titleLabel.text = "EDIT DECK DETAILS"
            nextBtn.setTitle("Save", for: .normal)
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
           let keyboardDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval,
           let keyboardCurve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt {
            
            UIView.animate(withDuration: keyboardDuration, delay: 0, options: UIView.AnimationOptions(rawValue: keyboardCurve << 16), animations: {
                if self.deckDescriptionTextView.isFirstResponder {
                    self.view.frame.origin.y = -(keyboardSize.height / 2.5) 
                }
            }, completion: nil)
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval,
           let keyboardCurve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt {
            
            UIView.animate(withDuration: keyboardDuration, delay: 0, options: UIView.AnimationOptions(rawValue: keyboardCurve << 16), animations: {
                self.view.frame.origin.y = 0
            }, completion: nil)
        }
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        let deckName = deckNameTextField.text ?? ""
        let deckDescription = deckDescriptionTextView.text ?? ""
        
        if deckName.isEmpty || deckDescription.isEmpty {
            let emptyField = deckName.isEmpty ? "Deck Name" : "Deck Description"
            Alert.showAlert(on: self, title: "Missing Information", message: "\(emptyField) is required. Please fill it out before proceeding.")
            return
        }
        
        if let deck = deckToEdit {
            // Update the existing deck
            print("meka")
            deckService.updateDeck(deck: deck, newName: deckName, newDescription: deckDescription)
            NotificationCenter.default.post(name: .didUpdateDecks, object: nil)
            dismiss(animated: true, completion: nil)
        } else {
            // Create a new deck
            let newDeck = deckService.createDeck(deckName: deckName, description: deckDescription)
            performSegue(withIdentifier: "addFlashcardSegue", sender: newDeck)
        }
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addFlashcardSegue", let destinationVC = segue.destination as? AddNewFlashcardViewController {
            destinationVC.deck = sender as? Deck
            destinationVC.flashcardService = FlashcardService(context: AppDelegate.getContext())
            destinationVC.isCreatingNewDeck = true
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension AddNewDeckViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == deckNameTextField {
            deckDescriptionTextView.becomeFirstResponder()  // Move focus to the text view
        }
        return true  // Return YES to allow "Return" key to trigger
    }
}

extension AddNewDeckViewController: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            nextButtonTapped(self)
        }
        return true  
    }
}

