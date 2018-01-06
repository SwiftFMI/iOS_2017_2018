//
//  PhotoLibrary.swift
//  PhotoLibraryDemo
//
//  Created by Dragomir Ivanov on 6.01.18.
//  Copyright © 2018 Swift FMI. All rights reserved.
//

import Foundation
import Photos

fileprivate protocol ImageRepresentable {
    var asset: PHAsset? { get }
    var size: CGSize { get }
}

public struct Photo {
    fileprivate let phAsset: PHAsset
}

extension Photo: ImageRepresentable {
    var asset: PHAsset? {
        return phAsset
    }
    
    var size: CGSize {
        return CGSize(width: 100, height: 100)
    }
}

public struct Album {
    let photos: [Photo]
    let title: String
    
    var thumbnailPhoto: Photo? {
        return photos.first
    }
    
    fileprivate init?(collection: PHAssetCollection?) {
        guard let assetCollection = collection else { return nil }
        let result = PHAsset.fetchAssets(in: assetCollection, options: nil)
        
        guard result.count != 0 else {
            return nil
        }
        
        var photos = [Photo]()
        
        result.enumerateObjects { (asset, index, stop) in
            photos.append(Photo(phAsset: asset))
        }
        
        self.photos = photos
        self.title = assetCollection.localizedTitle ?? "Album"
    }
}

extension Album: ImageRepresentable {
    var asset: PHAsset? {
        return thumbnailPhoto?.phAsset
    }
    
    var size: CGSize {
        return CGSize(width: 75, height: 75)
    }
}

public final class PhotoLibrary {
    public static let library = PhotoLibrary()
    private init() {}
    
    private (set) var albums: [Album]?
    
    func loadAlbums(completionHandler: @escaping () -> Void) {
        guard PHPhotoLibrary.authorizationStatus() != .notDetermined else {
            PHPhotoLibrary.requestAuthorization() { [weak self] status in
                self?.loadAlbums(completionHandler: completionHandler)
            }
            
            return
        }
        
        DispatchQueue.global().async { [weak self] in
            var albums = [Album?]()
            
            func getSmartAlbum(of type: PHAssetCollectionSubtype) -> PHAssetCollection? {
                return PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: type, options: nil).firstObject
            }
            
            let all = Album(collection: getSmartAlbum(of: .smartAlbumUserLibrary))
            albums.append(all)
            
            let favorites = Album(collection: getSmartAlbum(of: .smartAlbumFavorites))
            albums.append(favorites)
            
            let selfies = Album(collection: getSmartAlbum(of: .smartAlbumSelfPortraits))
            albums.append(selfies)
            
            let screenshots = Album(collection: getSmartAlbum(of: .smartAlbumScreenshots))
            albums.append(screenshots)
            
            let userAlbums = PHCollectionList.fetchTopLevelUserCollections(with: nil)
            
            userAlbums.enumerateObjects { (collection, index, stop) in
                let userAlbum = Album(collection: collection as? PHAssetCollection ?? nil)
                albums.append(userAlbum)
            }
            
            self?.albums = albums.flatMap { $0 }
            
            DispatchQueue.main.async {
                completionHandler()
            }
        }
    }
}

public extension PhotoLibrary {
    private static var photoOptions: PHImageRequestOptions = {
        let options = PHImageRequestOptions()
        options.deliveryMode = .opportunistic
        options.isNetworkAccessAllowed = true
        options.isSynchronous = true
        
        return options
    }()
    
    private static let requestQueue = DispatchQueue(label: "photos.demo.queue")
    
    static func requestImage(for photo: Photo, targetSize: CGSize? = nil, resultHandler: @escaping (UIImage?, [AnyHashable : Any]?) -> Void) {
        PhotoLibrary.requestQueue.async {
            executeImageRequest(for: photo, targetSize: targetSize, options: PhotoLibrary.photoOptions, resultHandler: { (image, info) in
                DispatchQueue.main.async {
                    resultHandler(image, info)
                }
            })
        }
    }
    
    private static var thumbnailOptions: PHImageRequestOptions = {
        let options = PHImageRequestOptions()
        options.deliveryMode = .opportunistic
        options.resizeMode = .exact
        options.isNetworkAccessAllowed = true
        
        return options
    }()
    
    static func requestThumbnail(for album: Album, targetSize: CGSize? = nil, resultHandler: @escaping (UIImage?, [AnyHashable : Any]?) -> Void) {
        
        guard let asset = album.thumbnailPhoto?.phAsset else { return }
        
        let scale = CGAffineTransform(scaleX: CGFloat(1.0) / CGFloat(asset.pixelWidth), y: CGFloat(1.0) / CGFloat(asset.pixelHeight))
        
        let cropSideLength = min(asset.pixelWidth, asset.pixelHeight)
        let square = CGRect(x: 0, y: 0, width: cropSideLength, height: cropSideLength)
        
        let cropRect = square.applying(scale)
        
        let options = PhotoLibrary.thumbnailOptions
        options.normalizedCropRect = cropRect
        
        executeImageRequest(for: album, targetSize: targetSize, options: options, resultHandler: resultHandler)
    }
    
    private static func executeImageRequest(for imageRepresentable: ImageRepresentable, targetSize: CGSize? = nil, options: PHImageRequestOptions, resultHandler: @escaping (UIImage?, [AnyHashable : Any]?) -> Void) {
        
        guard let asset = imageRepresentable.asset else { return }
        
        let size = targetSize ?? imageRepresentable.size
        
        PHCachingImageManager.default().requestImage(for: asset, targetSize: size, contentMode: .aspectFill, options: options, resultHandler: resultHandler)
    }
}
