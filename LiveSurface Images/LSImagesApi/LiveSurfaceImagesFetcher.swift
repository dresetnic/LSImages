//
//  ImagesFetcher.swift
//  CombineTest
//
//  Created by Dragos Resetnic on 22/09/2019.
//  Copyright © 2019 Dragos Resetnic. All rights reserved.
//

import Foundation
import Combine

protocol LiveSurfaceImagesFetchable {
    func allImages() -> AnyPublisher<LiveSurfaceImagesResponse, LiveSurfaceImagesError>
}

class LiveSurfaceImagesFetcher {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
}

extension LiveSurfaceImagesFetcher: LiveSurfaceImagesFetchable {
    
    func allImages() -> AnyPublisher<LiveSurfaceImagesResponse, LiveSurfaceImagesError>{
        return images(with: makeAllImagesComponents())
    }
    
    private func images<T>(
        with components: URLComponents
    ) -> AnyPublisher<T, LiveSurfaceImagesError> where T: Decodable {
        guard let url = components.url else {
            let error = LiveSurfaceImagesError.network(description: "Couldn't create URL")
            return Fail(error: error).eraseToAnyPublisher()
        }
        return session.dataTaskPublisher(for: URLRequest(url: url))
            .mapError { error in
                .network(description: error.localizedDescription)
        }
        .flatMap(maxPublishers: .max(1)) { pair in
            jsonDecode(pair.data)
        }
        .eraseToAnyPublisher()
    }
}

// MARK: - Livesurface API
extension LiveSurfaceImagesFetcher {
    struct ImagesAPI {
        static let scheme = "https"
        static let host = "www.livesurface.com"
        static let apiPath = "/test/api/images.php"
        static let imagePath = "/test/images/"
        static let key = "b0cd42d8-cc04-4127-ae3a-9605dc0e9f91"
    }
    
    func makeAllImagesComponents() -> URLComponents {
        var components = URLComponents()
        components.scheme = ImagesAPI.scheme
        components.host = ImagesAPI.host
        components.path = ImagesAPI.apiPath
        
        components.queryItems = [
            //            URLQueryItem(name: "pro", value: "1"),
            URLQueryItem(name: "key", value: ImagesAPI.key)
        ]
        return components
    }
}
