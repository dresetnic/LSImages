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
    
    @Published var dataSource: [RowInfo] = []
    @Published var imagesCache: [String: UIImage] = [:]
    
    private let liveSurfaceImageFetcher: LiveSurfaceImagesFetchable
    
    private var disposables = Set<AnyCancellable>()
    
    init(
        imageFetcher: LiveSurfaceImagesFetchable,
        scheduler: DispatchQueue = DispatchQueue(label: "AllImagesViewModel")
    ) {
        self.liveSurfaceImageFetcher = imageFetcher
        fetchImages()
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
                    self.dataSource = []
                case .finished:
                    break
                }
            },
            receiveValue: { [weak self] imagesInfo in
                guard let self = self else { return }
                
                let chunkedData = imagesInfo.chunked(into: 3)
                
                var chunkId = 0
                var result:[RowInfo] = []
                for chunk in chunkedData {
                    result.append(RowInfo(rowsItems: chunk, section: chunkId))
                    chunkId += 1
                }
                self.dataSource = result
        })
            .store(in: &disposables)
    }
}
