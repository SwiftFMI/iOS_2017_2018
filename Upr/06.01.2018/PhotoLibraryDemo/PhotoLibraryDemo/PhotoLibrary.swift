//
//  PhotoLibrary.swift
//  PhotoLibraryDemo
//
//  Created by Dragomir Ivanov on 6.01.18.
//  Copyright © 2018 Swift FMI. All rights reserved.
//

import Foundation
import Photos

struct Photo {
    
}

struct Album {
    let photos: [Photo]
    let title: String
    
    var thumbnailPhoto: Photo? {
        return photos.first
    }
}

public final class PhotoLibrary {
    public static let library = PhotoLibrary()
    private init() {}
    
    private (set) var albums: [Album]?
    
    
}
