//
//  NetworkIndicatorManager.swift
//
//  Created by usagimaru on 2016.12.30.
//  Copyright © 2016 usagimaru. All rights reserved.
//

import UIKit

class NetworkIndicatorManager: NSObject {
	
	private var count: Int = 0 {
		didSet {
			if count < 0 {
				count = 0
			}
			
			DispatchQueue.main.async { [weak self] in
				guard let sself = self else {return}
				
				if sself.count > 0 && UIApplication.shared.isNetworkActivityIndicatorVisible == false {
					UIApplication.shared.isNetworkActivityIndicatorVisible = true
				}
				else if sself.count == 0 && UIApplication.shared.isNetworkActivityIndicatorVisible == true {
					UIApplication.shared.isNetworkActivityIndicatorVisible = false
				}
			}
		}
	}
	
	private static let shared: NetworkIndicatorManager = {
		return NetworkIndicatorManager()
	}()
	
	private override init() {
	}
	
	class func countUp() {
		shared.count += 1
	}
	
	class func countDown() {
		shared.count -= 1
	}
}
