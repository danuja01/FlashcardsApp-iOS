//
//  GradientButton.swift
//  flashcards
//
//  Created by Danuja Jayasuriya on 2024-04-10.
//

import UIKit


@IBDesignable
class GradientButton: UIButton {
    
    private var gradientLayer = CAGradientLayer()
    
    @IBInspectable var startColor: UIColor = UIColor.red {
        didSet {
            updateColors()
        }
    }
    
    @IBInspectable var endColor: UIColor = UIColor.blue {
        didSet {
            updateColors()
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            gradientLayer.cornerRadius = cornerRadius
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGradient()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupGradient()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
    
    private func setupGradient() {
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        gradientLayer.cornerRadius = cornerRadius
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func updateColors() {
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
    }
    
}
