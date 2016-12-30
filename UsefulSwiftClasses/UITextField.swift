//
//  UITextField.swift
//  
//  Created by usagimaru on 2016.12.30.
//  Copyright © 2016 usagimaru. All rights reserved.
//
//

import UIKit

extension UITextField {
	
	@IBInspectable var localizedText: String? {
		get {
			return text
		}
		set {
			if let key = newValue {
				if let attributedText = self.attributedText {
					let mAttribtuedText = NSMutableAttributedString(attributedString: attributedText)
					mAttribtuedText.mutableString.setString(key.localized)
					self.attributedText = mAttribtuedText
				}
				else {
					text = key.localized
				}
			}
		}
	}
	
	@IBInspectable var localizedPlaceholder: String? {
		get {
			return placeholder
		}
		set {
			if let key = newValue {
				placeholder = key.localized
			}
		}
	}
}
