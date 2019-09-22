//
//  ImageRowViewModel.swift
//  CombineTest
//
//  Created by Dragos Resetnic on 22/09/2019.
//  Copyright © 2019 Dragos Resetnic. All rights reserved.
//

import Foundation
import SwiftUI

struct ImageRowViewModel: Identifiable {
    
    private let imageInfo: ImageInfo
    
    var id: String {
        return imageInfo.image
    }
    
    var name: String {
        return imageInfo.name
    }
    
    var category: String {
        #warning("Implement Category")
        return "Implement Category"
    }
    
    var version: String {
        return imageInfo.version
    }
    
    init(item: ImageInfo) {
        self.imageInfo = item
    }
}

extension ImageRowViewModel: Hashable {
    static func == (lhs: ImageRowViewModel, rhs: ImageRowViewModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
}

struct RowInfo: Identifiable{
    
    var rowsItems: [ImageRowViewModel]
    var section: Int
    
    init(rowsItems: [ImageRowViewModel], section: Int) {
        self.rowsItems = rowsItems
        self.section = section
    }
    
    var id: String {
         return String(section)
     }
}
