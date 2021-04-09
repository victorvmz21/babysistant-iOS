//
//  ButtonExtension.swift
//  Babysistant
//
//  Created by Victor Monteiro on 4/8/21.
//

import UIKit

extension UIButton {
    
    func roundAllEdges() {
        
        self.layer.cornerRadius = self.layer.frame.height / 2
        self.layer.masksToBounds = true
        
    }
    
}
