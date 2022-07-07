//
//  ArrayExt.swift
//  Memorize
//
//  Created by Anderson Chen on 2022/7/6.
//

import Foundation

extension Array {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
