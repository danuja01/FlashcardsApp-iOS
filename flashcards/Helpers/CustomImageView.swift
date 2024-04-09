//
//  CustomImageView.swift
//  UIKit for iOS 15
//
//  Created by Sai Kambampati on 11/7/21.
//

import UIKit

@IBDesignable
class CustomImageView: UIImageView {
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.cornerCurve = .continuous
            layer.masksToBounds = true
        }
    }
}
