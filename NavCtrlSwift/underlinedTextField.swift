//
//  underlinedTextField.swift
//  NavCtrlSwift
//
//  Created by Alexander Lindsay on 8/15/16.
//  Copyright © 2016 Alexander Lindsay. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class underlinedTextField : UITextField {
    
    override func drawRect(rect: CGRect) {
        
        let startingPoint   = CGPoint(x: rect.minX, y: rect.maxY )
        let endingPoint     = CGPoint(x: rect.maxX, y: rect.maxY )
        
        let path = UIBezierPath()
        
        path.moveToPoint(startingPoint)
        path.addLineToPoint(endingPoint)
        path.lineWidth = 1.0
        
        UIColor.lightGrayColor().setStroke()
        path.stroke()
        path.closePath()
    }
}