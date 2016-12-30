//
//  UILabel.swift
//
//  Created by usagimaru on 2016.12.30.
//  Copyright © 2016 usagimaru. All rights reserved.
//
//

import UIKit

extension UILabel {
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
}
