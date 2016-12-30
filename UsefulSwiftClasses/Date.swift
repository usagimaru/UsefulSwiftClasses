//
//  Date.swift
//
//  Created by usagimaru on 2016.12.30.
//  Copyright © 2016 usagimaru. All rights reserved.
//

import Foundation

extension Date {
	
	static func date(fromISO8601String string: String) -> Date? {
		let f = DateFormatter()
		f.locale = Locale(identifier: "en_US_POSIX")
		f.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
	
		return f.date(from: string)
	}
	
	func weekdaySymbol(_ identifier: String) -> String {
		let f = DateFormatter()
		f.locale = Locale(identifier: identifier)
		
		let cmp = Calendar.current.dateComponents([.weekday], from: self)
		return f.weekdaySymbols[cmp.weekday! - 1]
	}
	
	func shortWeekdaySymbol() -> String {
		let f = DateFormatter()
		f.locale = Locale(identifier: "ja_JP")
		let cmp = NSCalendar.current.dateComponents([.weekday], from: self)
		return f.shortWeekdaySymbols[cmp.weekday! - 1]
	}
	
}
