//
//  UIView+Ext.swift
//  ExIOSTest
//
//  Created by Vinh Nguyen on 29/7/25.
//

import UIKit

@IBDesignable
extension UIView {
    
    @IBInspectable
    var cornerRadius: CGFloat {
        set { layer.cornerRadius = newValue }
        get { return layer.cornerRadius     }
    }
    
    @IBInspectable
    var borderWitdh: CGFloat {
        set { layer.borderWidth = newValue}
        get { return layer.borderWidth}
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        set { layer.borderColor = newValue?.cgColor}
        get {
            guard let color = layer.borderColor else {
                return nil
            }
            return UIColor(cgColor: color)
        }
    }
}
