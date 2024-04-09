//
//  CustomBlurView.swift
//  UIKit for iOS 15
//
//  Created by Sai Kambampati on 11/1/21.
//

import UIKit

@IBDesignable
class CustomBlurView: UIVisualEffectView {
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.cornerCurve = .continuous
            layer.masksToBounds = true
        }
    }
}
