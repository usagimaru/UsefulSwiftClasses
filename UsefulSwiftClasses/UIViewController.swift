//
//  UIViewController.swift
//
//  Created by usagimaru on 2016.12.30.
//  Copyright © 2016 usagimaru. All rights reserved.
//

import UIKit
import ObjectiveC

private var viewWillAppearOnce: UInt8 = 0
private var viewDidAppearOnce: UInt8 = 0

extension UIViewController {
	
	private var viewWillAppearingFlag: Bool {
		get {
			if let v = objc_getAssociatedObject(self, &viewWillAppearOnce) as? Bool {
				return v
			}
			return false
		}
		set {
			objc_setAssociatedObject(self, &viewWillAppearOnce, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
		}
	}
	
	private var viewDidAppearingFlag: Bool {
		get {
			if let v = objc_getAssociatedObject(self, &viewDidAppearOnce) as? Bool {
				return v
			}
			return false
		}
		set {
			objc_setAssociatedObject(self, &viewDidAppearOnce, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
		}
	}
	
	
	override open class func initialize() {
		swizzle()
	}
	
	private class func swizzle() {
		let origSel_viewWillAppear = #selector(viewWillAppear(_:))
		let origSel_viewDidAppear = #selector(viewDidAppear(_:))
		let origMethod_viewWillAppear = class_getInstanceMethod(self, origSel_viewWillAppear)
		let origMethod_viewDidAppear = class_getInstanceMethod(self, origSel_viewDidAppear)
		
		let swizzledSel_viewWillAppear = #selector(s_viewWillAppear(_:))
		let swizzledSel_viewDidAppear = #selector(s_viewDidAppear(_:))
		let swizzled_viewWillAppear = class_getInstanceMethod(self, swizzledSel_viewWillAppear)
		let swizzled_viewDidAppear = class_getInstanceMethod(self, swizzledSel_viewDidAppear)
		
		if class_addMethod(self, swizzledSel_viewWillAppear, method_getImplementation(swizzled_viewWillAppear), method_getTypeEncoding(swizzled_viewWillAppear)) {
			class_addMethod(self, origSel_viewWillAppear, method_getImplementation(origMethod_viewWillAppear), method_getTypeEncoding(origMethod_viewWillAppear))
		}
		else {
			method_exchangeImplementations(origMethod_viewWillAppear, swizzled_viewWillAppear)
		}
		
		if class_addMethod(self, swizzledSel_viewDidAppear, method_getImplementation(swizzled_viewDidAppear), method_getTypeEncoding(swizzled_viewDidAppear)) {
			class_addMethod(self, origSel_viewDidAppear, method_getImplementation(origMethod_viewDidAppear), method_getTypeEncoding(origMethod_viewDidAppear))
		}
		else {
			method_exchangeImplementations(origMethod_viewDidAppear, swizzled_viewDidAppear)
		}
	}
	
	@objc private func s_viewWillAppear(_ animated: Bool) {
		self.s_viewWillAppear(animated)
		
		if !viewWillAppearingFlag {
			viewWillAppearingFlag = true
			viewWillAppear_once(animated)
		}
	}
	
	@objc private func s_viewDidAppear(_ animated: Bool) {
		self.s_viewDidAppear(animated)
		
		if !viewDidAppearingFlag {
			viewDidAppearingFlag = true
			viewDidAppear_once(animated)
		}
		
		for v in view.subviews where v is UIScrollView {
			(v as? UIScrollView)?.flashScrollIndicators()
		}
	}
	
	func viewWillAppear_once(_ animated: Bool) {
	}
	
	func viewDidAppear_once(_ animated: Bool) {
	}
	
	
	@IBInspectable var localizedTitle: String? {
		get {
			return title
		}
		set {
			if let key = newValue {
				title = key.localized
			}
		}
	}
	
	/// Reset device orientation and ViewController orientation.
	class func resetDeviceOrientation(_ orientation: UIInterfaceOrientation) {
		
		// Interface orientation -> Device orientation
		func deviceOrientationFor(interfaceOrientation: UIInterfaceOrientation) -> UIDeviceOrientation {
			switch interfaceOrientation {
			case .portrait:
				return UIDeviceOrientation.portrait
			case .portraitUpsideDown:
				return UIDeviceOrientation.portraitUpsideDown
			case .landscapeLeft:
				return UIDeviceOrientation.landscapeRight
			case .landscapeRight:
				return UIDeviceOrientation.landscapeLeft
			default:
				return UIDeviceOrientation.unknown
			}
		}
		
		let deviceOrientation = deviceOrientationFor(interfaceOrientation: orientation)
		
		// http://stackoverflow.com/questions/26357162/how-to-force-view-controller-orientation-in-ios-8
		UIDevice.current.setValue(NSNumber(integerLiteral: deviceOrientation.rawValue), forKey: "orientation")
		UIViewController.attemptRotationToDeviceOrientation()
	}
	
	/// Back button without the title
	func setBackBarButtonItemStyle() {
		navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
	}
	
}
