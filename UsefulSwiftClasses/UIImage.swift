//
//  UIImage.swift
//
//  Created by usagimaru on 2016.12.30.
//  Copyright © 2016 usagimaru. All rights reserved.
//

import UIKit

extension UIImage {
	
	/// 色で塗りつぶした新たなイメージを描画
	func imageWith(_ color: UIColor) -> UIImage? {
		UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
		
		let bounds = CGRect(x: 0, y: 0, width: size.width, height: size.height)
		let context = UIGraphicsGetCurrentContext()
		
		draw(in: bounds)
		context?.setBlendMode(.sourceAtop)
		context?.setFillColor(color.cgColor)
		context?.fill(bounds)
		
		let renderedImage = UIGraphicsGetImageFromCurrentImageContext()
		
		UIGraphicsEndImageContext()
		
		return renderedImage
	}
	
	/// 透過を変えたイメージを描画
	func translucentImageWith(alpha: CGFloat) -> UIImage? {
		UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
		
		let bounds = CGRect(x: 0, y: 0, width: size.width, height: size.height)
		
		draw(in: bounds, blendMode: .normal, alpha: alpha)
		
		let image = UIGraphicsGetImageFromCurrentImageContext()
		
		UIGraphicsEndImageContext()
		
		return image
	}
	
}
