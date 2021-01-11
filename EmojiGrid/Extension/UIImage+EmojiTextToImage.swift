//
//  UIImage+EmojiTextToImage.swift
//  SFGrid
//
//  Created by Makwan BK on 2021-01-11.
//

import Foundation
import UIKit

extension String {
    func image() -> UIImage? {
        let size = CGSize(width: 26, height: 26)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        UIColor.clear.set()
        let rect = CGRect(origin: .zero, size: size)
        UIRectFill(CGRect(origin: .zero, size: size))
        (self as AnyObject).draw(in: rect, withAttributes: [.font: UIFont.systemFont(ofSize: 24)])
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
