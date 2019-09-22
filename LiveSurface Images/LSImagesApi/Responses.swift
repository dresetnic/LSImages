//
//  Responses.swift
//  CombineTest
//
//  Created by Dragos Resetnic on 22/09/2019.
//  Copyright © 2019 Dragos Resetnic. All rights reserved.
//

import Foundation

struct ImageDownloadResponse: Codable {
    let name: String
    let data: Data
}

struct LiveSurfaceImagesResponse: Codable {
    let images: [String: ImageInfo]
}

// MARK: - Image
struct ImageInfo: Codable {
    let index: Int
    let name, number, image: String
    let category: Category
    let version: String
    let tags: Tags
}

enum Category: String, Codable {
    case categoryDefault = "category.default"
}

// MARK: - Tags
struct Tags: Codable {
    let sizedescription: Sizedescription
    let sizescale, sizewidth, sizewidtharc, sizeheight: String
    let sizeheightarc, sizedepth, sizedeptharc: String
    let sizeunits: Sizeunits
}

enum Sizedescription: String, Codable {
    case a7 = "A7"
    case empty = ""
}

enum Sizeunits: String, Codable {
    case empty = ""
    case mm = "mm"
    case sizeunitsIn = "in"
}
