//
//  Primitive.swift
//
//  Created by usagimaru on 2016.12.30.
//  Copyright © 2016 usagimaru. All rights reserved.
//

import Foundation

extension Int {
	
	/// 指定ロケールでの価格
	func priceStringAs(_ localeIdentifier: String) -> String? {
		let f = NumberFormatter()
		f.numberStyle = .currency
		f.locale = Locale(identifier: localeIdentifier)
		return f.string(from: NSNumber(value: self))
	}
	
	/// 日本円¥の価格
	func priceStringAsJPY() -> String? {
		return priceStringAs("ja_JP")
	}
	
}

extension Double {
	
	/// 指定ロケールでの価格
	func priceStringAs(_ localeIdentifier: String) -> String? {
		let f = NumberFormatter()
		f.numberStyle = .currency
		f.locale = Locale(identifier: localeIdentifier)
		return f.string(from: NSNumber(value: self))
	}
	
	/// 日本円¥の価格
	func priceStringAsJPY() -> String? {
		return priceStringAs("ja_JP")
	}
	
}
