//
//  ImagesError.swift
//  CombineTest
//
//  Created by Dragos Resetnic on 22/09/2019.
//  Copyright © 2019 Dragos Resetnic. All rights reserved.
//

import Foundation

enum LiveSurfaceImagesError: Error {
  case parsing(description: String)
  case network(description: String)
}
