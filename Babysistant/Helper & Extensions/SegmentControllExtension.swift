//
//  SegmentControllExtension.swift
//  Babysistant
//
//  Created by Victor Monteiro on 4/8/21.
//

import UIKit

extension UISegmentedControl {
    
    func setTitleColor(_ color: UIColor, state: UIControl.State = .normal) {
        
        var attributes = self.titleTextAttributes(for: state) ?? [:]
        attributes[.foregroundColor] = color
        self.setTitleTextAttributes(attributes, for: state)
        
    }
    
}
