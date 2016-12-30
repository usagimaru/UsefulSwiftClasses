//
//  UITabBarController.swift
//
//  Created by usagimaru on 2016.12.30.
//  Copyright © 2016 usagimaru. All rights reserved.
//

import UIKit

extension UITabBarController {
	
	open override var shouldAutorotate: Bool {
		guard let vc = self.viewControllers else {
			return true
		}
		return vc[selectedIndex].shouldAutorotate
	}
	
	open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
		guard let selected = selectedViewController else {
			return .allButUpsideDown
		}
		
		return selected.supportedInterfaceOrientations
	}
	
}
