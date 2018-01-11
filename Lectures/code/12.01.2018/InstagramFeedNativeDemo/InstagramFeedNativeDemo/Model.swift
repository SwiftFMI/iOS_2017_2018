//
//  Model.swift
//  InstagramFeedNativeDemo
//
//  Created by Emil Atanasov on 10.01.18.
//  Copyright © 2018 SwiftFMI. All rights reserved.
//

import Foundation

class FeedItem: Codable {
    var avatar:Avatar?
    var image:String?
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
