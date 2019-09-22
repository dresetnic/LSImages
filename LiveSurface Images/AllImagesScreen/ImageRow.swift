//
//  ImageRow.swift
//  LiveSurface Images
//
//  Created by Dragos Resetnic on 22/09/2019.
//  Copyright © 2019 Dragos Resetnic. All rights reserved.
//

import SwiftUI

struct ImageRow: View {
    private let rowInfo: RowInfo
    
    init(viewModel: RowInfo) {
        self.rowInfo = viewModel
    }
    
    var body: some View {
        HStack {
            ForEach(rowInfo.rowsItems){ item in
                Box(viewModel: item).padding(20)
            }
        }
    }
}

struct Box: View {    
    private let model: ImageRowViewModel
    
    var body: some View {
        VStack{
            Image("lookup").resizable().scaledToFit().cornerRadius(2)
            Text(model.name).font(.headline)
        }
    }
    
    init (viewModel: ImageRowViewModel){
        model = viewModel
    }
}
