//
//  Model.swift
//  InstagramFeedNativeDemo
//
//  Created by Emil Atanasov on 10.01.18.
//  Copyright © 2018 SwiftFMI. All rights reserved.
//

import Foundation

//TODO: image dimentions MUST be in the model
class FeedItem: Codable {
    var avatar:Avatar?
    var image:String?
    var imageWidth: Int?
    var imageHeight: Int?
    var likes:Int?
    var comments:[Comment]?
}

class Avatar: Codable {
    var name:String?
    var url:String?
}

class Comment: Codable {
    var id:Int?
    var text:String?
}
