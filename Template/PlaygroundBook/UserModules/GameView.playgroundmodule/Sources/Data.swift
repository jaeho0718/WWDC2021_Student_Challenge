//
//  Zposition_Structure.swift
//  PlaygroundBook
//
//  Created by Lee Jaeho on 2021/04/10.
//

import Foundation
import UIKit

struct Layer{
    //GameScene ZPosition
    static let background : CGFloat = 0
    static let particle : CGFloat = 1
    static let launchpad: CGFloat = 2
    static let touch : CGFloat = 3
    static let block : CGFloat = 4
    static let score : CGFloat = 5
}

struct BitMask{
    static let Block : UInt32 = 1
    static let Touch : UInt32 = 2
    
}
