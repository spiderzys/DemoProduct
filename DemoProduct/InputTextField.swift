//
//  InputTextField.swift
//  DemoProduct
//
//  Created by YANGSHENG ZOU on 2016-08-12.
//  Copyright © 2016 YANGSHENG ZOU. All rights reserved.
//

import UIKit

class InputTextField: UITextField {

  
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
 
    
    override func drawRect(rect: CGRect) {
        // Drawing code
        let context =  UIGraphicsGetCurrentContext()
        CGContextSetFillColorWithColor(context, UIColor.yellowColor().CGColor)
        CGContextFillRect(context,CGRectMake(0, frame.height - 1, frame.width, 1))
        
        
    }

}
