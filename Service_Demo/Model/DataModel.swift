//
//  DataModel.swift
//  Service_Demo
//
//  Created by Tong Yi on 5/28/20.
//  Copyright © 2020 Tong Yi. All rights reserved.
//

import Foundation

struct Items: Codable
{
    var title: String
    var author: String
    var media: Media
}

struct Media: Codable
{
    var imageURL: URL?
    enum CodingKeys: String, CodingKey
    {
        case imageURL = "m"
    }
}

struct Flickr: Codable
{
    var items: [Items]
}
