//
//  AllImagesViewModel.swift
//  CombineTest
//
//  Created by Dragos Resetnic on 22/09/2019.
//  Copyright © 2019 Dragos Resetnic. All rights reserved.
//

import SwiftUI
import Combine

class AllImagesViewModel: ObservableObject{
    
    @Published var dataSource: [ImageRowViewModel] = []
    
    private let liveSurfaceImageFetcher: LiveSurfaceImagesFetchable
    
    private var disposables = Set<AnyCancellable>()
    
    init(imagesFetcher: LiveSurfaceImagesFetchable){
        self.liveSurfaceImageFetcher = imagesFetcher
    }
    
    func fetchImages(){
        
        liveSurfaceImageFetcher.allImages()
            .map { response in
                response.images.values.map { item in ImageRowViewModel.init(item: item) }
        }
        .receive(on: DispatchQueue.main)
        .sink(
                receiveCompletion: { [weak self] value in
                    guard let self = self else { return }
                    switch value {
                    case .failure:
                        // 6
                        self.dataSource = []
                    case .finished:
                        break
                    }
                },
                receiveValue: { [weak self] imagesInfo in
                    guard let self = self else { return }
                    self.dataSource = imagesInfo
                    // 7
            })

            // 8
            .store(in: &disposables)
        
        
    }
}
