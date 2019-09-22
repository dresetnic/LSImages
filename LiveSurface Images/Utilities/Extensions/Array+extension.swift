//
//  Array+extension.swift
//  LiveSurface Images
//
//  Created by Dragos Resetnic on 22/09/2019.
//  Copyright © 2019 Dragos Resetnic. All rights reserved.
//

import Foundation

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}
