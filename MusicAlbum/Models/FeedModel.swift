//
//  FeedModel.swift
//  MusicAlbum
//
//  Created by Sameer on 25/07/22.
//

import Foundation

class FeedModel: NSObject, Codable {
    
    var title, id, copyright, country, icon, updated: String?
    var results: [MusicModel]?

    enum CodingKeys: String, CodingKey {
        case title, id, copyright, country, icon, updated
        case results
    }
}


class MusicModel: NSObject, Codable {
    var artistName, id, name, releaseDate, kind, artistId, artistUrl, contentAdvisoryRating, artworkUrl100, url: String?
    var genres: [GenresModel]?
    
    enum CodingKeys: String, CodingKey {
        case artistName, id, name, releaseDate, kind, artistId, artistUrl, contentAdvisoryRating, artworkUrl100, url
        case genres
    }
}


class GenresModel: NSObject, Codable {
    
    var genreId, name, url: String?

    enum CodingKeys: String, CodingKey {
        case genreId, name, url
    }
}
