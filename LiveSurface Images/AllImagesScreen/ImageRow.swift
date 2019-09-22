//
//  ImageRow.swift
//  LiveSurface Images
//
//  Created by Dragos Resetnic on 22/09/2019.
//  Copyright © 2019 Dragos Resetnic. All rights reserved.
//

import SwiftUI
import Combine

struct ImageRow: View {
    private let rowInfo: RowInfo
    private let parentGeometry: GeometryProxy
    var rect: CGRect
    
    init(viewModel: RowInfo, geometry: GeometryProxy) {
        self.rowInfo = viewModel
        self.parentGeometry = geometry
        self.rect = geometry.frame(in: .global)
    }
    
    var body: some View {
        HStack {
            ForEach(rowInfo.rowsItems){ item in
                self.makeView(item: item, geometry: self.parentGeometry)
            }
        }
    }
    
    func makeView(item: ImageRowViewModel, geometry: GeometryProxy) -> some View {
        let minSize = rect.width * 0.33
        return Box(viewModel: item).frame(width: minSize, height: minSize, alignment: .bottom)
    }
}

struct Box: View {    
    private let model: ImageRowViewModel
    
    var body: some View {
        VStack{
            Spacer()
            ImageViewContainer(imageUrl: "https://www.livesurface.com/test/images/\(model.fileName)")
            Spacer()
            Text(model.name).font(.headline)
            Spacer()
        }
    }
    
    init (viewModel: ImageRowViewModel){
        model = viewModel
    }
}

struct ImageViewContainer: View {
    @ObservedObject var remoteImageURL: RemoteImageURL
    
    init(imageUrl: String) {
        remoteImageURL = RemoteImageURL(imageURL: imageUrl)
    }
    
    var body: some View {
        Image(uiImage: UIImage(data: remoteImageURL.data) ?? UIImage())
            .resizable()
            .scaledToFit()
    }
}

class RemoteImageURL: ObservableObject {
    var didChange = PassthroughSubject<Data, Never>()
    @Published var data = Data() {
        didSet {
            didChange.send(data)
        }
    }
    init(imageURL: String) {
        guard let url = URL(string: imageURL) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            DispatchQueue.main.async { self.data = data }
        }.resume()
    }
}
