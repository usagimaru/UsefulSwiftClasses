//
//  UINavigationController.swift
//
//  Created by usagimaru on 2016.12.30.
//  Copyright © 2016 usagimaru. All rights reserved.
//

import UIKit

extension UINavigationController {
	
	open override var shouldAutorotate: Bool {
		guard let vc = self.visibleViewController else {
			return true
		}
		
		return vc.shouldAutorotate
	}
	
	open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
		guard let vc = visibleViewController else {
			return .allButUpsideDown
		}
		
		return vc.supportedInterfaceOrientations
	}
	
}
