//
//  CustomTextView.swift
//  flashcards
//
//  Created by Danuja Jayasuriya on 2024-04-13.
//

import UIKit

class CustomTextView: UITextView {
    @IBInspectable var cornerRadius: CGFloat {
          get {
              return layer.cornerRadius
          }
          set {
              layer.cornerRadius = newValue
          }
      }
      
      @IBInspectable var borderWidth: CGFloat {
          get {
              return layer.borderWidth
          }
          set {
              layer.borderWidth = newValue
          }
      }
      
      @IBInspectable var borderColor: UIColor? {
          get {
              guard let cgColor = layer.borderColor else { return nil }
              return UIColor(cgColor: cgColor)
          }
          set {
              layer.borderColor = newValue?.cgColor
          }
      }
      
      @IBInspectable var placeholder: String = "" {
          didSet {
              setNeedsDisplay()
          }
      }
    
    // Adjust text container insets
    override func layoutSubviews() {
        super.layoutSubviews()
        textContainerInset = UIEdgeInsets(top: 8, left: 7, bottom: 8, right: 7)  // Adjust the padding here
        // Ensuring the placeholder is redrawn correctly with insets
        setNeedsDisplay()
    }

      override func draw(_ rect: CGRect) {
          super.draw(rect)
          if text.isEmpty && !isFirstResponder {
              let placeholderRect = rect.insetBy(dx: 7, dy: 7)
              let paragraphStyle = NSMutableParagraphStyle()
              paragraphStyle.alignment = textAlignment
              let attributes: [NSAttributedString.Key: Any] = [
                  .font: font ?? UIFont.systemFont(ofSize: 16),
                  .paragraphStyle: paragraphStyle,
                  .foregroundColor: UIColor.placeholderText
              ]
              placeholder.draw(in: placeholderRect, withAttributes: attributes)
          }
      }
}
