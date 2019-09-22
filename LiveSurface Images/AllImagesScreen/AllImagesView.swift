//
//  AllImagesView.swift
//  LiveSurface Images
//
//  Created by Dragos Resetnic on 22/09/2019.
//  Copyright © 2019 Dragos Resetnic. All rights reserved.
//

import SwiftUI

struct AllImagesView: View {
    
    @ObservedObject var viewModel: AllImagesViewModel
    
    init(viewModel: AllImagesViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
            List {
                if viewModel.dataSource.isEmpty {
                    emptySection
                } else {
                    imagesSection
                }
            }
            .listStyle(PlainListStyle())
    }
}

private extension AllImagesView {
    var emptySection: some View {
        Section {
            Text("No images")
                .foregroundColor(.red)
        }
    }
    
    var imagesSection: some View {
        Section {
            ForEach(viewModel.dataSource){ model in
                ImageRow(viewModel: model)
            }
        }
    }
}

