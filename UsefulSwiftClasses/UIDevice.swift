//
//  UIDevice.swift
//
//  Created by usagimaru on 2016.12.30.
//  Copyright © 2016 usagimaru. All rights reserved.
//

import UIKit

extension UIDevice {
	
	// デバイスモデル番号を取得
	var deviceModel: String {
		get {
			var systemInfo = utsname()
			uname(&systemInfo)
			
			let mirror = Mirror(reflecting: systemInfo.machine)
			var identifier = ""
			
			for child in mirror.children {
				if let value = child.value as? Int8, value != 0 {
					identifier += String(UnicodeScalar(UInt8(value)))
				}
			}
			return identifier
		}
	}
	
}
