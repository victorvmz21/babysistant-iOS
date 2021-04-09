//
//  printExtension.swift
//  Babysistant
//
//  Created by Victor Monteiro on 4/9/21.
//

import Foundation

func print(_ items: Any..., separator: String = " ", terminator: String = "\n") {
    #if DEBUG
    items.forEach {
        Swift.print("㏒ ✅ ",$0, separator: separator, terminator: terminator)
    }
    #endif
}
